import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canastas/core/dimens.dart';
import 'package:flutter_canastas/ui/widgets/button_login_widget.dart';
import 'package:flutter_canastas/ui/widgets/input_label_widget.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final items = [
      {'_id': 1, 'name': 'Fecha'},
      {'_id': 2, 'name': 'Actividad'},
      {'_id': 3, 'name': 'Labor'},
      {'_id': 4, 'name': 'Persona'},
      {'_id': 5, 'name': 'Supervisor'},
    ];

    return Container(
      height: size.height * 0.9,
      child: Column(
        children: [
          Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(child: Container(), flex: 1),
                    Expanded(
                        child: Container(
                          child: Text(
                            'Filtros',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        flex: 7),
                    Expanded(child: Container(), flex: 1),
                    Expanded(
                        child: Container(
                          child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(Icons.close)),
                        ),
                        flex: 1),
                    Expanded(child: Container(), flex: 1),
                  ],
                ),
              ),
              flex: 1),
          Flexible(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                      child: InputLabelWidget(
                        hintText: 'Fecha',
                        label: 'Fecha',
                      )),
                  Container(
                      child: InputLabelWidget(
                    hintText: 'Actividad',
                    label: 'Actividad',
                  )),
                  Container(
                    child: InputLabelWidget(
                      hintText: 'Labor',
                      label: 'Labor',
                    ),
                  ),
                  Container(
                    child: InputLabelWidget(
                      hintText: 'Supervisor',
                      label: 'Supervisor',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                alignment: Alignment.center,
                color: Colors.white,
                child: ButtonLogin(
                  texto: 'Buscar',
                ),
              ),
              flex: 1),
        ],
      ),
    );
  }

}
