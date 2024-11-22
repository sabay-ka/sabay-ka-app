import 'package:flutter/material.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/feature/onboarding/splash_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';
//import 'package:gem_kit/core.dart';

final locator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();
  // Pocketbase SDK initialization (For Auth, DB)
  locator.registerSingletonAsync<PocketbaseService>(PocketbaseServiceImpl.create);
  // Magic Lane SDK initialization (For Map, Navigation)
  //final projectApiToken = FlutterConfig.get('MAGICLANE_API_KEY');
  //if (projectApiToken == null) {
  //  throw Exception('MAGICLANE_API_KEY is not set in .env');
  //}
  //await GemKit.initialize(appAuthorization: projectApiToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashWidget());
  }
}
