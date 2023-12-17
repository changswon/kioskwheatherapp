import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextPage extends StatelessWidget {
  final List<double> weeklyTemperatures;

  NextPage(this.weeklyTemperatures);

  @override
  Widget build(BuildContext context) {
    print('Weekly Temperatures: $weeklyTemperatures');
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Temperature for 7 days:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Use ListView.builder to display weekly temperatures
            Container(
              height: 700, // 적절한 높이 설정
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: weeklyTemperatures.length,
                itemBuilder: (context, index) {

                  DateTime date = DateTime.now().add(Duration(days: index));
                  String dayOfWeek = DateFormat.E().format(date);

                  return ListTile(
                    title: Text('$dayOfWeek'), // dayOfWeek를 사용하여 요일 표시
                    subtitle: Text('${weeklyTemperatures[index]}°C'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
