import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/meteocons_icons.dart';

class uvPage extends StatelessWidget {
  final String uvmax;
  uvPage(this.uvmax);



  String uvIndexStatus(double uvmax) {
    if (uvmax < 3) {
      return '낮음';
    } else if (uvmax >= 3 && uvmax < 6) {
      return '보통';
    } else if (uvmax >= 6 && uvmax < 8) {
      return '높음';
    } else if (uvmax >= 8 && uvmax < 11) {
      return '매우 높음';
    } else {
      return '위험';
    }
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
                      Meteocons.sun_inv,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '자외선',
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
                    "자외선 지수 $uvmax",
                    style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "현재 자외선은 \n${uvIndexStatus(double.parse(uvmax))} 상태 입니다. ",
                        style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start, // 가운데 정렬 추가
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