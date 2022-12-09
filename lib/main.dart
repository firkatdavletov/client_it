import 'app/ui/main_app_runner.dart';
import 'app/ui/main_app_builder.dart';

void main() {
  const env = String.fromEnvironment("env", defaultValue: "test");
  final runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  
  runner.run(builder);
}
