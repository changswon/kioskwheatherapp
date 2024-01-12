import 'package:flutter/material.dart';
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
          var temperature = dayData['main']['temp'].round();

          return Container(
            width: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${DateFormat('E', 'ko_KR').format(date)}\n ${getFormattedTime(date)}',
                  textAlign: TextAlign.center,// 수정된 부분
                  style: GoogleFonts.lato(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
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

  String getFormattedTime(DateTime dateTime) {
    var hour = dateTime.hour;
    var ampm = hour >= 12 ? '오후' : '오전';

    if (hour > 12) {
      hour -= 12;
    }

    var formattedTime = '$hour시';

    return '$ampm $formattedTime';
  }
}
