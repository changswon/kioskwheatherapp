import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';


class VisibilityPage extends StatelessWidget {
  final String visibility;

  VisibilityPage(this.visibility);

  String getVisibilityMessage(double visibilityInKilometers) {
    if (visibilityInKilometers >= 10.0) {
      return '매우 좋습니다.';
    } else if (visibilityInKilometers >= 7.0) {
      return '보통 입니다.';
    } else if (visibilityInKilometers >= 5.0) {
      return '나쁩니다.';
    } else {
      return '매우 나쁩니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    double visibilityInMeters = double.tryParse(visibility) ?? 0.0;
    double visibilityInKilometers = visibilityInMeters / 1000.0;

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
                      Icons.remove_red_eye,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '가시거리',
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
                    '${visibilityInKilometers.round()} km',
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
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "가시거리가 \n${getVisibilityMessage(visibilityInKilometers)}",
                          style: GoogleFonts.lato(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
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