import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get permanentSession {
    return _prefs.getBool('permanentSession') ?? false;
  }

  set permanentSession(bool value) {
    _prefs.setBool('permanentSession', value);
  }

  get lastVersion {
    return 'v'+(_prefs.getString('lastVersion') ?? 'X.X.X');
  }

  set lastVersion(String value) {
    _prefs.setString('lastVersion', value);
  }

  get lastVersionDate {
    return _prefs.getString('lastVersionDate') ?? '-----';
  }

  set lastVersionDate(String value) {
    _prefs.setString('lastVersionDate', value);
  }

  get offLine {
    return _prefs.getBool('offLine') ?? true;
  }

  set offLine(bool value) {
    _prefs.setBool('offLine', value);
  }

  get idPuntoEntrega {
    return _prefs.getInt('id_punto_entrega');
  }

  set idPuntoEntrega(int value) {
    _prefs.setInt('id_punto_entrega', value);
  }

  get idUsuario {
    return _prefs.getInt('id_usuario');
  }

  set idUsuario(int value) {
    _prefs.setInt('id_usuario', value);
  }

  get idSociedad {
    return _prefs.getInt('id_sociedad');
  }

  set idSociedad(int value) {
    _prefs.setInt('id_sociedad', value);
  }

  get idSubdivision {
    return _prefs.getInt('id_subdivision');
  }

  set idSubdivision(int value) {
    _prefs.setInt('id_subdivision', value);
  }

  get modoDark {
    return _prefs?.getBool('modoDark') ?? false;
  }

  set modoDark(bool value) {
    _prefs.setBool('modoDark', value);
  }

  get idUnidadNegocio {
    return _prefs.getInt('id_unidad_negocio');
  }

  set idUnidadNegocio(int value) {
    _prefs.setInt('id_unidad_negocio', value);
  }

  get idEtapa {
    return _prefs.getInt('id_etapa');
  }

  set idEtapa(int value) {
    _prefs.setInt('id_etapa', value);
  }

  get idCampo {
    return _prefs.getInt('id_campo');
  }

  set idCampo(int value) {
    _prefs.setInt('id_campo', value);
  }

  get idTurno {
    return _prefs.getInt('id_turno');
  }

  set idTurno(int value) {
    _prefs.setInt('id_turno', value);
  }

}
