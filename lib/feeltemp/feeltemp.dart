import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/meteocons_icons.dart';


class FeeltempPage extends StatelessWidget {
  final String feeltemp;
  final int pressure;

  FeeltempPage(this.feeltemp, this.pressure);

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
                      Meteocons.temperature,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '체감온도',
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
                    "체감온도는 $feeltemp° \n입니다.",
                    style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "현재 기압은 \n $pressure hPa 입니다.",
                          style: GoogleFonts.lato(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),// 아래 중앙 정렬
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