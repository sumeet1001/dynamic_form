import 'package:dynamic_forms/features/forms/model/config_json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dynamic_forms/core/mixins/form_field_validators.dart';

class Field extends StatelessWidget with FormFieldValidatorsMixin {
  final ConfigJson field;
  const Field({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return getWidget(field);
  }

  Widget getWidget(ConfigJson field) {
    switch (field.type) {
      case FieldType.text:
        return Container(
          margin: const EdgeInsets.only(bottom: 20, top: 5),
          child: FormBuilderTextField(
            name: field.name,
            validator: FormBuilderValidators.compose(
              bindValidations(field),
            ),
            decoration: InputDecoration(
              labelText: field.label ?? field.name.toUpperCase(),
              hintText: 'Enter ${field.label?.toLowerCase() ?? field.name}',
              alignLabelWithHint: true,
              filled: true,
              fillColor: Colors.grey.shade50,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        );

      case FieldType.radio:
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label ?? field.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderRadioGroup(
                name: field.name,
                validator: FormBuilderValidators.compose(
                  bindValidations(field),
                ),
                orientation: OptionsOrientation.vertical,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                options: field.options
                        ?.map(
                          (element) => FormBuilderFieldOption(
                            value: element.value,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                element.label ?? "N/A",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ],
          ),
        );

      case FieldType.checkbox:
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label ?? field.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderCheckboxGroup(
                name: field.name,
                orientation: OptionsOrientation.vertical,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                validator: FormBuilderValidators.compose(
                  bindValidations(field),
                ),
                options: field.options
                        ?.map(
                          (element) => FormBuilderFieldOption(
                            value: element.value,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                element.label ?? "N/A",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ],
          ),
        );

      case FieldType.dropdown:
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: FormBuilderDropdown(
            name: field.name,
            validator: FormBuilderValidators.compose(
              bindValidations(field),
            ),
            decoration: InputDecoration(
              labelText: field.label ?? field.name.toUpperCase(),
              hintText: 'Select ${field.label?.toLowerCase() ?? field.name}',
              filled: true,
              fillColor: Colors.grey.shade50,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            items: field.options
                    ?.map(
                      (element) => DropdownMenuItem(
                        value: element.value,
                        child: Text(
                          element.label ?? "N/A",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        );
    }
  }
}
