import 'package:document_manager/constants/app_colors.dart';
import 'package:document_manager/firebase_options.dart';
import 'package:document_manager/pages/launch_page/launch_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.grey[200],
            dividerColor: Colors.grey[250],
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.main,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.main,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          home: child,
        );
      },
      child: const LaunchPage(),
    );
  }
}
