const String modelTemplate = '''
class {{modelName}}Model {
{{fields}}

  {{modelName}}Model({
{{constructorParams}}
  });

  factory {{modelName}}Model.fromJson(Map<String, dynamic> json) => {{modelName}}Model(
{{fromJsonParams}}
  );
}
''';

const String fieldTemplate = '  final {{fieldType}} {{fieldName}};';
const String constructorParamTemplate = '    required this.{{fieldName}},';
const String fromJsonParamTemplate = '    {{fieldName}}: {{fromJsonConversion}},';
