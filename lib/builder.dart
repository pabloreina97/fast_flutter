import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/clean_architecture_generator.dart';

Builder cleanArchitectureBuilder(BuilderOptions options) {
  print('Building clean architecture...');
  return LibraryBuilder(CleanArchitectureGenerator());
}
