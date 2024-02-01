import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SunrisesunsetPage extends StatelessWidget {

  final int sunrise;
  final int sunset;

  SunrisesunsetPage(this.sunrise, this.sunset);

  @override
  Widget build(BuildContext context) {

    DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);


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
                      Meteocons.sun,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '일출',
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.5), // 투명도 조절
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.6), // 디바이스 너비의 4% 간격
                    Icon(
                      Meteocons.sunrise,
                      size: 25.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '일몰',
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'image/일출일몰.png', // 이미지 파일 경로
                        height: 160.0,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                '금일 일출 시간:    ${sunriseDateTime.hour}:${sunriseDateTime.minute}',
                style: GoogleFonts.lato(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // 추가 텍스트
              Text(
                '금일 일몰 시간: ${sunsetDateTime.hour}:${sunsetDateTime.minute}',
                style: GoogleFonts.lato(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}