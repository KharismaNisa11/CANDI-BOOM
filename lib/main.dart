// main.dart
import 'package:candiboom/Localization/locales.dart';
import 'package:candiboom/View/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState(){
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candy Boom',
      debugShowCheckedModeBanner: false,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      home: HomePage(),
    );
  }

  void configureLocalization(){
    localization.init(mapLocales: LOCALES, initLanguageCode: "en");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale){
    setState(() {});
  }
}

