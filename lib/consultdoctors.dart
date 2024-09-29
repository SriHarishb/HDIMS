// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdims/main.dart';



class consultDoctors extends StatefulWidget {
  const consultDoctors({super.key});

  @override
  _consultDoctorsState createState() => _consultDoctorsState();
}

class _consultDoctorsState extends State<consultDoctors> {
  Future<HospitalList> fetchHospitals() async {
    final jsonString = await rootBundle.loadString('assets/Consult_your_Doc.json');
    final jsonResponse = jsonDecode(jsonString);
    return HospitalList.fromJson(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(
        title: const Text('Hospitals List'),
        
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        backgroundColor:const Color.fromARGB(255, 0, 221, 255),
      ),
      body: FutureBuilder<HospitalList>(
        future: fetchHospitals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final hospitals = snapshot.data!.hospitals;
            return ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                return HospitalCard(hospital: hospitals[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hospital.hospitalName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(hospital.hospitalAddress),
            const SizedBox(height: 5),
            Text('Contact: ${hospital.phone}, ${hospital.email}'),
            const SizedBox(height: 10),
            const Text('Doctors:'),
            Column(
              children: hospital.doctors.map((doctor) {
                return ListTile(
                  title: Text(doctor.name),
                  subtitle: Text('${doctor.specialization}, ${doctor.qualification}'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Contact: ${doctor.phone}'),
                      Text('Available: ${doctor.days.join(', ')}'),
                      Text('Timings: ${doctor.timings}'),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String qualification;
  final String specialization;
  final String phone;
  final String email;
  final List<String> days;
  final String timings;

  Doctor({
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.phone,
    required this.email,
    required this.days,
    required this.timings,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      qualification: json['qualification'],
      specialization: json['specialization'],
      phone: json['contact_info']['phone'],
      email: json['contact_info']['email'],
      days: List<String>.from(json['online_availability']['days']),
      timings: json['online_availability']['timings'],
    );
  }
}

class Hospital {
  final String hospitalName;
  final String hospitalAddress;
  final String phone;
  final String email;
  final List<Doctor> doctors;

  Hospital({
    required this.hospitalName,
    required this.hospitalAddress,
    required this.phone,
    required this.email,
    required this.doctors,
  });

factory Hospital.fromJson(Map<String, dynamic> json) {
  var list = json['doctors'] as List;
  List<Doctor> doctorsList = list.map((i) => Doctor.fromJson(i)).toList();

  return Hospital(
    hospitalName: json['hospital_name'],
    hospitalAddress: json['hospital_address'],
    phone: json['hospital_contact_info']['phone'],  
    email: json['hospital_contact_info']['email'],  
    doctors: doctorsList,
  );
}

}
class HospitalList {
  final List<Hospital> hospitals;

  HospitalList({required this.hospitals});

  factory HospitalList.fromJson(Map<String, dynamic> json) {
    var list = json['hospitals'] as List;
    List<Hospital> hospitalsList = list.map((i) => Hospital.fromJson(i)).toList();

    return HospitalList(hospitals: hospitalsList);
  }
}