import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'training_session_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Training Sessions',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OpenSan'),
      home: TrainingSessionList(),
    );
  }
}
