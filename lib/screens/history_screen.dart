import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('steps')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var stepData = data[index];
              var date = stepData['date'].toDate();
              var steps = stepData['steps'];

              return ListTile(
                title: Text('Date: ${date.toString()}'),
                subtitle: Text('Steps: $steps'),
              );
            },
          );
        },
      ),
    );
  }
}
