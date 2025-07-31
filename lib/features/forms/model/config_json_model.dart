enum FieldType {
  text,
  radio,
  checkbox,
  dropdown,
}

class LabelValue {
  final String? label;
  final String? value;

  LabelValue({
    this.label,
    this.value,
  });

  factory LabelValue.fromJson(Map<String, dynamic> json) {
    return LabelValue(
      label: json['label'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

class ConfigJson {
  final String name;
  final String? label;
  final FieldType type;
  final bool required;
  final List<LabelValue>? options;

  ConfigJson({
    required this.name,
    required this.type,
    this.required = false,
    this.label,
    this.options,
  });

  factory ConfigJson.fromJson(Map<String, dynamic> json) {
    return ConfigJson(
      name: json['name'] as String,
      label: json['label'] as String,
      type: _fieldTypeFromString(json['type'] as String),
      required: json['required'] as bool? ?? false,
      options: json['options'] != null
          ? (json['options'] as List<dynamic>)
              .map((item) => LabelValue.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'label': label,
      'type': _fieldTypeToString(type),
      'required': required,
      'options': options?.map((item) => item.toJson()).toList(),
    };
  }

  static FieldType _fieldTypeFromString(String typeString) {
    switch (typeString.toLowerCase()) {
      case 'text':
        return FieldType.text;
      case 'radio':
        return FieldType.radio;
      case 'checkbox':
        return FieldType.checkbox;
      case 'dropdown':
        return FieldType.dropdown;
      default:
        throw ArgumentError('Unknown field type: $typeString');
    }
  }

  static String _fieldTypeToString(FieldType type) {
    switch (type) {
      case FieldType.text:
        return 'text';
      case FieldType.radio:
        return 'radio';
      case FieldType.checkbox:
        return 'checkbox';
      case FieldType.dropdown:
        return 'dropdown';
    }
  }

  static List<ConfigJson> fromJsonList(dynamic jsonList) {
    return (jsonList as List<dynamic>)
        .map((json) => ConfigJson.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<ConfigJson> configList) {
    return configList.map((config) => config.toJson()).toList();
  }
}
