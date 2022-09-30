import 'package:flutter/cupertino.dart';
import 'package:flutter_actividades/di/navigation_binding.dart';
import 'package:flutter_actividades/di/sincronizar_binding.dart';
import 'package:flutter_actividades/domain/entities/log_entity.dart';
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/login/save_token_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/login/save_user_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/login/sign_in_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/sincronizar/sincronizar_page.dart';
import 'package:flutter_actividades/ui/pages/encuesta/navigation/navigation_page.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter_actividades/ui/utils/validators_utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';

class LoginController extends GetxController {
  String errorUsuario, errorPassword;
  String version = 'x.x.x';
  DateTime ultimaSincronizacion;

  UsuarioEntity loginEntity = new UsuarioEntity();

  SignInUseCase _signInUseCase;
  SaveUserUseCase _saveUserUseCase;
  SaveTokenUseCase _saveTokenUseCase;
  GetSubdivisonsUseCase _getSubdivisonsUseCase;

  bool validando = false;
  List<SubdivisionEntity> subdivisions = [];
  SubdivisionEntity subdivisionSelected;

  FocusNode focusNode = FocusNode();

  LoginController(
    this._saveTokenUseCase,
    this._saveUserUseCase,
    this._signInUseCase,
    this._getSubdivisonsUseCase,
  );

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    await getSubdivisions();
    await getLogs();
    super.onReady();
  }

  Future<void> getSubdivisions() async {
    subdivisions = await _getSubdivisonsUseCase.execute();
    if (subdivisions.length > 0) {
      print(subdivisions.length);
      subdivisionSelected = subdivisions.first;
      await changeSubdivision(subdivisionSelected.idsubdivision.toString());
    }
    update(['subdivision']);
  }

  Future<bool> getLogs() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    var logHive = await Hive.openBox<LogEntity>('log_sincronizar');
    if (logHive.values.isNotEmpty) {
      ultimaSincronizacion = logHive.values.last.fecha;
    }
    update(['version']);
    await logHive.close();
    return true;
  }

  String validar() {
    onValidationUsuario(loginEntity.alias ?? '');
    onValidationPassword(loginEntity.password ?? '');
    if (errorUsuario != null) return errorUsuario;
    if (errorPassword != null) return errorPassword;
    return null;
  }

  void onValidationUsuario(String value) {
    errorUsuario = validatorUtilText(value, 'Usuario', {
      'required': '',
    });
    if (errorUsuario == null) {
      loginEntity.alias = value;
    } else {
      loginEntity.alias = null;
    }
    update(['usuario']);
  }

  void onValidationPassword(String value) {
    errorPassword = validatorUtilText(value, 'Contraseña', {
      'required': '',
    });
    if (errorPassword == null) {
      loginEntity.password = value;
    } else {
      loginEntity.password = null;
    }
    update(['password']);
  }

  Future<void> ingresar() async {
    String mensaje = validar();
    if (mensaje != null) {
      toastError('Error', mensaje);
      return;
    }
    validando = true;
    update(['validando']);
    UsuarioEntity usuarioEntity = await _signInUseCase.execute(loginEntity);
    validando = false;
    update(['validando']);
    if (usuarioEntity != null) {
      await _saveTokenUseCase.execute(usuarioEntity.token);
      await _saveUserUseCase.execute(usuarioEntity);
      PreferenciasUsuario().idSubdivision = subdivisionSelected.idsubdivision;
      PreferenciasUsuario().idUsuario = usuarioEntity.idusuario;
      goHome();
    }
  }

  Future<void> changeSubdivision(String id) async {
    int index =
        subdivisions.indexWhere((e) => e.idsubdivision == int.parse(id));
    if (index != -1) {
      subdivisionSelected = subdivisions[index];
      print(subdivisionSelected.toJson());
      update(['subdivision']);
    }
  }

  void goHome() {
    NavigationBinding(type: 1).dependencies();
    Get.off(() => NavigationPage());
  }

  Future<void> goSincronizar() async {
    SincronizarBinding(type: 1).dependencies();
    await Get.to(() => SincronizarPage());
    await getLogs();

    PreferenciasUsuario().offLine = true;
    await getSubdivisions();
    update(['subdivision']);
  }
}
