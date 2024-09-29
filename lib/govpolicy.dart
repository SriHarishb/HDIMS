// ignore_for_file: camel_case_types, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdims/main.dart';

class govPolicy extends StatefulWidget {
  @override
  _govPolicyState createState() => _govPolicyState();
}

class _govPolicyState extends State<govPolicy> {
  List<SchemeDivision> divisions = [];

  @override
  void initState() {
    super.initState();
    loadSchemesData();
  }
Future<void> loadSchemesData() async {
  final jsonData = await rootBundle.loadString('assets/Gov_Schemes.json');
  final Map<String, dynamic> data = json.decode(jsonData);

  List<SchemeDivision> loadedDivisions = [];

  // Access the 'divisions' array from the JSON data
  List<dynamic> divisionsData = data['divisions'] ?? [];

  // Iterate over the different divisions
  for (var division in divisionsData) {
    String divisionName = division['division_name'] ?? '';

    // Access the schemes/programmes list
    List<dynamic> schemesData = division['schemes'] ?? division['programmes'] ?? [];

    List<Scheme> schemesList = schemesData.map((schemeData) {
      return Scheme(
        name: schemeData['scheme_name'] ?? schemeData['programme_name'] ?? '',
        objective: schemeData['objective'] ?? '',
        keyFeatures: List<String>.from(schemeData['key_features'] ?? []),
        targetGroup: schemeData['target_group'] ?? '',
        implementedYear: schemeData['implemented_year'] ?? '',
      );
    }).toList();

    loadedDivisions.add(SchemeDivision(
      divisionName: divisionName,
      schemes: schemesList,
    ));
  }

  setState(() {
    divisions = loadedDivisions;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(title: const Text('Government Schemes'),
      
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        backgroundColor:const Color.fromARGB(255, 225, 156, 78),),
      body: ListView.builder(
        itemCount: divisions.length,
        itemBuilder: (context, index) {
          final division = divisions[index];
          return ExpansionTile(
            title: Text(division.divisionName),
            children: division.schemes.map((scheme) {
              return ExpansionTile(
                title: Text(scheme.name),
                children: [
                  ListTile(
                    title: Text('Objective: ${scheme.objective}'),
                  ),
                  ListTile(
                    title: Text('Target Group: ${scheme.targetGroup}'),
                  ),
                  ListTile(
                    title: Text('Implemented Year: ${scheme.implementedYear}'),
                  ),
                  ListTile(
                    title: const Text('Key Features:'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: scheme.keyFeatures
                          .map((feature) => Text('• $feature'))
                          .toList(),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class SchemeDivision {
  final String divisionName;
  final List<Scheme> schemes;

  SchemeDivision({required this.divisionName, required this.schemes});
}

class Scheme {
  final String name;
  final String objective;
  final List<String> keyFeatures;
  final String targetGroup;
  final String implementedYear;

  Scheme({
    required this.name,
    required this.objective,
    required this.keyFeatures,
    required this.targetGroup,
    required this.implementedYear,
  });
}
