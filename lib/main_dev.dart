import 'app.dart';
import 'app/data/env.dart';
import 'app/data/static.dart';

Future<void> main() async {
  await appMain(envInit: () {
    AppStatics.envVars = DevEnvVars();
  });
}
