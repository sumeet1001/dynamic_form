import 'package:dynamic_forms/features/forms/model/config_json_model.dart';
import 'package:dynamic_forms/features/forms/widgets/field.dart';
import 'package:flutter/material.dart';

class FormFieldList extends StatelessWidget {
  const FormFieldList({
    super.key,
    required this.formConfig,
  });
  final List<ConfigJson> formConfig;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemBuilder: (context, index) => Field(
          field: formConfig[index],
        ),
        itemCount: formConfig.length,
      ),
    );
  }
}
