import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/entregable/colors.dart';
import 'package:flutter_actividades/core/entregable/dimens.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_personal_vehiculo/listado_personal_vehiculo_controller.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:flutter_actividades/ui/widgets/entregable/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/empty_data_widget.dart';
import 'package:get/get.dart';

class ListadoPersonalVehiculoPage extends StatelessWidget {
  
  final ListadoPersonalVehiculoController controller =
      Get.find<ListadoPersonalVehiculoController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ListadoPersonalVehiculoController>(
      init: controller,
      id: 'personal_seleccionado_pv',
      builder: (_) => WillPopScope(
        onWillPop: _.onWillPop,
        child: Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Ingrese el DNI de la persona'),
                    actions: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.1,
                        child: GetBuilder<ListadoPersonalVehiculoController>(
                          id: 'placa',
                          builder: (_) => CircleAvatar(
                            backgroundColor:
                                _.placa == null ? Colors.grey : infoColor,
                            child: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              onPressed: [null, ''].contains(_.placa)
                                  ? null
                                  : () async => await _.addVehiculo(),
                            ),
                          ),
                        ),
                      ),
                    ],
                    content: GetBuilder<ListadoPersonalVehiculoController>(
                        builder: (_) {
                      _.changePlaca(null);
                      return TextField(
                        onChanged: _.changePlaca,
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: "Digite el DNI"),
                      );
                    }),
                  ),
                ),
                child: Icon(Icons.add),
              ),
              appBar: getAppBar(
                  '${_.personalSeleccionado?.length ?? 0}',
                  [
                    IconButton(
                        onPressed: _.goLectorCode, icon: Icon(Icons.qr_code)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  ],
                  true),
              backgroundColor: secondColor,
              body: RefreshIndicator(
                onRefresh: () async => _.update(['seleccionados', 'personal_seleccionado_pv', 'listado_v']),
                child: GetBuilder<ListadoPersonalVehiculoController>(
                  id: 'seleccionado',
                  builder: (_) => Column(
                    children: [
                      if (_.seleccionados.length > 0)
                        Flexible(
                          flex: 1,
                          child: AnimatedContainer(
                              child: _opcionesSeleccionados(),
                              duration: Duration(seconds: 1)),
                        ),
                      Flexible(
                        flex: 8,
                        child: GetBuilder<ListadoPersonalVehiculoController>(
                          id: 'listado_v',
                          builder: (_) => _.personalSeleccionado?.isEmpty ?? true
                              ? EmptyDataWidget(
                                  titulo: 'No existe personal registrado.',
                                  onPressed: () => _.update(['seleccionados', 'personal_seleccionado_pv', 'listado_v']),
                                  size: size)
                              : ListView.builder(
                                  itemCount: _.personalSeleccionado.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          itemActividad(size, context, index),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /* floatingActionButton: FloatingActionButton(
                child: IconButton(
                    onPressed: _.goNuevoPersonaTareaProceso,
                    icon: Icon(Icons.add)),
              ), */
            ),
            GetBuilder<ListadoPersonalVehiculoController>(
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
      ),
    );
  }

  Widget itemActividad(Size size, context, index) {
    final items = [
      /* {'key': 1, 'value': 'Editar'}, */
      {'key': 2, 'value': 'Eliminar'},
    ];

    return GetBuilder<ListadoPersonalVehiculoController>(
        id: 'seleccionado',
        builder: (_) => GestureDetector(
              onLongPress: _.seleccionados.length > 0
                  ? null
                  : () => _.seleccionar(index),
              onTap: _.seleccionados.length > 0
                  ? () => _.seleccionar(index)
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: (_.seleccionados.contains(index))
                      ? Colors.blue
                      : secondColor,
                  border: (_.seleccionados.contains(index))
                      ? Border.all()
                      : Border.all(color: Colors.transparent),
                ),
                padding: EdgeInsets.all(size.width * 0.05),
                child: Container(
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                      color: cardColor,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          child: Row(
                            children: [
                              /* Flexible(child: Container(), flex: 1),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_.personalSeleccionado[index]
                                          .correlativo.toString()),
                                ),
                                flex: 5,
                              ), */
                              Flexible(child: Container(), flex: 1),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_.personalSeleccionado[index]
                                          .personal?.nrodocumento ??
                                      ''),
                                ),
                                flex: 10,
                              ),
                              Flexible(child: Container(), flex: 1),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_.personalSeleccionado[index]
                                          .personal?.nombreCompleto ??
                                      ''),
                                ),
                                flex: 25,
                              ),
                              Flexible(child: Container(), flex: 1),
                              Flexible(
                                  child: Container(
                                    child: _.seleccionados.length>0 ? Container() : DropdownBelow(
                                      itemWidth: 200,
                                      itemTextstyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                      boxTextstyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: cardColor),
                                      boxPadding:
                                          EdgeInsets.fromLTRB(13, 12, 0, 12),
                                      boxHeight: 45,
                                      boxWidth: 150,
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: primaryColor,
                                      ),
                                      value: 2,
                                      items: items == null
                                          ? []
                                          : items
                                              .map((e) => DropdownMenuItem(
                                                  value: e['key'],
                                                  child: Text(e['value'])))
                                              .toList(),
                                      onChanged: (value) => _.changeOptions(value, index),
                                    ),
                                  ),
                                  flex: 5),
                              Flexible(child: Container(), flex: 1),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Container(
                          child: Row(
                            children: [
                              Flexible(child: Container(), flex: 1),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(formatoFecha(_.personalSeleccionado[index]
                                                .fecha)) ??
                                          '-Sin valor-',
                                ),
                                flex: 10,
                              ),
                              Flexible(child: Container(), flex: 1),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      formatoHora(_.personalSeleccionado[index]
                                                .hora) ??
                                          '-Sin hora-',
                                      style: TextStyle(
                                          color: (_.personalSeleccionado[index]
                                                          .hora ==
                                                      null)
                                              ? dangerColor
                                              : Colors.black87)),
                                ),
                                flex: 10,
                              ),
                              Flexible(child: Container(), flex: 1),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(child: Container(), flex: 1),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text((_.personalSeleccionado.length - index).toString()),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Container(),
                                /* child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Espacio'  ??
                                        '-Sin pausas-',
                                    style: TextStyle(
                                        color: (_.personalSeleccionado[index]
                                                        .hora ==
                                                    null)
                                            ? Colors.grey
                                            : Colors.black87),
                                  ),
                                ), */
                                flex: 8,
                              ),
                              Expanded(child: Container(), flex: 1),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _opcionesSeleccionados() {
    final items = [
      {'key': 1, 'value': 'Seleccionar todos'},
      {'key': 2, 'value': 'Quitar todos'},
      {'key': 3, 'value': 'Actualizar datos'},
    ];

    return GetBuilder<ListadoPersonalVehiculoController>(
      id: 'seleccionado',
      builder: (_) => Container(
        decoration: BoxDecoration(color: Colors.white, border: Border.all()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: Container(), flex: 1),
            Flexible(
              child: Container(
                child: Text(
                  '${_.seleccionados.length} seleccionados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              flex: 12,
            ),
            Flexible(child: Container(), flex: 6),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: DropdownBelow(
                  itemWidth: 200,
                  itemTextstyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  boxTextstyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cardColor),
                  boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
                  boxHeight: 45,
                  boxWidth: 150,
                  icon: Icon(
                    Icons.more_horiz,
                    color: primaryColor,
                  ),
                  value: 1,
                  items: items == null
                      ? []
                      : items
                          .map((e) => DropdownMenuItem(
                              value: e['key'], child: Text(e['value'])))
                          .toList(),
                  onChanged: _.changeOptionsGlobal,
                ),
              ),
              flex: 4,
            ),
            Flexible(child: Container(), flex: 1),
          ],
        ),
      ),
    );
  }
}
