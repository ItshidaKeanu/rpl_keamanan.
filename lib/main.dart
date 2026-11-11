import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/app_config.dart';
import 'config/dependency_injector.dart';
import 'config/dependency_scope.dart';

import 'screens/home_screen.dart';
import 'utils/logger.dart';

/// Entry point aplikasi.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ==========================================
  // PENGUJIAN LOGGER - LATIHAN 4
  // ==========================================
  Logger.debug('Pesan Debug');
  Logger.info('Pesan Informasi');
  Logger.warning('Pesan Peringatan');
  Logger.error('Pesan Error');

  // Muat file .env
  await dotenv.load(fileName: ".env");

  // Periksa konfigurasi
  if (!AppConfig.isConfigured()) {
    Logger.warning(
      'Konfigurasi .env tidak lengkap. Periksa file .env Anda.',
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyScope(
      dependencies: DependencyInjector(),
      child: MaterialApp(
        title: 'RPL & Keamanan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}