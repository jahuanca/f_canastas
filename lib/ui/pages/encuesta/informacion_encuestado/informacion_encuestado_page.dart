import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/encuesta/informacion_encuestado/informacion_encuestado_controller.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/dropdown_search_widget.dart';
import 'package:get/get.dart';

class InformacionEncuestadoPage extends StatelessWidget {
  final InformacionEncuestadoController controller =
      Get.find<InformacionEncuestadoController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<InformacionEncuestadoController>(
      init: controller,
      builder: (_) => Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: _.setInformacion, child: Icon(Icons.check), backgroundColor: primaryColor,),
            appBar: getAppBarChoose(
                'Información encuestador', [], false, 1.0, Alignment.center, 18),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height - MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('Unidad de negocio:')),
                            GetBuilder<InformacionEncuestadoController>(
                              id: 'unidad_negocio',
                              builder: (_) => DropdownSearchWidget(
                                labelText: 'name',
                                labelValue: '_id',
                                selectedItem: _.unidadNegocioSelected == null
                                    ? null
                                    : {
                                        'name':
                                            '${_.unidadNegocioSelected.descripcion} ${_.unidadNegocioSelected.grupo}',
                                        '_id': _.unidadNegocioSelected.idunidad,
                                      },
                                onChanged: _.changeUnidadNegocio,
                                items: _.unidadesNegocio.length == 0
                                    ? []
                                    : _.unidadesNegocio
                                        .map((e) => {
                                              'name':
                                                  '${e.descripcion} ${e.grupo}',
                                              '_id': e.idunidad,
                                            })
                                        .toList(),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('Etapa:')),
                            GetBuilder<InformacionEncuestadoController>(
                              id: 'encuesta_etapa',
                              builder: (_) => DropdownSearchWidget(
                                labelText: 'name',
                                labelValue: '_id',
                                selectedItem: _.encuestaEtapaSelected == null
                                    ? null
                                    : {
                                        'name':
                                            '${_.encuestaEtapaSelected.descripcion}',
                                        '_id': _.encuestaEtapaSelected.idetapa,
                                      },
                                onChanged: _.changeEtapa,
                                items: _.encuestaEtapas.length == 0
                                    ? []
                                    : _.encuestaEtapas
                                        .map((e) => {
                                              'name':
                                                  '${e.descripcion}',
                                              '_id': e.idetapa,
                                            })
                                        .toList(),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('Campo:')),
                            GetBuilder<InformacionEncuestadoController>(
                              id: 'encuesta_campo',
                              builder: (_) => DropdownSearchWidget(
                                labelText: 'name',
                                labelValue: '_id',
                                selectedItem: _.encuestaCampoSelected == null
                                    ? null
                                    : {
                                        'name':
                                            '${_.encuestaCampoSelected.descripcion}',
                                        '_id': _.encuestaCampoSelected.idcampo,
                                      },
                                onChanged: _.changeCampo,
                                items: _.encuestaCampos.length == 0
                                    ? []
                                    : _.encuestaCampos
                                        .map((e) => {
                                              'name':
                                                  '${e.descripcion}',
                                              '_id': e.idcampo,
                                            })
                                        .toList(),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('Turno:')),
                            GetBuilder<InformacionEncuestadoController>(
                              id: 'encuesta_turno',
                              builder: (_) => DropdownSearchWidget(
                                labelText: 'name',
                                labelValue: '_id',
                                selectedItem: _.encuestaTurnoSelected == null
                                    ? null
                                    : {
                                        'name':
                                            '${_.encuestaTurnoSelected.descripcion}',
                                        '_id': _.encuestaTurnoSelected.idturno,
                                      },
                                onChanged: _.changeTurno,
                                items: _.encuestaTurnos.length == 0
                                    ? []
                                    : _.encuestaTurnos
                                        .map((e) => {
                                              'name':
                                                  '${e.descripcion}',
                                              '_id': e.idturno,
                                            })
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GetBuilder<InformacionEncuestadoController>(
            id: 'validando',
            builder: (_) => _.validando
                ? Container(
                    color: Colors.black45,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    )),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
