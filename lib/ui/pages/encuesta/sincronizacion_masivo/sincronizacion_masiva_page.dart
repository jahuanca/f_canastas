import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/encuesta/sincronizacion_masivo/sincronizacion_masiva_controller.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/button_login_widget.dart';
import 'package:get/get.dart';

class SincronizacionMasivaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<SincronizacionMasivaController>(
      id: 'validando',
      builder: (_) => Stack(
        children: [
          Scaffold(
            backgroundColor: secondColor,
            appBar: getAppBarChoose('Sincronización masiva', [], false, 1),
            body: ListView(
              children: [
                _title(size),
                _detalles(size),
                _detallesSinSincronizar(size),
                _sincronizar(size),

                if(_.dResultados.length > 0)
                _resultados(size, 'Sincronizados', '${_.sincronizados ?? 0}'),
                if(_.dResultados.length > 0)
                _resultados(size, 'Repetidos', '${_.repetidos ?? 0}'),
              ],
            ),
          ),
          GetBuilder<SincronizacionMasivaController>(
            id: 'validando',
            builder: (_) => _.validando
                ? Container(
                    color: Colors.black45,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _title(Size size) {
    return GetBuilder<SincronizacionMasivaController>(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        height: size.height * 0.1,
        child: Text(_.encuestaSeleccionada.titulo ?? ''),
      ),
    );
  }

  Widget _detalles(Size size) {
    return GetBuilder<SincronizacionMasivaController>(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        height: size.height * 0.1,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text('Encontrados'),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text('${_.detalles.length ?? 0}'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detallesSinSincronizar(Size size) {
    return GetBuilder<SincronizacionMasivaController>(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        height: size.height * 0.1,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text('Sin sincronizar'),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text('${_.detallesSinSincronizar.length ?? 0}'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sincronizar(Size size){
    return GetBuilder<SincronizacionMasivaController>(
      
      builder: (_)=> Row(
        children: [
          Expanded(child: Container(), flex: 1),
          Expanded(
            flex: 3,
            child: Container(
              child: ButtonLogin(
                onTap: _.goSincronizacion,
                texto: 'Sincronizar'),
            ),
          ),
          Expanded(child: Container(), flex: 1),
        ],
      ),
    );
  }

  Widget _resultados(Size size, String titulo, String valor) {
    return GetBuilder<SincronizacionMasivaController>(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        height: size.height * 0.1,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(titulo),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(valor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
