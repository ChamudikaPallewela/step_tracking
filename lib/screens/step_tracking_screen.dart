import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StepTrackingScreen extends StatefulWidget {
  @override
  _StepTrackingScreenState createState() => _StepTrackingScreenState();
}

class _StepTrackingScreenState extends State<StepTrackingScreen> {
  String _stepCountValue = '0';
  bool isWalking = false;

  @override
  void initState() {
    super.initState();
    initPedometer();
  }

  void initPedometer() {
    Pedometer pedometer = Pedometer();
    Pedometer.stepCountStream.listen(onStepCount).onError(onError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _stepCountValue = event.steps.toString();
      isWalking = true;
      saveStepsToFirebase(event.steps);
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isWalking = false;
      });
    });
  }

  void onError(error) {
    print("Pedometer Error: $error");
  }

  void saveStepsToFirebase(int steps) {
    FirebaseFirestore.instance.collection('steps').add({
      'date': DateTime.now(),
      'steps': steps,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isWalking
                ? Icon(Icons.directions_walk, size: 100, color: Colors.blue)
                : Icon(Icons.accessibility, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              _stepCountValue,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            Text(
              'Steps Today',
              style: TextStyle(fontSize: 24, color: Colors.grey[600]),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
