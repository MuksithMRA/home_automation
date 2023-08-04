import 'package:flutter/material.dart';
import 'package:home_automation/models/device_model.dart';

class DeviceProvider extends ChangeNotifier {
  List<DeviceModel> devices = [
    DeviceModel(
      deviceName: "Light Bulb",
      image: "assets/light_bulb.jpg",
    ),
    DeviceModel(
      deviceName: "Fan",
      image: "assets/fan.jpg",
    ),
    DeviceModel(
      deviceName: "Rice Cooker",
      image: "assets/rice_cooker.jpg",
    ),
    DeviceModel(
      deviceName: "Television",
      image: "assets/tv.jpg",
    ),
  ];
}
