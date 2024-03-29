
import 'package:flutter/material.dart';
import 'package:flutter_actividades/di/main_binding.dart';
import 'package:flutter_actividades/ui/utils/routes.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
 
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', 'PE'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: getAplicattionRoutes(),
      initialBinding: MainBinding(),
    );
  }
}