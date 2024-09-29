// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

dynamic shadeMRBG = const Color.fromARGB(255, 225, 156, 78);
dynamic shadeWhite = Colors.white;

class yourDevices extends StatefulWidget {
  const yourDevices({super.key});

  @override
  State<yourDevices> createState() => _yourDevicesState();
}

class Records {
  String device_id;
  String device_name;
  String manufacturer;
  String model;
  String device_type;
  String last_synced;
  String metrics_tracked;
  String battery_life;
  Map<String, dynamic> user_data;

  Records({
    required this.device_id,
    required this.device_name,
    required this.manufacturer,
    required this.model,
    required this.device_type,
    required this.last_synced,
    required this.metrics_tracked,
    required this.battery_life,
    required this.user_data,
  });

  factory Records.fromJson(Map<String, dynamic> json) {
    return Records(
      device_id: json['device_id'],
      device_name: json['device_name'],
      manufacturer: json['manufacturer'],
      model: json['model'],
      device_type: json['device_type'],
      last_synced: json['last_synced'],
      metrics_tracked: json['metrics_tracked'].join(', '),
      battery_life: json['battery_life'],
      user_data: Map<String, dynamic>.from(json['user_data']),
    );
  }
}

class _yourDevicesState extends State<yourDevices> {
  List<Records> records = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String data = await rootBundle.loadString('assets/HealthCareDevices.json');
    final jsonResult = json.decode(data);
    setState(() {
      records = (jsonResult['devices'] as List)
          .map((device) => Records.fromJson(device))
          .toList();
    });
  }

  Widget buildUserDataChart(Map<String, dynamic> userData, String tag) {
    List<ChartData> chartData = [];

    userData.forEach((date, metrics) {
      if (metrics is Map<String, dynamic> && metrics.containsKey('steps')) {
        chartData.add(ChartData(date, metrics['steps'].toDouble()));
      }
    });

    return Hero(
      tag: tag,  // Unique tag for the Hero widget
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: const ChartTitle(text: 'User Data'),
        series: <CartesianSeries<ChartData, String>>[
          StackedAreaSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.date,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        backgroundColor: const Color.fromARGB(254, 255, 208, 0),
        title: const Text("Your Devices"),
      ),
      body: records.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ExpansionTile(
                  title: Text(record.device_name),
                  subtitle: Text('Manufacturer: ${record.manufacturer}\n'
                      'Model: ${record.model}\n'
                      'Type: ${record.device_type}\n'
                      'Last Synced: ${record.last_synced}\n'
                      'Metrics Tracked: ${record.metrics_tracked}\n'
                      'Battery Life: ${record.battery_life}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildUserDataChart(record.user_data, 'chartHero_$index'),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class ChartData {
  final String date;
  final double value;

  ChartData(this.date, this.value);
}
