import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/feature/history/history_screen.dart';
import 'package:flutter_barcode_scanner/feature/main_screen/main_screen.dart';
import 'package:flutter_barcode_scanner/feature/scanner_screen/scanner_screen.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocDir.path);
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(),
        '/scanner': (context) => const ScannerScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
