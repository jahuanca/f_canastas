import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/encuesta/graficos_encuesta/PieData.dart';
import 'package:flutter_actividades/ui/pages/encuesta/graficos_encuesta/graficos_encuesta_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficosEncuestaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GraficosEncuestaController>(
      id: 'validando',
      builder: (_) => Stack(
        children: [
          Scaffold(
            body: GetBuilder<GraficosEncuestaController>(
              
              builder: (_)=> PageView(
                controller: _.pageController,
                onPageChanged: _.onChanged,
                physics: NeverScrollableScrollPhysics(),
                children: [_circularChart(context), _barChart(context)],
              ),
              
            ),
          ),
          GetBuilder<GraficosEncuestaController>(
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

  Widget _circularChart(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Expanded(
          flex: 3,
          child: GetBuilder<GraficosEncuestaController>(
            id: 'data',
            builder: (_) => SafeArea(
              child: Scaffold(
                  body: SfCircularChart(
                      title: ChartTitle(text: _.encuestaSeleccionada.titulo),
                      legend: Legend(isVisible: true),
                      series: <PieSeries<PieData, String>>[
                    PieSeries<PieData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: _.dataSource,
                        xValueMapper: (PieData data, _) => data.xData,
                        yValueMapper: (PieData data, _) => data.yData,
                        dataLabelMapper: (PieData data, _) => data.text,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ])),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: arrows(),
          ),
          flex: 1,
        ),
      ],
    );
  }

  Widget _barChart(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Expanded(
          flex: 3,
          child: GetBuilder<GraficosEncuestaController>(
            id: 'data',
            builder: (_) => SafeArea(
              child: Scaffold(
                  body: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: _.mayorValor.toDouble(),
                          interval: 3),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      title: ChartTitle(text: _.encuestaSeleccionada.titulo),
                      series: <ChartSeries<PieData, String>>[
                    BarSeries<PieData, String>(
                        dataSource: _.dataSource,
                        name: _.encuestaSeleccionada.titulo,
                        xValueMapper: (PieData data, _) => data.xData,
                        yValueMapper: (PieData data, _) => data.yData,
                        dataLabelMapper: (PieData data, _) => data.text,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ])),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: arrows(),
          ),
          flex: 1,
        ),
      ],
    );
  }

    Widget arrows(){
    return GetBuilder<GraficosEncuestaController>(
      id: 'index',
      builder: (_)=> Row(
        children: [
          if(_.indexCurrent!=0)
          Expanded(child: Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: ()=> _.onChanged(0),
              icon: Icon(Icons.navigate_before, color: primaryColor )),
          ), flex: 1),
          if(_.indexCurrent!=1)
          Expanded(child: Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: ()=> _.onChanged(1),
              icon: Icon(Icons.navigate_next, color: primaryColor )),
          ), flex: 1),
        ],
      ),
    );
  }

}
