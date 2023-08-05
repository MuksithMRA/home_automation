import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/models/device_model.dart';

class DeviceProvider extends ChangeNotifier {
  List<DeviceModel> devices = [
    DeviceModel(
      deviceName: "Light Bulb",
      image: "assets/light_bulb.jpg",
      relayNo: 1,
    ),
    DeviceModel(
      deviceName: "Fan",
      image: "assets/fan.jpg",
      relayNo: 2,
    ),
    DeviceModel(
      deviceName: "Rice Cooker",
      image: "assets/rice_cooker.jpg",
      relayNo: 3,
    ),
    DeviceModel(
      deviceName: "Television",
      image: "assets/tv.jpg",
      relayNo: 4,
    ),
  ];

  int totalUnits = 0;
  double totalAmount = 0;
  double baseAmountPerUnit = 100;

  getData() {
    List<DeviceModel> tempDevices = devices;
    DatabaseReference relayRef = FirebaseDatabase.instance.ref('relay');
    relayRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map;
      for (var element in tempDevices) {
        element.isOn = data['switch${element.relayNo.toString()}'];
      }
      devices = tempDevices;
      notifyListeners();
    });
    DatabaseReference kwhRef = FirebaseDatabase.instance.ref('Kwh');
    kwhRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map;
      totalUnits = data['TotalKWH'];
      for (var element in tempDevices) {
        element.currentUsage = data['Wh${element.relayNo.toString()}'];
      }
      devices = tempDevices;
      notifyListeners();
    });
  }

  turnOnOrOffDevice(int relayNo, int isOn) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("relay");
    await ref.update({
      "switch${relayNo.toString()}": isOn,
    });
  }
}
