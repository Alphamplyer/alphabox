
import 'package:alphabox/reading_notations/domain/entities/reading_notation_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateReadingNotationController extends ChangeNotifier {
  bool isLoading = true;
  ReadingNotationConfig? config;

  Map<String, TextEditingController> textControllers = {};
  Map<String, ValueNotifier<bool>> booleanValues = {};
  List<String> notationFieldsKeys = [];

  Future<void> loadConfig() async {
    config = await ReadingNotationConfig.load();
    _initializeNotationFieldsValues(config!.fields);
    isLoading = false;
    notifyListeners();
  }

  void _initializeNotationFieldsValues(List<NotationField> fields) {
    for (final field in fields) {
      switch (field.type) {
        case NotationType.url:
        case NotationType.text:
          textControllers[field.name] = TextEditingController();
          break;
        case NotationType.boolean:
          booleanValues[field.name] = ValueNotifier(false);
          break;
        case NotationType.category:
          if ((field as CategoryNotationField).rated) {
            notationFieldsKeys.add(field.name);
            textControllers[field.name] = TextEditingController(text: "0");
          }
          _initializeNotationFieldsValues(field.children);
          break;
      }
    }
  }

  void updateBooleanValue(String key, dynamic value) {
    booleanValues[key]!.value = value;
  }

  void validateNotation(String key, String value) {
    int notation = int.tryParse(value) ?? 0;
    notation = notation.clamp(0, 100);
    if (notation.toString() != value) {
      textControllers[key]!.text = notation.toString();
    }
  }
  
  void copyToClipboard() {
    final buffer = _generateMarkdown();
    final data = ClipboardData(text: buffer.toString());
    Clipboard.setData(data);
  }

  StringBuffer _generateMarkdown() {
    final buffer = StringBuffer();
    buffer.writeln('# [${textControllers['title']!.text}](${textControllers['link']!.text}) (${_getGlobalNotation()}/100)');
    for (final field in config!.fields.skip(2)) {
      _generateFieldMarkdown(buffer, field);
    }
    return buffer;
  }

  StringBuffer _generateFieldMarkdown(StringBuffer buffer, NotationField field, { int indent = 0 }) {    
    switch (field.type) {
      case NotationType.url:
      case NotationType.text:
        return _generateTextMarkdown(buffer, field as TextNotationField, indent: indent);
      case NotationType.boolean:
        return _generateBooleanMarkdown(buffer, field as BooleanNotationField, indent: indent);
      case NotationType.category:
        return _generateCategoryMarkdown(buffer, field as CategoryNotationField, indent: indent);
    }
  }

  StringBuffer _generateTextMarkdown(StringBuffer buffer, TextNotationField field, {int indent = 0}) {    
    _generateIndent(indent, buffer);
    buffer.write('${field.label} : ');
    buffer.writeln('*${textControllers[field.name]!.text}*');
    return buffer;
  }

  void _generateIndent(int indent, StringBuffer buffer) {    
    if (indent > 0) {
      buffer.write('- ');
    }
  }

  int _getGlobalNotation() {
    List<int> values = notationFieldsKeys.map((key) => int.tryParse(textControllers[key]!.text) ?? 0).toList();
    if (values.isEmpty) {
      return 0;
    }
    return values.reduce((total, notation) => total + notation) ~/ values.length;
  }
  
  StringBuffer _generateBooleanMarkdown(StringBuffer buffer, BooleanNotationField field, {required int indent}) {
    _generateIndent(indent, buffer);
    buffer.write('${field.label} : ');
    buffer.writeln('**${booleanValues[field.name]!.value ? 'Oui' : 'Non'}**');
    return buffer;
  }
  
  StringBuffer _generateCategoryMarkdown(StringBuffer buffer, CategoryNotationField field, {required int indent}) {
    _generateCategoryIndent(indent, buffer);
    buffer.write(field.label);
    if (field.rated) {
      buffer.write(' **(${textControllers[field.name]!.text}/100)**');
    }
    buffer.writeln(" :");
    
    for (final child in field.children) {
      _generateFieldMarkdown(buffer, child, indent: indent + 1);
    }

    return buffer;
  }

  void _generateCategoryIndent(int indent, StringBuffer buffer) {
    var indentSpaces = "##";
    if (indent > 0) {
      indentSpaces += "#" * indent;
    }
    buffer.write('$indentSpaces ');
  }
}