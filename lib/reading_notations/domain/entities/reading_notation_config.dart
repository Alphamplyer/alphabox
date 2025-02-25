
import 'dart:convert';

import 'package:flutter/services.dart';

class ReadingNotationConfig {
  final List<NotationField> fields;

  ReadingNotationConfig({
    required this.fields
  });

  factory ReadingNotationConfig.fromMap(Map<String, dynamic> map) {
    List<NotationField> fields = [];
    for (final child in map['notationFields']) {
      fields.add(NotationField.fromMap(child));
    }
    
    return ReadingNotationConfig(
      fields: fields
    );
  }

  static Future<ReadingNotationConfig> load() async {
    final String response = await rootBundle.loadString('assets/reading_notations/config.json');
    final data = await json.decode(response);
    return ReadingNotationConfig.fromMap(data);
  }
}

class NotationField {
  final String name;
  final String label;
  final NotationType type;
  final bool isRequired;

  NotationField({
    required this.name,
    required this.label,
    required this.type,
    required this.isRequired,
  });

  factory NotationField.fromMap(Map<String, dynamic> map) {
    final type = map['type'];
    switch (type) {
      case 'text':
        return TextNotationField(
          name: map['name'],
          label: map['label'],
          multiLine: map['multiLine'] ?? false,
          isRequired: map['isRequired'] ?? false
        );
      case 'url':
        return UrlNotationField(
          name: map['name'],
          label: map['label'],
          multiLine: map['multiLine'] ?? false,
          isRequired: map['isRequired'] ?? false
        );
      case 'boolean':
        return BooleanNotationField(
          name: map['name'],
          label: map['label'],
          isRequired: map['isRequired'] ?? false
        );
      case 'category':
        List<NotationField> children = [];
        for (final child in map['children']) {
          children.add(NotationField.fromMap(child));
        }

        return CategoryNotationField(
          name: map['name'],
          label: map['label'],
          rated: map['rated'] ?? false,
          children: children,
          isRequired: map['isRequired'] ?? false
        );
      default:
        throw Exception('Invalid notation type');
    }
  }
}

class CategoryNotationField extends NotationField {
  final bool rated;
  final List<NotationField> children;

  CategoryNotationField({
    required super.name,
    required super.label,
    required this.rated,
    required this.children,
    required super.isRequired
  }) : super(
    type: NotationType.category
  );
  
}

class TextNotationField extends NotationField {
  final bool multiLine;

  TextNotationField({
    required super.name,
    required super.label,
    required this.multiLine,
    required super.isRequired
  }) : super(
    type: NotationType.text
  );
}

class UrlNotationField extends NotationField {
  final bool multiLine;
  
  UrlNotationField({
    required super.name,
    required super.label,
    required this.multiLine,
    required super.isRequired
  }) : super(
    type: NotationType.url
  );
}

class BooleanNotationField extends NotationField {
  BooleanNotationField({
    required super.name,
    required super.label,
    required super.isRequired
  }) : super(
    type: NotationType.boolean
  );
}

enum NotationType {
  text,
  url,
  boolean,
  category,
}