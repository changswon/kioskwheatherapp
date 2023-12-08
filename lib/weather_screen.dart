import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData}); //생성자
  final dynamic parseWeatherData;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  late String cityName;
  late int temp;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData){
        double temp2 = weatherData['main']['temp'];
        temp = temp2.toInt();
        cityName = weatherData['name'];

        print(temp);
        print(cityName);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$cityName',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '$temp',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
