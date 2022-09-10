
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/encuesta/login/login_controller.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/button_login_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/button_social_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/dropdown_search_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/input_login_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {

  final LoginController controller=Get.find<LoginController>();
  
  @override
  Widget build(BuildContext context) {

    final Size size=MediaQuery.of(context).size;

    return GetBuilder<LoginController>(
      init: controller,
      builder: (_) => SafeArea(
        child: Stack(
            children: [
              Scaffold(
                backgroundColor: (PreferenciasUsuario().modoDark) ? cardColorDark : cardColor,
                  body: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height- MediaQuery.of(context).padding.top,
                        child: Row(
                          children: [
                            Flexible(child: Container(), flex: 1),
                            Flexible(child: Container(
                              child: Column(
                                children: [
                                  cabecera(),
                                  ingreso(context),
                                ],
                              ),
                            ), flex: 8),
                            Flexible(child: Container(), flex: 1),
                          ],
                      ),
                    ),
                  )
                
              ),
              GetBuilder<LoginController>(
                id: 'validando',
                builder: (_)=> _.validando ? Container(
                  color: Colors.black45,
                  child: Center(child: CircularProgressIndicator()),
                ) : Container(),
              ),
            ],
        ),
      ),
    );
  }

  Widget cabecera(){
    return Expanded(
      child: Column(
        children: [
          Expanded(child: logoWithTexto(), flex: 3,),
        ],
      ),
      flex: 2,
    );
  }

  Widget ingreso(BuildContext context){
    return Expanded(
      child: Column(
        children: [
          Expanded(child: formulario(context), flex: 4,),
          Expanded(child: registrate(), flex: 1,)
        ],
      ),
      flex: 4,
    );
  }

  Widget logoWithTexto(){
    return Container(
      child: Column(
        children: [
          Flexible(child: Container(
            padding: EdgeInsets.only(top: 30),
            width: 120,
            child: Lottie.asset('assets/common/gifs/check_list.json', repeat: false), 
          ), flex: 2),
          Flexible(child: Container(
            alignment: Alignment.center,
            child: Text('Inicie sesión para continuar'),
          ), flex: 1),
        ],
      ),
    );
  }

  Widget formulario(BuildContext context){
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: GetBuilder<LoginController>(
                id: 'usuario',
                builder: (_) => InputLoginWidget(
                    texto: 'Usuario', 
                    maxLength: 80,
                    onChanged: _.onValidationUsuario, 
                    error: _.errorUsuario,
                    
                    ),
              ),
              )),
          Flexible(
            flex: 1,
            child: Center(
              child: GetBuilder<LoginController>(
                id: 'password',
                builder: (_) => InputLoginWidget(
                    texto: 'Contraseña',
                    isObscure: true,
                    onChanged: _.onValidationPassword, 
                    error: _.errorPassword,
                    
                  ),
              ),
            )),
          Flexible(
            flex: 1,
            child: Center(
              child: GetBuilder<LoginController>(
                    id: 'puntos_entrega',
                    builder: (_) => DropdownSearchWidget(
                      labelText: 'name',
                      labelValue: '_id',
                      selectedItem: _.puntoEntregaSelected == null ? null : {
                        'name' : '${_.puntoEntregaSelected.nombre}',
                        '_id' : _.puntoEntregaSelected.id,
                      },
                      onChanged: _.changePuntoEntrega,
                      items: controller.puntosEntrega.length == 0
                          ? []
                          : controller.puntosEntrega
                              .map((e) => {
                                    'name': '${e.nombre}',
                                    '_id': e.id,
                                  })
                              .toList(),
                    ),
                  ),
              )),
          Flexible(
            flex: 1,
            child: Center(
              child: GetBuilder<LoginController>(

                builder: (_) => ButtonLogin(
                    onTap: _.ingresar,
                    texto: 'Ingresar'),
              ),
              )
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: ButtonSocialWidget(
                  onTap: controller.goSincronizar,
                  texto: 'Sincronizar'),
              )
          )
        ],
      ),
    );
  }

  Widget registrate(){
    return GetBuilder<LoginController>(
      id: 'version',
      builder: (_) => Container(
        child: Column(
          children: [
            Flexible(child: Container(
              alignment: Alignment.center,
              child: Text('Version ${_.version}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ), flex: 1),
            Flexible(child: GestureDetector(
                onTap: null,
                child: Container(
                  child: Text('Ult. Sincronización: '+ (_.ultimaSincronizacion==null ? '----' : formatoFechaHora(_.ultimaSincronizacion)),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ), flex: 1),
          ],
        ),
      ),
    );
  }
}