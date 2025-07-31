import 'dart:convert';

import 'package:dynamic_forms/features/forms/model/config_json_model.dart';
import 'package:dynamic_forms/features/forms/widgets/form_field_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

final json = jsonEncode([
  {
    "name": "username",
    "label": "Username",
    "type": "text",
    "required": true,
  },
  {
    "name": "country",
    "label": "Select Country",
    "type": "dropdown",
    "required": true,
    "options": [
      {"label": "United States", "value": "us"},
      {"label": "Canada", "value": "ca"},
      {"label": "United Kingdom", "value": "uk"},
      {"label": "Australia", "value": "au"},
      {"label": "India", "value": "in"}
    ]
  },
  {
    "name": "gender",
    "label": "Gender",
    "type": "radio",
    "required": false,
    "options": [
      {"label": "Male", "value": "male"},
      {"label": "Female", "value": "female"},
      {"label": "Other", "value": "other"},
      {"label": "Prefer not to say", "value": "not_specified"}
    ]
  },
  {
    "name": "Skills",
    "label": "Select the skill",
    "type": "checkbox",
    "required": false,
    "options": [
      {"label": "Flutter", "value": "flutter"},
      {"label": "Dart", "value": "dart"},
      {"label": "Kotlin", "value": "kotlin"},
      {"label": "Swift", "value": "swift"},
    ]
  }
]);

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormBuilderState>();
  late List<ConfigJson> formConfig;
  bool formFetched = false;
  @override
  void initState() {
    fetch();
    super.initState();
  }

  Future<void> fetch() async {
    try {
      formConfig = ConfigJson.fromJsonList(jsonDecode(json));
      print(formConfig);
      setState(() {
        formFetched = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.saveAndValidate();
      debugPrint(_formKey.currentState?.value.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill all required field",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          "Dynamic Form",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade50,
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
          ),
          onPressed: _submitForm,
          child: Text(
            "Submit",
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: FormBuilder(
                  key: _formKey,
                  child: FormFieldList(
                    formConfig: formConfig,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
