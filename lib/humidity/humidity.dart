import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'dart:math';

class HumidityPage extends StatelessWidget {
  final String humidity;
  final String temp;

  HumidityPage(this.humidity, this.temp);


  String calculateDewPoint() {
    double humidityValue = double.tryParse(humidity) ?? 0;
    double temperature = double.tryParse(temp) ?? 0;

    // Magnus 공식을 사용한 이슬점 계산
    const a = 17.27;
    const b = 237.7;
    double alpha = ((a * temperature) / (b + temperature)) + log(humidityValue / 100);
    double dewPoint = (b * alpha) / (a - alpha);

    return dewPoint.toStringAsFixed(1); // 이슬점을 소수점 1자리까지 출력
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0), // 상단 마진 추가
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Meteocons.mist,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '습도',
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.5), // 투명도 조절
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Text(
                    '습도 $humidity %',
                    style: GoogleFonts.lato(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter, // 아래 중앙 정렬
                        child: Text(
                          "현재 이슬점이 ${calculateDewPoint()}° \n입니다.",
                          style: GoogleFonts.lato(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}