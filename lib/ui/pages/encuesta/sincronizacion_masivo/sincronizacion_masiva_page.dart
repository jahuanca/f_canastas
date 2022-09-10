import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/encuesta/sincronizacion_masivo/sincronizacion_masiva_controller.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
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
            floatingActionButton: 
            (_.detallesSinSincronizar.length ?? 0) > 0 ?
            FloatingActionButton(
              onPressed: _.goSincronizacion,
              backgroundColor: primaryColor,
              child: Icon(Icons.sync),
            )
            : Container()
            ,
            backgroundColor: secondColor,
            appBar: getAppBarChoose('Sincronización masiva', [], true, 1, Alignment.centerLeft),
            body: ListView(
              children: [
                _title(size),
                _detalles(size),
                _detallesSinSincronizar(size),
                //_sincronizar(size),

                if (_.dResultados.length > 0)
                  _resultados(size, 'Sincronizados', '${_.sincronizados ?? 0}'),
                if (_.dResultados.length > 0)
                  _resultados(size, 'Repetidos', '${_.repetidos ?? 0}'),
              ],
            ),
          ),
          GetBuilder<SincronizacionMasivaController>(
            id: 'validando',
            builder: (_) => _.validando
                ? Container(
                    color: Colors.black45,
                    child: Center(child: CircularProgressIndicator(
                      color: primaryColor,
                    )),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          _.encuestaSeleccionada.titulo ?? '',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _detalles(Size size) {
    return GetBuilder<SincronizacionMasivaController>(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Encontrados',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${_.detalles.length ?? 0}',
                  style: TextStyle(
                    color: black,
                    fontSize: 16,
                  ),
                ),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Sin sincronizar',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${_.detallesSinSincronizar.length ?? 0}',
                  style: TextStyle(
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _resultados(Size size, String titulo, String valor) {
    return GetBuilder<SincronizacionMasivaController>(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(titulo, 
                style: TextStyle(
                    color: black,
                    fontSize: 16,
                  ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(valor,
                  style: TextStyle(
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
