import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class WindSpeedPage extends StatelessWidget {
  final String windspeed;
  final String windgust;

  WindSpeedPage(this.windspeed, this.windgust);


  String getWindSpeedDescription(double speed) {
    if (speed < 1.0) {
      return '미풍';
    } else if (speed < 5.0) {
      return '약풍';
    } else if (speed < 10.0) {
      return '중풍';
    } else if (speed < 20.0) {
      return '강풍';
    } else {
      return '돌풍';
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
                      Icons.air,
                      size: 20.0,
                      color: Colors.white.withOpacity(0.5), // 투명도 조절
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '바람',
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
                    '바람 $windspeed m/s',
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
                          '${getWindSpeedDescription(double.parse(windspeed))} $windgust m/s',
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