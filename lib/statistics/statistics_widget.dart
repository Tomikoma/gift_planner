import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gift_planner/l10n/gift_planner_localizations.dart';
import 'package:gift_planner/statistics/statistics_classes.dart';

class StatisticsWidget extends StatefulWidget {
  @override
  _StatisticsWidgetState createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  List<TopThreeSumAvg> list = [];
  List<charts.Color> colorList = [
    materialColorToChartsColor(Colors.red),
    materialColorToChartsColor(Colors.yellow),
    materialColorToChartsColor(Colors.green)
  ];

  @override
  void initState() {
    super.initState();
    loadTopThreeSumAvg();
  }

  Future<void> loadTopThreeSumAvg() async {
    var listLoaded = await TopThreeSumAvg.dataList;
    setState(() {
      list = listLoaded;
    });
  }

  static charts.Color materialColorToChartsColor(Color color) {
    return charts.Color(
        r: color.red, g: color.green, b: color.blue, a: color.alpha);
  }

  List<charts.Series<TopThreeSumAvg, String>> constructTopThreeSumAvgSeries() {
    return [
      charts.Series(
          domainFn: (TopThreeSumAvg topData, _) => topData.name,
          measureFn: (TopThreeSumAvg topData, _) => topData.avg,
          colorFn: (TopThreeSumAvg topData, _) => colorList[0],
          id: 'Avg',
          data: list)
    ];
  }

  List<charts.Series<TopThreeSumAvg, String>>
      constructTopThreeSumSeriesForPie() {
    return [
      charts.Series(
          domainFn: (TopThreeSumAvg topData, _) => topData.name,
          measureFn: (TopThreeSumAvg topData, _) => topData.sum,
          colorFn: (TopThreeSumAvg topData, _) =>
              charts.MaterialPalette.indigo.shadeDefault,
          labelAccessorFn: (TopThreeSumAvg topData, _) => '${topData.name}: ${topData.sum}',
          id: 'Sum',
          data: list),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GiftPlannerLocalizations.of(context).statistics),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(32.0),
            child: SizedBox(
              height: 200.0,
              child: charts.BarChart(
                constructTopThreeSumAvgSeries(),
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [
                  new charts.ChartTitle(GiftPlannerLocalizations.of(context).statisticsPersons,
                      behaviorPosition: charts.BehaviorPosition.bottom),
                  new charts.ChartTitle(GiftPlannerLocalizations.of(context).statisticsTopThreeSumAvg,
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification:
                          charts.OutsideJustification.start,
                      innerPadding: 18),
                  new charts.ChartTitle('Ft',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32.0),
            child: SizedBox(
              height: 300.0,
              child: charts.PieChart(
                constructTopThreeSumSeriesForPie(),
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [
                      new charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.auto)
                    ]),
                behaviors: [
                  // new charts.ChartTitle("NEVEK",
                  //     behaviorPosition: charts.BehaviorPosition.bottom),
                  new charts.ChartTitle(GiftPlannerLocalizations.of(context).statisticsTopThreeSum,
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification:
                          charts.OutsideJustification.start,
                      innerPadding: 18),
                  // new charts.ChartTitle('Ft',
                  //     behaviorPosition: charts.BehaviorPosition.start,
                  //     titleOutsideJustification:
                  //         charts.OutsideJustification.middleDrawArea),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
