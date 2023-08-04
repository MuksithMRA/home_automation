import 'package:flutter/material.dart';

class TimeSeriesChartModel {
  int id;
  String name;
  Color color;
  Color borderColor;
  List<TimeSeriesChartResult>? resultList;

  TimeSeriesChartModel({
    this.id = 0,
    this.name = '',
    this.color = Colors.blue,
    this.borderColor = Colors.blue,
    this.resultList,
  });
}

class TimeSeriesChartResult {
  DateTime? x;
  double y;

  TimeSeriesChartResult({
    this.x,
    this.y = 0,
  });
}
