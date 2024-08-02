import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';
import 'generators/model_generator.dart';

class CleanArchitectureGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final configAsset = AssetId(buildStep.inputId.package, 'clean_architecture_config.yaml');
    final configContent = await buildStep.readAsString(configAsset);
    final config = loadYaml(configContent);

    final modelGenerator = ModelGenerator();

    for (var entity in config['entities']) {
      final modelContent = modelGenerator.generate(entity);
      final modelFile = AssetId(
        buildStep.inputId.package,
        'lib/infrastructure/models/${entity['name'].toLowerCase()}_model.dart',
      );
      await buildStep.writeAsString(modelFile, modelContent);
    }

    return '';
  }
}
