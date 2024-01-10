import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';

class WeeklyWeatherSlidePage extends StatelessWidget {
  final dynamic parseWeekData;
  const WeeklyWeatherSlidePage({required this.parseWeekData});

  @override
  Widget build(BuildContext context) {
    var model = Model();

    return Container(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: parseWeekData['list'].length,
        itemBuilder: (context, index) {

          var dayData = parseWeekData['list'][index];
          var date = DateTime.fromMillisecondsSinceEpoch(
              dayData['dt'] * 1000);
          var condition = dayData['weather'][0]['id'];
          var temperature = dayData['main']['temp'].toStringAsFixed(1);


          return Container(
            width: 75.0, //아이콘 갯수를 늘릴 수 있게 조정
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                model.getWeatherIcon(dayData['weather'][0]['id']) ?? Container(),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '$temperature \u2103',
                    style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

