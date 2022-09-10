import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/core/encuesta/styles.dart';
import 'package:flutter_actividades/ui/pages/encuesta/navigation/navigation_controller.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/navigation_drawer/navigation_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer getDrawer(Size size, GlobalKey<ScaffoldState> scaffoldKey) {
  return Drawer(
    child: GetBuilder<NavigationDrawerController>(
      init: NavigationDrawerController(),
      builder: (_) => Container(
        color: (PreferenciasUsuario().modoDark) ? secondColorDark : secondColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: size.height * 0.35,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: (PreferenciasUsuario().modoDark)
                      ? primaryColorDark
                      : primaryColor,
                ),
                child: Container(
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          child: GetBuilder<NavigationDrawerController>(
                            builder: (_) => GestureDetector(
                              onTap: _.goProfile,
                              child: Hero(
                                tag: 'profile',
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                'assets/common/images/ic_profile.png')))),
                              ),
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      Flexible(
                        child: Container(
                          child: GetBuilder<NavigationDrawerController>(
                            id: 'usuario',
                            builder: (_) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Text(
                                  _.usuarioEntity?.apellidosnombres ?? '',
                                  style: TextStyle(
                                      color: (PreferenciasUsuario().modoDark)
                                          ? cardColorDark
                                          : cardColor,
                                      fontSize: 16),
                                )),
                                Center(
                                    child: Text(
                                  _.usuarioEntity?.alias ?? '',
                                  style: TextStyle(
                                      color: (PreferenciasUsuario().modoDark)
                                          ? cardColorDark
                                          : cardColor),
                                )),
                              ],
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _itemDrawer(
                size, Icons.home, 'Inicio', () => _.goHome(scaffoldKey), ),
            _itemDrawer(
                size, Icons.checklist_outlined, 'Encuestas', () => _.goEncuestas(scaffoldKey)),
            _itemDrawer(
                size, Icons.construction, 'Herramientas', _.goMisEventos),
            _itemDrawer(size, Icons.settings, 'Configuración', _.goMisEventos),
            _itemDrawer(
                size, Icons.exit_to_app, 'Cerrar sesión', _.cerrarSesion),
          ],
        ),
      ),
    ),
  );
}

Widget _itemDrawer(
    Size size, dynamic icon, String texto, void Function() onTap) {
  return GetBuilder<NavigationController>(
    id: 'bottom_navigation',
    builder: (_)=> GestureDetector(
      onTap: onTap,
      child: Container(
        color:  texto==_.titulo ? Colors.white : Colors.transparent,
        height: size.height * inputDimension * 0.9,
        child: Row(
          children: [
            Flexible(
                child: Container(
                  alignment: Alignment.center,
                  child: (icon is IconData)
                      ? Icon(icon, color: starColor)
                      : ImageIcon(AssetImage(icon), color: starColor),
                ),
                flex: 1),
            Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    texto,
                    style: PreferenciasUsuario().modoDark
                        ? drawerOptionDarkStyle()
                        : drawerOptionStyle(),
                  ),
                ),
                flex: 4),
          ],
        ),
      ),
    ),
  );
}
