import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/entregable/colors.dart';
import 'package:flutter_actividades/core/entregable/dimens.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_vehiculo_temporada/listado_vehiculo_temporada_controller.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:flutter_actividades/ui/widgets/entregable/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/empty_data_widget.dart';
import 'package:get/get.dart';

class ListadoVehiculoTemporadaPage extends StatelessWidget {
  final ListadoVehiculoTemporadaController controller =
      Get.find<ListadoVehiculoTemporadaController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ListadoVehiculoTemporadaController>(
      init: controller,
      id: 'personal_seleccionado_vt',
      builder: (_) => WillPopScope(
        onWillPop: _.onWillPop,
        child: Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Ingrese la placa del vehiculo'),
                    actions: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.1,
                        child: GetBuilder<ListadoVehiculoTemporadaController>(
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
                    content: GetBuilder<ListadoVehiculoTemporadaController>(
                        builder: (_) {
                      _.changePlaca(null);
                      return TextField(
                        onChanged: _.changePlaca,
                        decoration:
                            InputDecoration(hintText: "Digite la placa"),
                      );
                    }),
                  ),
                ),
                child: Icon(Icons.add),
              ),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: GetBuilder<ListadoVehiculoTemporadaController>(
                  id: 'listado_vt',
                  builder: (_) => getAppBar(
                      '${_.vehiculosRegistrados?.length}',
                      [
                        IconButton(
                            onPressed: _.goLectorCode,
                            icon: Icon(Icons.qr_code)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      ],
                      true),
                ),
              ),
              backgroundColor: secondColor,
              body: RefreshIndicator(
                onRefresh: () async => _.getVehiculos(),
                child: GetBuilder<ListadoVehiculoTemporadaController>(
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
                        child: GetBuilder<ListadoVehiculoTemporadaController>(
                          id: 'listado_vt',
                          builder: (_) => _.vehiculosRegistrados.isEmpty
                              ? EmptyDataWidget(
                                  titulo: 'No existen registros.',

                                  onPressed: () => _.getVehiculos(),
                                  size: size)
                              : ListView.builder(
                                  itemCount: _.vehiculosRegistrados.length,
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
            ),
            GetBuilder<ListadoVehiculoTemporadaController>(
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
      {'key': 1, 'value': 'Eliminar'},
    ];

    return GetBuilder<ListadoVehiculoTemporadaController>(
      id: 'seleccionado',
      builder: (_) => GestureDetector(
        onLongPress: () => _.seleccionar(index),
        child: GetBuilder<ListadoVehiculoTemporadaController>(
          id: 'item_$index',
          builder: (_) => Container(
            decoration: BoxDecoration(
              color:
                  (_.seleccionados.contains(index)) ? Colors.blue : secondColor,
              border: (_.seleccionados.contains(index))
                  ? Border.all()
                  : Border.all(color: Colors.transparent),
            ),
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.03, horizontal: size.width * 0.05),
            child: Container(
              height: size.height * 0.27,
              decoration: BoxDecoration(
                  color: cardColor,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Column(
                children: [
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                  Flexible(
                    child: Container(
                      child: Row(
                        children: [
                          Flexible(child: Container(), flex: 1),
                          Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  child: Text(
                                      (_.vehiculosRegistrados.length - index)
                                          .toString()),
                                  //color: primaryColor,
                                ),
                              ),
                              flex: 1),
                          Flexible(child: Container(), flex: 1),
                          Flexible(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                formatoFecha(
                                    _.vehiculosRegistrados[index].fecha),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                            ),
                            flex: 10,
                          ),
                          Flexible(child: Container(), flex: 1),
                          Flexible(
                              child: Container(
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
                                    boxPadding:
                                        EdgeInsets.fromLTRB(13, 12, 0, 12),
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
                                                value: e['key'],
                                                child: Text(e['value'])))
                                            .toList(),
                                    onChanged: (value) => _.onChangedMenu(value,
                                        _.vehiculosRegistrados[index].key)),
                              ),
                              flex: 5),
                          Flexible(child: Container(), flex: 1),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                  Flexible(
                    child: Container(
                      child: Row(
                        children: [
                          Flexible(child: Container(), flex: 1),
                          Flexible(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(formatoHora(
                                      _.vehiculosRegistrados[index].hora) ??
                                  ''),
                            ),
                            flex: 10,
                          ),
                          Flexible(child: Container(), flex: 1),
                          Flexible(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  _.vehiculosRegistrados[index].placa ?? ''),
                            ),
                            flex: 10,
                          ),
                          Flexible(child: Container(), flex: 1),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                  Flexible(
                    child: Container(
                      child: Row(
                        children: [
                          Flexible(child: Container(), flex: 1),
                          Flexible(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text((_.vehiculosRegistrados[index]
                                                  .sizeDetails ??
                                              '0')
                                          .toString()
                                          .toString())),
                                  Icon(
                                    Icons.people,
                                    color: Colors.black45,
                                  )
                                ],
                              ),
                            ),
                            flex: 10,
                          ),
                          Flexible(child: Container(), flex: 1),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                  Flexible(child: Container(), flex: 1),
                  Flexible(
                    child: Container(
                      child: Row(
                        children: (_.vehiculosRegistrados[index].estadoLocal !=
                                    'P' &&
                                _.vehiculosRegistrados[index].estadoLocal !=
                                    'PC')
                            ? [
                                Flexible(child: Container(), flex: 1),
                                if (_.vehiculosRegistrados[index].estadoLocal !=
                                    'M')
                                  Flexible(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        backgroundColor: infoColor,
                                        child: IconButton(
                                            onPressed: () => _.goMigrar(_
                                                .vehiculosRegistrados[index]
                                                .key),
                                            icon: Icon(
                                              Icons.sync,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                    flex: 7,
                                  ),
                                Flexible(child: Container(), flex: 1),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor: successColor,
                                      child: IconButton(
                                        onPressed: null,
                                        /* onPressed: () => _.goAprobar(index), */
                                        icon: Icon(Icons.remove_red_eye),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor: dangerColor,
                                      child: IconButton(
                                        onPressed: () => _.goEliminar(
                                            _.vehiculosRegistrados[index].key),
                                        icon: Icon(Icons.delete),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                Flexible(child: Container(), flex: 1),
                              ]
                            : [
                                Flexible(child: Container(), flex: 1),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor: infoColor,
                                      child: IconButton(
                                          onPressed: () =>
                                              _.goListadoDetalles(_.vehiculosRegistrados[index].key,),
                                          icon: Icon(
                                            Icons.person_search,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                Flexible(child: Container(), flex: 1),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor: successColor,
                                      child: IconButton(
                                        onPressed: () => _.goAprobar(
                                          _.vehiculosRegistrados[index].key,
                                        ),
                                        icon: Icon(Icons.check_rounded),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                if (_.vehiculosRegistrados[index]
                                            .idvehiculo ==
                                        null &&
                                    _.vehiculosRegistrados[index].estadoLocal !=
                                        'P' &&
                                    _.vehiculosRegistrados[index].estadoLocal !=
                                        'PC')
                                  Flexible(child: Container(), flex: 1),
                                if (_.vehiculosRegistrados[index].idvehiculo ==
                                    null)
                                  Flexible(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        backgroundColor: alertColor,
                                        child: IconButton(
                                          /* onPressed: () => _.goEditarPlaca(_.vehiculosRegistrados[index].key), */
                                          onPressed: () => showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text('Editar placa'),
                                                    actions: [
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height:
                                                              size.height * 0.1,
                                                          child: GetBuilder<
                                                              ListadoVehiculoTemporadaController>(
                                                            id: 'placa',
                                                            builder: (_) =>
                                                                CircleAvatar(
                                                              backgroundColor:
                                                                  _.placa ==
                                                                          null
                                                                      ? Colors
                                                                          .grey
                                                                      : infoColor,
                                                              child: IconButton(
                                                                icon: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: [null, ''].contains(_.placa)
                                                                    ? null
                                                                    : () async => await _.editarPlaca(_
                                                                        .vehiculosRegistrados[
                                                                            index]
                                                                        .key),
                                                              ),
                                                            ),
                                                          )),
                                                    ],
                                                    content: GetBuilder<
                                                            ListadoVehiculoTemporadaController>(
                                                        builder: (_) {
                                                      _.changePlaca(_
                                                          .vehiculosRegistrados[
                                                              index]
                                                          .placa);
                                                      return TextFormField(
                                                        initialValue: _
                                                                .vehiculosRegistrados[
                                                                    index]
                                                                .placa ??
                                                            '',
                                                        onChanged:
                                                            _.changePlaca,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Digite la placa"),
                                                      );
                                                    }),
                                                  )),
                                          icon: Icon(Icons.edit),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    flex: 7,
                                  ),
                                Flexible(child: Container(), flex: 1),
                              ],
                      ),
                    ),
                    flex: 4,
                  ),
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _opcionesSeleccionados() {
    final items = [
      {'key': 1, 'value': 'Seleccionar todos'},
      {'key': 2, 'value': 'Quitar todos'},
      {'key': 3, 'value': 'Actualizar datos'},
    ];

    return GetBuilder<ListadoVehiculoTemporadaController>(
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
