
import 'package:flutter_actividades/ui/pages/entregable/agregar_persona/agregar_persona_page.dart';
import 'package:flutter_actividades/ui/pages/entregable/home/home_page.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_personas/listado_personas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/ui/pages/entregable/navigation/navigation_page.dart';
import 'package:flutter_actividades/ui/pages/splash_general/splash_general_page.dart';

Map<String, Widget Function(BuildContext)> getAplicattionRoutes() {
  return {
    '/': (BuildContext context) => (SplashGeneralPage()),
    'navigation': (BuildContext context) => (NavigationPage()),
    'listado_personas': (BuildContext context) => (ListadoPersonasPage()),
    'agregar_persona': (BuildContext context) => (AgregarPersonaPage()),
    'home': (BuildContext context) => (HomePage()),
  };
}
