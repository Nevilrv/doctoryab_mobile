import 'package:doctor_yab/app/data/env.dart';
import 'package:doctor_yab/app/data/static.dart';

import 'app.dart';

Future<void> main() async {
  await appMain(envInit: () {
    AppStatics.envVars = UzbEnvVars();
  });
}
