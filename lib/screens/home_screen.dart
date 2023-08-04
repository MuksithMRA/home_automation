import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_automation/models/device_model.dart';
import 'package:home_automation/providers/device_provider.dart';
import 'package:home_automation/screens/chart_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size screenSize;
  late DeviceProvider pDevice;

  @override
  void initState() {
    super.initState();
    pDevice = context.read<DeviceProvider>();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Automation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    "This Month Power Consumption",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Chip(
                    side: BorderSide.none,
                    backgroundColor: Theme.of(context).primaryColor,
                    labelStyle: const TextStyle(color: Colors.white),
                    label: Text(DateFormat.MMMM().format(DateTime.now())))
              ],
            ),
            Wrap(
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: screenSize.height * 0.45,
                    width: screenSize.width,
                    child: Column(
                      children: [
                        Expanded(
                            child:
                                PowerConsumptionChart.withDeviceData(context)),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "View Monthly Bill",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: screenSize.width,
                  child: const Text(
                    "Available Devices",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ...List.generate(pDevice.devices.length, (index) {
                  DeviceModel device = pDevice.devices[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 20, right: index % 2 == 0 ? 10 : 0),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: screenSize.height * 0.35,
                        width: screenSize.width * 0.45,
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.asset(device.image)),
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            device.deviceName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            "Turned Off",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: 90 * pi / 180,
                                    child: Switch(
                                        value: false, onChanged: (value) {}),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
