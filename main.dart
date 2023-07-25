import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Blue Archive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<dynamic> studentList = [];

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    final response = 
        await http.get(Uri.parse('https://api-blue-archive.vercel.app/api/characters?page=1&perPage=20'));
        
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data is List) {
        setState(() {
          studentList = data;
        });
      }
    } else {
      print('Failed to fetch student data');
    }
  }

  @override
  Widget build(BuildContext context) {
     // Implementasi tampilan aplikasi di sini
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('Student Blue Archive'),
      ),
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          final student = studentList[index];
          return ListTile(
            title: Text(student['name'] ?? ''),
            subtitle: Text(student['birthday'] ?? ''),
            trailing: Text(student['photoUrl'] ?? ''),
          );
        },
      ),
      )
    );
  }
}