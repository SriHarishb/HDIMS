// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdims/main.dart'; 


class medicalRecords extends StatelessWidget {
  const medicalRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const medicalRecordsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class medicalRecordsScreen extends StatefulWidget {
  const medicalRecordsScreen({super.key});

  @override
  _medicalRecordsScreenState createState() => _medicalRecordsScreenState();
}

class _medicalRecordsScreenState extends State<medicalRecordsScreen> {
  Map<String, dynamic> medicalRecords = {};

  @override
  void initState() {
    super.initState();
    loadmedicalRecords();
  }

  Future<void> loadmedicalRecords() async {
    String data = await rootBundle.loadString('assets/Medical_History.json'); 
    setState(() {
      medicalRecords = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2),
    child: Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(
        
        title: const Text('Patient Medical History'),
          leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
    },
  ),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 170, 91, 244),
      ),
      body: medicalRecords.isNotEmpty
          ? ListView(
              padding: const EdgeInsets.all(10),
              children: [
                _buildPersonalInformation(),
                _buildMedicalData(),
                _buildmedicalRecords(),
                _buildRecentLabResults(),
                _buildUpcomingAppointments(),
                _buildImmunizationRecords(),
                _buildFamilymedicalRecords(),
                _buildLifestyleAndHabits(),
                _buildDiagnosticReports(),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    ));
  }

  Widget _buildPersonalInformation() {
    var info = medicalRecords['personal_information'];
    return Card(
      child: ListTile(
        title: const Text('Personal Information'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${info['name']}'),
            Text('DOB: ${info['date_of_birth']}'),
            Text('Gender: ${info['gender']}'),
            Text('Blood Type: ${info['blood_type']}'),
            Text('Allergies: ${info['allergies'].join(', ')}'),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalData() {
    var data = medicalRecords['basic_medical_data'];
    return Card(
      child: ListTile(
        title: const Text('Basic Medical Data'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Height: ${data['height_cm']} cm'),
            Text('Weight: ${data['weight_kg']} kg'),
            Text('BMI: ${data['bmi']}'),
            Text('Blood Pressure: ${data['blood_pressure']['systolic']}/${data['blood_pressure']['diastolic']}'),
            Text('Heart Rate: ${data['heart_rate']} bpm'),
            Text('Respiratory Rate: ${data['respiratory_rate']} breaths/min'),
            Text('Oxygen Saturation: ${data['oxygen_saturation']}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildmedicalRecords() {
    var history = medicalRecords['medical_history'];
    return Card(
      child: ListTile(
        title: const Text('Medical History'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chronic Conditions: ${history['chronic_conditions'].join(', ')}'),
            const Text('Past Surgeries:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: history['past_surgeries'].map<Widget>((surgery) {
                return Text('${surgery['surgery']} on ${surgery['date']} at ${surgery['hospital']}');
              }).toList(),
            ),
            const Text('Medications:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: history['medications'].map<Widget>((medication) {
                return Text('${medication['name']} - ${medication['dosage']} (${medication['frequency']})');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLabResults() {
    var labs = medicalRecords['recent_lab_results']['blood_tests'];
    return Card(
      child: ListTile(
        title: const Text('Recent Lab Results'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hemoglobin: ${labs['hemoglobin']}'),
            Text('White Blood Cells: ${labs['white_blood_cells']}'),
            Text('Platelets: ${labs['platelets']}'),
            Text('Glucose (Fasting): ${labs['glucose_fasting']}'),
            Text('Cholesterol: Total ${labs['cholesterol']['total']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    var appointments = medicalRecords['upcoming_appointments'];
    return Card(
      child: ListTile(
        title: const Text('Upcoming Appointments'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: appointments.map<Widget>((appointment) {
            return Text('${appointment['specialist']} on ${appointment['date']} at ${appointment['hospital']}');
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildImmunizationRecords() {
    var records = medicalRecords['immunization_records'];
    return Card(
      child: ListTile(
        title: const Text('Immunization Records'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: records.map<Widget>((record) {
            return Text('${record['vaccine']} on ${record['date']}');
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFamilymedicalRecords() {
    var familyHistory = medicalRecords['family_medical_history'];
    return Card(
      child: ListTile(
        title: const Text('Family Medical History'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Father: ${familyHistory['father'].join(', ')}'),
            Text('Mother: ${familyHistory['mother'].join(', ')}'),
            Text('Siblings: ${familyHistory['siblings'].join(', ')}'),
          ],
        ),
      ),
    );
  }

  Widget _buildLifestyleAndHabits() {
    var lifestyle = medicalRecords['lifestyle_and_habits'];
    return Card(
      child: ListTile(
        title: const Text('Lifestyle and Habits'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Smoking Status: ${lifestyle['smoking_status']}'),
            Text('Alcohol Consumption: ${lifestyle['alcohol_consumption']}'),
            Text('Diet: ${lifestyle['diet']}'),
            Text('Physical Activity: ${lifestyle['physical_activity']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticReports() {
    var reports = medicalRecords['diagnostic_reports'];
    return Card(
      child: ListTile(
        title: const Text('Diagnostic Reports'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: reports.map<Widget>((report) {
            return Text('${report['type']} on ${report['date']} at ${report['hospital']}');
          }).toList(),
        ),
      ),
    );
  }
}