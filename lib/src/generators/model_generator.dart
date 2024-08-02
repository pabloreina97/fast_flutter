import '../templates/model_template.dart';

class ModelGenerator {
  String generate(Map<String, dynamic> entityConfig) {
    final String modelName = entityConfig['name'];
    final List<Map<String, dynamic>> fields = entityConfig['fields'];

    String fieldsString = '';
    String constructorParamsString = '';
    String fromJsonParamsString = '';

    for (var field in fields) {
      final String fieldName = field['name'];
      final String fieldType = _getFieldType(field['type']);

      fieldsString += fieldTemplate.replaceAll('{{fieldType}}', fieldType).replaceAll('{{fieldName}}', fieldName);
      fieldsString += '\n';

      constructorParamsString += constructorParamTemplate.replaceAll('{{fieldName}}', fieldName);
      constructorParamsString += '\n';

      fromJsonParamsString += fromJsonParamTemplate
          .replaceAll('{{fieldName}}', fieldName)
          .replaceAll('{{fromJsonConversion}}', _getFromJsonConversion(field));
      fromJsonParamsString += '\n';
    }

    return modelTemplate
        .replaceAll('{{modelName}}', modelName)
        .replaceAll('{{fields}}', fieldsString)
        .replaceAll('{{constructorParams}}', constructorParamsString)
        .replaceAll('{{fromJsonParams}}', fromJsonParamsString);
  }

  String _getFieldType(String type) {
    switch (type) {
      case 'List<String>':
      case 'List<int>':
      case 'List<double>':
        return type;
      case 'List':
        return 'List<dynamic>';
      default:
        return type;
    }
  }

  String _getFromJsonConversion(Map<String, dynamic> field) {
    final String fieldName = field['name'];
    final String fieldType = field['type'];

    switch (fieldType) {
      case 'int':
      case 'String':
      case 'double':
        return 'json["$fieldName"]';
      case 'List<String>':
        return 'List<String>.from(json["$fieldName"].map((x) => x))';
      case 'List<int>':
        return 'List<int>.from(json["$fieldName"].map((x) => x))';
      case 'List<double>':
        return 'List<double>.from(json["$fieldName"].map((x) => x))';
      case 'List':
        return 'List<dynamic>.from(json["$fieldName"])';
      default:
        if (fieldType.endsWith('Model')) {
          return '$fieldType.fromJson(json["$fieldName"])';
        }
        return 'json["$fieldName"]';
    }
  }
}
