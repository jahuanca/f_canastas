
import 'package:flutter_canastas/ui/pages/agregar_persona/agregar_persona_page.dart';
import 'package:flutter_canastas/ui/pages/home/home_page.dart';
import 'package:flutter_canastas/ui/pages/listado_personas/listado_personas_page.dart';
import 'package:flutter_canastas/ui/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canastas/ui/pages/navigation/navigation_page.dart';
import 'package:flutter_canastas/ui/pages/splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> getAplicattionRoutes() {
  return {
    '/': (BuildContext context) => SplashPage(),
    'navigation': (BuildContext context) => (NavigationPage()),
    'login': (BuildContext context) => (LoginPage()),
    'listado_personas': (BuildContext context) => (ListadoPersonasPage()),
    'agregar_persona': (BuildContext context) => (AgregarPersonaPage()),
    'home': (BuildContext context) => (HomePage()),
  };
}
