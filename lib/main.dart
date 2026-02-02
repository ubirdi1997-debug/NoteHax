import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/constants/app_theme.dart';
import 'package:notehax/screens/splash_screen.dart';
import 'package:notehax/services/biometric_service.dart';
import 'package:notehax/services/encryption_service.dart';
import 'package:notehax/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize services
  await HiveService.instance.init();
  await EncryptionService.instance.init();
  
  runApp(const ProviderScope(child: NoteHaxApp()));
}

class NoteHaxApp extends StatelessWidget {
  const NoteHaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
