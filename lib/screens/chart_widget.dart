import 'dart:math';

import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:home_automation/providers/device_provider.dart';
import 'package:provider/provider.dart';

class PowerConsumptionChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  const PowerConsumptionChart(this.seriesList,
      {super.key, this.animate = false});

  factory PowerConsumptionChart.withDeviceData(BuildContext context) {
    return PowerConsumptionChart(
      _createDeviceData(context),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  static List<charts.Series<DevicePower, String>> _createDeviceData(
      BuildContext context) {
    DeviceProvider pDevice =
        Provider.of<DeviceProvider>(context, listen: false);
    final data = List.generate(
      pDevice.devices.length,
      (index) => DevicePower(
        pDevice.devices[index].deviceName,
        Random().nextInt(1000),
      ),
    );

    return [
      charts.Series<DevicePower, String>(
        id: 'Power',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (DevicePower power, _) => power.year,
        measureFn: (DevicePower power, _) => power.sales,
        data: data,
      )
    ];
  }
}

class DevicePower {
  final String year;
  final int sales;

  DevicePower(this.year, this.sales);
}
