import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/entregable/colors.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/ui/pages/entregable/agregar_persona/agregar_persona_controller.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:flutter_actividades/ui/widgets/entregable/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/button_login_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/date_picker_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/dropdown_search_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/input_label_widget.dart';
import 'package:flutter_actividades/ui/widgets/entregable/item_configuracion_swicth_widget.dart';
import 'package:get/get.dart';

class AgregarPersonaPage extends StatelessWidget {
  final AgregarPersonaController controller =
      Get.find<AgregarPersonaController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<AgregarPersonaController>(
      init: controller,
      builder: (_) => Scaffold(
        appBar: getAppBar('Agregar persona', [], true),
        backgroundColor: secondColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    if (_.cantidadEnviada == 0)
                      GetBuilder<AgregarPersonaController>(
                        id: 'personal',
                        builder: (_) => DropdownSearchWidget(
                            label: 'Personal',
                            labelText: 'name',
                            error: _.errorPersonal,
                            labelValue: 'codigoempresa',
                            onChanged: _.changePersonal,
                            selectedItem: _.personalTareaProcesoEntity?.personal==null ? null : {
                              'name': _.personalTareaProcesoEntity.personal.nombreCompleto,
                              'codigoempresa': _.personalTareaProcesoEntity.personal.codigoempresa,
                            },
                            items: _.personalEmpresa.length == 0
                                ? []
                                : controller.personalEmpresa
                                    .map((PersonalEmpresaEntity e) => {
                                          'name':
                                              '${e.apellidopaterno} ${e.apellidomaterno}, ${e.nombres}',
                                          'codigoempresa': e.codigoempresa,
                                        })
                                    .toList()),
                      ),
                    if (_.cantidadEnviada != 0)
                      Container(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: InputLabelWidget(
                          enabled: false,
                          hintText: '${controller.cantidadEnviada} personas',
                        ),
                      ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'hora_inicio',
                      builder: (_) => InputLabelWidget(
                          enabled: false,
                          onTap: () async {
                            _.personalTareaProcesoEntity.horainicio =
                                await DatePickerWidget(
                              onlyDate: true,
                              dateSelected: DateTime.now(),
                            ).selectTime(context,
                                    _.personalTareaProcesoEntity.horainicio);
                            _.changeHoraInicio();
                          },
                          label: 'Hora inicio',
                          textEditingController: TextEditingController(
                              text: formatoHora(
                                  _.personalTareaProcesoEntity.horainicio)),
                          hintText: 'Hora inicio'),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'hora_fin',
                      builder: (_) => InputLabelWidget(
                          enabled: false,
                          onTap: () async {
                            _.personalTareaProcesoEntity
                                .horafin = await DatePickerWidget(
                              onlyDate: true,
                              //minDate: _.personalTareaProcesoEntity.horainicio,
                              dateSelected:
                                  _.personalTareaProcesoEntity.horafin ??
                                      DateTime.now(),
                              onChanged: () {},
                            ).selectTime(
                                context, _.personalTareaProcesoEntity.horafin);
                            _.changeHoraFin();
                          },
                          label: 'Hora fin',
                          textEditingController: TextEditingController(
                              text: formatoHora(
                                  _.personalTareaProcesoEntity.horafin)),
                          hintText: 'Hora fin'),
                    ),
                    GetBuilder<AgregarPersonaController>(
                        id: 'inicio_pausa',
                        builder: (_) => (_.personalTareaProcesoEntity
                                        .horainicio !=
                                    null &&
                                _.personalTareaProcesoEntity.horafin != null)
                            ? Column(
                                children: [
                                  InputLabelWidget(
                                      enabled: false,
                                      error: _.errorPausaInicio,
                                      iconOverlay: Icons.delete,
                                      onPressedIconOverlay: _.deleteInicioPausa,
                                      onTap: () async {
                                        _.personalTareaProcesoEntity
                                                .pausainicio =
                                            await DatePickerWidget(
                                          onlyDate: true,
                                          //minDate: _.personalTareaProcesoEntity.horainicio ,
                                          dateSelected: DateTime.now(),
                                          onChanged: () {},
                                        ).selectTime(
                                                context, _.personalTareaProcesoEntity.horainicio ?? DateTime.now());
                                        _.changeInicioPausa();
                                      },
                                      textEditingController:
                                          TextEditingController(
                                              text: formatoHora(
                                        _.personalTareaProcesoEntity
                                            .pausainicio,
                                      )),
                                      label: 'Inicio de pausa',
                                      hintText: 'Inicio de pausa'),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                ],
                              )
                            : Container()),
                    GetBuilder<AgregarPersonaController>(
                      id: 'fin_pausa',
                      builder: (_) => (_.personalTareaProcesoEntity.horainicio != null &&
                                _.personalTareaProcesoEntity.horafin != null)
                      ? InputLabelWidget(
                          enabled: false,
                          iconOverlay: Icons.delete,
                          onPressedIconOverlay: _.deleteFinPausa,
                          error: _.errorPausaFin,
                          onTap: () async {
                            _.personalTareaProcesoEntity.pausafin =
                                await DatePickerWidget(
                              onlyDate: true,
                              //minDate: _.personalTareaProcesoEntity.pausainicio ,
                              dateSelected: DateTime.now(),
                            ).selectTime(context, _.personalTareaProcesoEntity?.pausainicio ?? new DateTime.now());
                            _.changeFinPausa();
                          },
                          textEditingController: TextEditingController(
                              text: formatoHora(
                                  _.personalTareaProcesoEntity.pausafin)),
                          label: 'Fin de pausa',
                          hintText: 'Fin de pausa')
                        : Container()
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'rendimiento',
                      builder: (_) => ItemConfiguracionSwitchWidget(
                        onChanged: _.changeRendimiento,
                        size: size,
                        label: 'Rendimiento/Jornal',
                        tituloTrue: 'Es jornal',
                        tituloFalse: 'Es rendimiento',
                        value: _.personalTareaProcesoEntity.esjornal ?? false,
                      ),
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'dia_siguiente',
                      builder: (_) => ItemConfiguracionSwitchWidget(
                        onChanged: _.changeDiaSiguiente,
                        size: size,
                        label: 'Dia siguiente',
                        tituloTrue: 'Es dia siguiente',
                        tituloFalse: 'No es dia siguiente',
                        value:
                            _.personalTareaProcesoEntity.diasiguiente ?? false,
                      ),
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'turno',
                      builder: (_) => DropdownSearchWidget(
                          label: 'Turno',
                          labelText: 'name',
                          labelValue: '_id',
                          selectedItem: {
                            'name': 'Dia',
                            '_id': '1',
                          },
                          onChanged: _.changeTurno,
                          items: [
                            {
                              'name': 'Dia',
                              '_id': '1',
                            },
                            {
                              'name': 'Noche',
                              '_id': '2',
                            },
                          ]),
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'cantidad_horas',
                      builder: (_) => InputLabelWidget(
                        hintText: 'Cantidad Horas',
                        textEditingController: TextEditingController(text: _.textoCantidadHoras),
                        enabled: false,
                        textInputType: TextInputType.number,
                        label: 'Cantidad Horas',
                      ),
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'cantidad_rendimiento',
                      builder: (_) => InputLabelWidget(
                        hintText: 'Cantidad rendimiento',
                        error: _.errorCantidadRendimiento,
                        onChanged: _.changeCantidadRendimiento,
                        textInputType: TextInputType.number,
                        label: 'Cantidad rendimiento',
                      ),
                    ),
                    GetBuilder<AgregarPersonaController>(
                      id: 'cantidad_avance',
                      builder: (_) => InputLabelWidget(
                        hintText: 'Cantidad avance',
                        error: _.errorCantidadAvance,
                        onChanged: _.changeCantidadAvance,
                        textInputType: TextInputType.number,
                        label: 'Cantidad avance',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    ButtonLogin(
                      texto: 'Guardar',
                      onTap: _.guardar,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<AgregarPersonaController>(
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
}
