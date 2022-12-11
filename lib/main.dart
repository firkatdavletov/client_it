import 'package:flutter/material.dart';

import 'app/ui/main_app_runner.dart';
import 'app/ui/main_app_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment("env", defaultValue: "prod");
  final runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  
  runner.run(builder);
}
