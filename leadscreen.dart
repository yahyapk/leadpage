import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/datetimeformat.dart';
import 'package:login/login1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/leads_model.dart';

class Lead extends StatefulWidget {
  const Lead({super.key});

  @override
  State<Lead> createState() => _LeadState();
}

class _LeadState extends State<Lead> {
  Future<LeadsModel> fetchLeads() async {
    final response = await http.get(
        Uri.parse('https://crm-beta-api.vozlead.in/api/v2/lead/lead_list/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token 92027d4c10d246c44007206174c01871582161e3'
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return LeadsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to lead leads');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.white,
        leading: Icon(Icons.list_outlined, color: Colors.black, size: 45),
        title: Text(
          'Lead List',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: Colors.black, size: 35)),
          IconButton(
            onPressed: () {
              signout(context);
            },
            icon: Icon(Icons.logout, size: 35, color: Colors.red),
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchLeads(),
        builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      LeadsModel leadsModel = snapshot.data!;
    return Column(
    children: [
    Expanded(
    child: ListView.separated(
    scrollDirection: Axis.vertical,
    itemCount: leadsModel.data!.leads!.length,
    itemBuilder: (context, index) {
    // Map<String, dynamic> leadData = dataList[index];
    return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
    height: MediaQuery.of(context).size.height /5,
    width: MediaQuery.of(context).size.width /1,
    decoration: BoxDecoration(
    color: Colors.white70,
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 2,
    blurRadius: 20,
    offset: Offset(0, 7),
    ),
    ],
    borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Container(
    width:
    MediaQuery.of(context).size.width / 8.5,
    height: MediaQuery.of(context).size.height /12,
    decoration: BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
    child: Text(
    '${index + 1}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25),
    ),
    ),
    ),
    ),
    Padding(
    padding:
    const EdgeInsets.only(left: 10),
    child: Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    leadsModel.data!.leads![index].name!,
    style: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 22,
    ),
    ),
    Text(
      leadsModel.data!.leads![index].email!,
    style: TextStyle(
    fontSize: 13, color: Colors.grey),
    ),
    Text(
    'created:${leadsModel.data!.leads![index].createdAt!.fullDate()}',
    style: TextStyle(
    fontSize: 13, color: Colors.grey),
    ),
    Text(
    'Mob:${leadsModel.data!.leads![index].mobile!}',
    style: TextStyle(
    fontSize: 13, color: Colors.grey),
    ),
    ],
    ),
    ),
    SizedBox(width: 10),
    ElevatedButton(
    onPressed: () {},
    child: Text(
    'Flutter',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 11),
    ),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    ),
    ),
    ),
    SizedBox(width: 10),
    Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Icon(Icons.call, size: 40),
    ),
    ],
    ),
    ),
    ),
    ],
    );
    },
    separatorBuilder: (BuildContext context, int index) {
    return SizedBox(
    height: 20,
    );
    },
    ),
    ),
    ],
    );
    }
        },
      ),
    );
  }

  signout(BuildContext context) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context1) => login()),
      (route) => false,
    );
  }
}
