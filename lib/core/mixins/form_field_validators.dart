import 'package:dynamic_forms/features/forms/model/config_json_model.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

mixin FormFieldValidatorsMixin {
  List<FormFieldValidator> bindValidations(
    ConfigJson field,
  ) {
    List<FormFieldValidator> validations = [];
    if (field.required == true) {
      validations.add(FormBuilderValidators.required());
    }
    return validations;
  }
}
