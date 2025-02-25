
import 'package:alphabox/reading_notations/domain/entities/reading_notation_config.dart';
import 'package:alphabox/reading_notations/presentation/configs/reading_notation_constants.dart';
import 'package:alphabox/reading_notations/presentation/controllers/create_reading_notation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateReadingNotationScreen extends StatefulWidget {
  const CreateReadingNotationScreen({super.key});

  @override
  State<CreateReadingNotationScreen> createState() => _CreateReadingNotationScreenState();
}

class _CreateReadingNotationScreenState extends State<CreateReadingNotationScreen> {
  final controller = CreateReadingNotationController();

  @override
  void initState() {
    controller.loadConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Reading Notation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: controller.copyToClipboard,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      
          return ListView.builder(
            itemCount: controller.config!.fields.length,
            itemBuilder: (context, index) {
              final field = controller.config!.fields[index];
              return _buildNotationField(field);
            },
          );
        },
      ),
    );
  }

  Widget _buildNotationField(NotationField notationField, {int indent = 0}) {
    switch (notationField.type) {
      case NotationType.text:
        return _buildTextNotationField(notationField as TextNotationField);
      case NotationType.url:
        return _buildUrlNotationField(notationField as UrlNotationField);
      case NotationType.boolean:
        return _buildBooleanNotationField(notationField as BooleanNotationField);
      case NotationType.category:
        return _buildCategoryNotationField(notationField as CategoryNotationField, indent: indent);
    }
  }

  Widget _buildTextNotationField(TextNotationField field) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.label),
          if (field.multiLine)
            TextField(
              keyboardType: TextInputType.multiline, 
              minLines: 1,
              maxLines: 5, 
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: controller.textControllers[field.name],
            ),
          if (!field.multiLine)
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: controller.textControllers[field.name],
            ),
        ],
      ),
    );
  }

  Widget _buildUrlNotationField(UrlNotationField field) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.label),
          if (field.multiLine)
            TextField(
              keyboardType: TextInputType.multiline, 
              minLines: 1,
              maxLines: 5, 
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: controller.textControllers[field.name],
            ),
          if (!field.multiLine)
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: controller.textControllers[field.name],
            ),
        ],
      ),
    );
  }

  Widget _buildBooleanNotationField(BooleanNotationField field) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(field.label),
          const SizedBox(width: 8),
          ValueListenableBuilder(
            valueListenable: controller.booleanValues[field.name]!, 
            builder:(context, value, child) {
              return Switch(
                value: value,
                onChanged: (value) => controller.updateBooleanValue(field.name, value),
              );
            },
          )
        ],
      ),
    );
  }
  
  Widget _buildCategoryNotationField(CategoryNotationField notationField, {int indent = 0}) {    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCategoryNotationFieldHeader(notationField),
          for (final child in notationField.children) _buildNotationField(child, indent: indent + 1),
        ],
      ),
    );
  }

  Widget _buildCategoryNotationFieldHeader(CategoryNotationField notationField, {int indent = 0}) {
    final TextStyle textStyle = TextStyle(
      fontSize: _getCategoryFontSize(indent),
      fontWeight: FontWeight.bold
    );

    return Row(
      children: [
        Flexible(
          child: Text(
            notationField.label,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          )
        ),
        if (notationField.rated) 
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 16),
              SizedBox(
                width: 75,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller.textControllers[notationField.name],
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => controller.validateNotation(notationField.name, value),
                  style: textStyle,
                ),
              ),
              Text(
                ' / 100',
                style: textStyle,
              ),
            ],
          ),
      ],
    );
  }

  double _getCategoryFontSize(int indent) {
    var index = indent.clamp(0, kFontSizesOrderedByIdentLevel.length - 1);
    return kFontSizesOrderedByIdentLevel[index];
  }
}