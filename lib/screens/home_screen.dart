import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/device_model.dart';
import '../providers/device_provider.dart';
import 'chart_widget.dart';

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
    pDevice.getData();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Automation'),
        ),
        body: Consumer<DeviceProvider>(
          builder: (context, cDevice, child) {
            return SingleChildScrollView(
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
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
                                child: PowerConsumptionChart.withDeviceData(
                                    context),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (_) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(25),
                                            height: screenSize.height * 0.35,
                                            width: screenSize.width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          "Your Complete Electricity Bill for ${DateFormat.MMMM().format(DateTime.now())}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Icon(
                                                              Icons.close))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20),
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.23,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: screenSize.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Total Bill Amount",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "LKR ${cDevice.totalUnits * cDevice.baseAmountPerUnit}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      const Text(
                                                        "Total Units Consumed",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "${cDevice.totalUnits} Units",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Wrap(
                        children:
                            List.generate(cDevice.devices.length, (index) {
                          DeviceModel device = cDevice.devices[index];
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Turned ${device.isOn == 1 ? 'On' : 'Off'}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${device.currentUsage} kWh",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Transform.rotate(
                                            angle: -90 * pi / 180,
                                            child: Switch(
                                                value: device.isOn == 1,
                                                onChanged: (isOn) async {
                                                  await cDevice
                                                      .turnOnOrOffDevice(
                                                    device.relayNo,
                                                    isOn ? 1 : 0,
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
