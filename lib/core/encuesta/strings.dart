//const String serverUrlCorta = '10.0.2.2:3000';
const String serverUrlCorta = '192.168.1.3:3000';
//const String serverUrlCorta='40.88.149.7/node/canastas';
const String nameApp='Encuestas';
//const String serverUrlCorta='6d61-190-236-246-120.ngrok.io';
const String serverUrl = 'http://$serverUrlCorta';
const String rImages = 'assets/encuesta/images/';
const bool mostrarLog=false;

const boxes={
  'unidad_negocio': '${nameApp}_unidad_negocio_sincronizar',
  'encuesta_etapa': '${nameApp}_encuesta_etapa_sincronizar',
  'encuesta_campo': '${nameApp}_encuesta_campo_sincronizar',
  'encuesta_turno': '${nameApp}_encuesta_turno_sincronizar',
};