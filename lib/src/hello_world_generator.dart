import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// Crea una clase que extienda de Generator y defina el código a generar
class HelloWorldGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    // Aquí defines el código que se generará
    return '''
// Este archivo se ha generado automáticamente
final String hello = 'Hello world';
''';
  }
}
