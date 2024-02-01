import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class PopPage extends StatelessWidget {
  final String pop;
  final String rain;
  PopPage(this.pop, this.rain);

  String poppers(String pop) {
    double popValue = double.parse(pop); // 'pop' 값을 double로 변환
    double popPercentage = popValue * 100; // 백분율로 변환
    return popPercentage.toStringAsFixed(0); // 백분율 문자열로 반환
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
                      Icons.water_drop,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '강수',
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
                    "강수확률 ${poppers(pop)}%",
                    style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Divider( // 수평 선 추가
                    color: Colors.white.withOpacity(0.5),
                    thickness: 1.0, // 선의 두께 설정
                    height: 50.0, // 선의 높이 설정 (세로 간격)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter, // 아래 중앙 정렬
                        child: Text(
                          "강수량 $rain mm ",
                          style: GoogleFonts.lato(
                            fontSize: 20.0,
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