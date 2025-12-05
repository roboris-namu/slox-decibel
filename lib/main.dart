import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SloxDecibelApp());
}

class SloxDecibelApp extends StatefulWidget {
  const SloxDecibelApp({super.key});

  @override
  State<SloxDecibelApp> createState() => _SloxDecibelAppState();
}

class _SloxDecibelAppState extends State<SloxDecibelApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SLOX Decibel',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF6366F1),
          secondary: const Color(0xFF06B6D4),
          surface: const Color(0xFF1A1A24),
          background: const Color(0xFF0A0A0F),
        ),
        fontFamily: 'SF Pro Display',
      ),
      home: HomeScreen(
        currentLocale: _locale,
        onLocaleChange: setLocale,
      ),
    );
  }
}
