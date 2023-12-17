import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';

class WeeklyWeatherPage extends StatelessWidget {
  final dynamic parseWeekData;
  WeeklyWeatherPage({required this.parseWeekData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('주간 날씨'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: parseWeekData['list'].length,
          itemBuilder: (context, index) {
            var dayData = parseWeekData['list'][index];
            var date = DateTime.fromMillisecondsSinceEpoch(dayData['dt'] * 1000);
            var condition = dayData['weather'][0]['id'];
            var temperature = dayData['main']['temp'];
            var model = Model(); // Create an instance of the Model class

            return Card(
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  DateFormat('EEEE').format(date),
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.getWeatherIcon(condition) ?? Container(), // Weather icon
                    Text(
                      'Condition: $condition',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Temperature: $temperature °C',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
