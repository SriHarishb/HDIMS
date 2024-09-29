// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdims/main.dart';


class yourPres extends StatefulWidget {
  const yourPres({super.key});

  @override
  _yourPresState createState() => _yourPresState();
}

class _yourPresState extends State<yourPres> {
  late Future<Map<String, dynamic>> patientData;

  Future<Map<String, dynamic>> loadPatientData() async {
    final String response = await rootBundle.loadString('assets/Your_Prescription.json');
    final data = json.decode(response) as Map<String, dynamic>;
    return data;
  }

  @override
  void initState() {
    super.initState();
    patientData = loadPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(
        title: const Text('Patient Data'),
        
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        backgroundColor:const Color.fromARGB(255, 86, 73, 208),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: patientData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          final prescriptionHistory = data['prescriptionHistory'] as List<dynamic>;

          return ListView.builder(
            itemCount: prescriptionHistory.length,
            itemBuilder: (context, index) {
              final history = prescriptionHistory[index] as Map<String, dynamic>;
              final hospital = history['from']['hospital'];
              final doctor = history['from']['doctor'];
              final date = history['date'];
              final medicineList = history['medicine'] as List<dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Date: $date'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hospital: $hospital'),
                      Text('Doctor: $doctor'),
                      ...medicineList.map((med) {
                        final name = med['name'];
                        final amount = med['amount'];
                        final instructions = med['instructions'];
                        final timeOfDay = instructions['timeOfDay'];
                        final beforeOrAfterFood = instructions['beforeOrAfterFood'];
                        final duration = instructions['duration'];

                        return ListTile(
                          title: Text('Medicine: $name ($amount)'),
                          subtitle: Text('Time: $timeOfDay, Food: $beforeOrAfterFood, Duration: $duration'),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
