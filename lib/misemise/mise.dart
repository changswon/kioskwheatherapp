import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';

class MiseWidget extends StatelessWidget {
  final String dust1;
  final String dust2;
  final Widget airState;

  MiseWidget({
    required this.dust1,
    required this.dust2,
    required this.airState,
  });

  String getAirQualityTextpm10(double dustValue) { //미세먼지
    if (dustValue >= 0 && dustValue <= 25) {
      return '매우좋음';
    } else if (dustValue > 25 && dustValue <= 50) {
      return '좋음';
    } else if (dustValue > 50 && dustValue <= 75) {
      return '보통';
    } else if (dustValue > 75 && dustValue <= 100) {
      return '나쁨';
    } else if (dustValue > 100) {
      return '매우나쁨';
    } else {
      return '알 수 없음';
    }
  }
  String getAirQualityTextpm25(double dustValue) { //초미세먼지
    if (dustValue < 10) {
      return '매우좋음';
    } else if (dustValue < 25) {
      return '좋음';
    } else if (dustValue < 50) {
      return '보통';
    } else if (dustValue < 75) {
      return '나쁨';
    } else {
      return '매우나쁨';
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = Model();

    return Column(
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '미세먼지',
                style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 17.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$dust1㎍/㎥ | ${getAirQualityTextpm10(double.parse(dust1))}',
                    style: GoogleFonts.lato(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '초미세먼지',
                style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 17.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$dust2㎍/㎥ | ${getAirQualityTextpm25(double.parse(dust2))}',
                    style: GoogleFonts.lato(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '대기질지수',
                style: GoogleFonts.lato(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
                child: Align(
                  alignment: Alignment.center,
                  child: airState,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}