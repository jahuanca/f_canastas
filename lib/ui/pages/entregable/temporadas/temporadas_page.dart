import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/entregable/colors.dart';
import 'package:flutter_actividades/core/entregable/dimens.dart';
import 'package:flutter_actividades/ui/pages/entregable/temporadas/temporadas_controller.dart';
import 'package:flutter_actividades/ui/widgets/entregable/empty_data_widget.dart';
import 'package:get/get.dart';

class TemporadasPage extends StatelessWidget {
  final TemporadasController controller = Get.find<TemporadasController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<TemporadasController>(
      init: controller,
      builder: (_) => Stack(
        children: [
          Scaffold(
            backgroundColor: secondColor,
            body: GetBuilder<TemporadasController>(
              id: 'seleccionado',
              builder: (_) => Column(
                children: [
                  if (_.seleccionados.length > 0)
                    Expanded(
                      flex: 1,
                      child: AnimatedContainer(
                          child: _opcionesSeleccionados(),
                          duration: Duration(seconds: 1)),
                    ),
                  Expanded(
                    flex: 8,
                    child: RefreshIndicator(
                      onRefresh: _.getTemporadas,
                      child: GetBuilder<TemporadasController>(
                        id: 'tareas',
                        builder: (_) => _.temporadas.isEmpty
                            ? EmptyDataWidget(
                                titulo: 'No existen temporadas.',
                                size: size,
                                onPressed: _.getTemporadas)
                            : ListView.builder(
                                itemCount: _.temporadas?.length ?? 0,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        itemActividad(size, context, index),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* floatingActionButton: FloatingActionButton(
              onPressed: _.goNuevaPreTarea,
              child: Icon(Icons.add),
            ), */
          ),
          GetBuilder<TemporadasController>(
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

  Widget itemActividad(Size size, BuildContext context, int index) {
    final items = [
      /* {'key': 1, 'value': 'Seleccionar'}, */
      {'key': 1, 'value': 'Sincronizar'},
      {'key': 3, 'value': 'Eliminar'},
      {'key': 4, 'value': 'Exportar a EXCEL'},
    ];

    return GetBuilder<TemporadasController>(
      id: 'seleccionado',
      builder: (_) => GestureDetector(
        onLongPress: () => _.seleccionar(index),
        child: Container(
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
                                color: primaryColor,
                              ),
                            ),
                            flex: 1),
                        Flexible(child: Container(), flex: 1),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _.temporadas[index]?.anio ?? '----',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14),
                            ),
                          ),
                          flex: 10,
                        ),
                        Flexible(child: Container(), flex: 1),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _.temporadas[index]?.descripcion ??
                                  '-Sin descripción-',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          flex: 15,
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
                                  onChanged: (value) =>
                                      _.onChangedMenu(value, index)),
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
                        /* Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                _.preTareosUva[index]?.presentacion?.descripcion ??
                                    ''),
                          ),
                          flex: 10,
                        ),
                        Flexible(child: Container(), flex: 1), */
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                _.temporadas[index].periodo.toString() ??
                                    '-Sin periodo-'),
                          ),
                          flex: 10,
                        ),
                        Flexible(child: Container(), flex: 1),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                _.temporadas[index].producto?.descripcion ??
                                    ''),
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
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                      (_.temporadas[index].personalApto?.length ?? 0)
                                          .toString(),
                                      style: TextStyle(color: successColor)),
                                ),
                                Icon(
                                  Icons.people,
                                  color: successColor,
                                )
                              ],
                            ),
                          ),
                          flex: 10,
                        ),
                        Flexible(child: Container(), flex: 1),
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text((_.temporadas[index].sizePersonalRegistrados ?? 0)
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
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text((_.temporadas[index]
                                        ?.sizeVehiculos ?? '0')
                                        .toString())),
                                Icon(
                                  Icons.car_repair,
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
                    child: Row(children: [
                      Flexible(child: Container(), flex: 1),
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: infoColor,
                            child: IconButton(
                                onPressed: () => _.goListadoVehiculos(_.temporadas[index].id),
                                icon: Icon(
                                  Icons.search,
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
                              // ()=> _.goAprobar(index),
                              icon: Icon(Icons.remove_red_eye),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        flex: 7,
                      ),
                      Flexible(child: Container(), flex: 1),
                    ]),
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
    );
  }

  Widget _opcionesSeleccionados() {
    final items = [
      {'key': 1, 'value': 'Seleccionar todos'},
      {'key': 2, 'value': 'Quitar todos'},
      {'key': 3, 'value': 'Exportar en excel'},
    ];

    return GetBuilder<TemporadasController>(
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
                  onChanged: (value) {},
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
