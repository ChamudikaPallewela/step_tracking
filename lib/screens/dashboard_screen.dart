import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('steps')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Step 1: Group and sum the steps by day
          var data = snapshot.data!.docs;
          Map<String, int> dailySteps = {};
          for (var doc in data) {
            DateTime date = doc['date'].toDate();
            String dateString = '${date.day}-${date.month}-${date.year}'; // Format as 'day-month-year'

            // Cast steps to int explicitly to prevent type mismatch
            int steps = doc['steps'] is int ? doc['steps'] : doc['steps'].toInt();

            // Sum the steps for the same day
            if (dailySteps.containsKey(dateString)) {
              dailySteps[dateString] = dailySteps[dateString]! + steps;
            } else {
              dailySteps[dateString] = steps;
            }
          }

          // Convert dailySteps map into a list of FlSpot
          List<FlSpot> spots = [];
          List<String> dates = [];
          dailySteps.forEach((date, steps) {
            // Convert dateString to DateTime for chart (to use as x-axis)
            DateTime dateTime = DateTime.parse('2025-01-04'); // Example format '2025-01-04'
            spots.add(FlSpot(dateTime.millisecondsSinceEpoch.toDouble(), steps.toDouble())); // Explicitly convert to double
            dates.add(date);
          });

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Steps Over Time',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey,
                            strokeWidth: 0.5,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.grey,
                            strokeWidth: 0.5,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          axisNameWidget: Text('Steps'),
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text('Date'),
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                              return Text('${date.day}/${date.month}', style: TextStyle(color: Colors.black, fontSize: 10));
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.blueAccent, width: 1),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: Colors.blueAccent, // Line color
                          belowBarData: BarAreaData(show: true, color: Colors.blueAccent.withOpacity(0.3)),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, lineBarData, index, lineChartBarData) {
                              return FlDotCirclePainter(
                                color: Colors.blueAccent, // Dot color
                                radius: 4, // Dot size
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Display steps data below the chart
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(dailySteps.length, (index) {
                      return Column(
                        children: [
                          Text(
                            '${dailySteps[dates[index]]}',  // Display steps count for the day
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            dates[index],  // Display date
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
