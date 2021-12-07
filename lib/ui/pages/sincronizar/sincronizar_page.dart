import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canastas/ui/pages/sincronizar/sincronizar_controller.dart';
import 'package:flutter_canastas/ui/widgets/app_bar_widget.dart';
import 'package:get/get.dart';

class SincronizarPage extends StatelessWidget {
  final SincronizarController controller = Get.find<SincronizarController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<SincronizarController>(
      init: controller,
      id: 'version',
      builder: (_) => Stack(
        children: [
          Scaffold(
            appBar: getAppBar('Sincronizar', [], true),
            body: ListView(
              children: [
                itemEncabezado(size),
                
                GetBuilder<SincronizarController>(
                  id: 'sedes',
                  builder: (_)=> itemSincronizado(size, 'sedes', 'Sedes' , _.sedes.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'vehiculos',
                  builder: (_)=> itemSincronizado(size, 'vehiculos', 'Vehiculos' , _.vehiculos.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'temporadas',
                  builder: (_)=> itemSincronizado(size, 'temporadas', 'Temporadas' , _.temporadas.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'productos',
                  builder: (_)=> itemSincronizado(size, 'productos', 'Productos' , _.productos.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'usuarios',
                  builder: (_)=> itemSincronizado(size, 'usuarios', 'Usuarios' , _.usuarios.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'personal_empresa',
                  builder: (_)=> itemSincronizado(size, 'personal_empresa', 'Personal' , _.personal.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'puntos_entrega',
                  builder: (_)=> itemSincronizado(size, 'puntos_entrega', 'Puntos de entrega' , _.puntosEntrega.length.toString() )),
                GetBuilder<SincronizarController>(
                  id: 'personal_vehiculo',
                  builder: (_)=> itemSincronizado(size, 'personal_vehiculo', 'Personal vehiculo' , _.cantidadPersonalVehiculo.toString() )),
              ],
            ),
          ),
          GetBuilder<SincronizarController>(
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

  Widget itemEncabezado(Size size) {
    return Container(
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Tabla',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                  alignment: Alignment.center, child: Text('Resultado'))),
        ],
      ),
    );
  }

  Widget itemSincronizado(Size size, String titleBuilder, String title, String count) {
    return GetBuilder<SincronizarController>(
      id: titleBuilder,
      builder: (_) => Container(
        height: size.height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Container(), flex: 1),
            Expanded(
                flex: 10,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(title))),
            Expanded(child: Container(), flex: 1),
            Expanded(
                flex: 10,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(count))),
            Expanded(child: Container(), flex: 1),
          ],
        ),
      ),
    );
  }
}
