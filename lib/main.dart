import 'package:flutter/material.dart';
import 'package:flutter_actividades/register_adapters.dart';
import 'package:flutter_actividades/ui/app.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  var path=await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  
  registerAdapter();
  
  runApp(MyApp());
}