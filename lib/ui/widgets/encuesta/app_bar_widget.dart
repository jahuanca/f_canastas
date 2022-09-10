import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/entregable/colors.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';

AppBar getAppBar(String titulo, List<Widget> actions, [bool bandera = false]) {
  return AppBar(
    automaticallyImplyLeading: bandera,
    iconTheme: IconThemeData(
      color: (PreferenciasUsuario().modoDark) ? Colors.white : Colors.black,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          titulo,
          style: TextStyle(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color:
                  PreferenciasUsuario().modoDark ? Colors.white : Colors.black),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '${PreferenciasUsuario().lastVersion} - ${PreferenciasUsuario().lastVersionDate}',
            style: TextStyle(
                fontSize: 11,
                color: PreferenciasUsuario().modoDark
                    ? Colors.white
                    : Colors.grey),
          ),
        ),
      ],
    ),
    backgroundColor: PreferenciasUsuario().modoDark ? cardColorDark : cardColor,
    shadowColor: PreferenciasUsuario().modoDark ? borderColorDark : borderColor,
    actions: actions,
  );
}

AppBar getAppBarChoose(String titulo, List<Widget> actions,
    [bool bandera = false, double dimen=1.5, AlignmentGeometry alignmentTitle=Alignment.center, double fontSize=24]) {
  return AppBar(
    automaticallyImplyLeading: bandera,
    toolbarHeight: kToolbarHeight * dimen,
    iconTheme: IconThemeData(
      color: (PreferenciasUsuario().modoDark) ? Colors.white : Colors.black,
    ),
    title: Container(
      alignment: alignmentTitle,
      child: Text(
        titulo,
        style: TextStyle(
            fontSize: fontSize,
            color: PreferenciasUsuario().modoDark ? Colors.white : Colors.black),
      ),
    ),
    backgroundColor: PreferenciasUsuario().modoDark ? cardColorDark : cardColor,
    elevation: 0,
    actions: actions,
    shadowColor: PreferenciasUsuario().modoDark ? borderColorDark : borderColor,
  );
}
