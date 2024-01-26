import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Model {
  Widget? getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        'svg/climacon-cloud_lightning.svg',
        color: Colors.white,
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition < 531) {
      return SvgPicture.asset(
        'svg/climacon-cloud_rain.svg',
        color: Colors.white,
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition <= 600) {
      return SvgPicture.asset(
        'svg/climacon-cloud_snow_alt.svg',
        color: Colors.white,
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition == 800) {
      return SvgPicture.asset(
        'svg/climacon-sun.svg',
        color: Colors.white,
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition == 801) {
      return SvgPicture.asset(
        'svg/cloud.svg',
        color: Colors.white,
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition <= 804) {
      return SvgPicture.asset(
        'svg/climacon-cloud_sun.svg',
        color: Colors.white,
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    }
  }

  Widget? getWeatherGif(int condition) {
    if (condition < 300) {
      return Image.asset(
        'assets/번개.gif',
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition < 531) {
      return Image.asset(
        'assets/비.gif',
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition <= 600) {
      return Image.asset(
        'assets/눈.gif',
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition == 800) {
      return Image.asset(
        'assets/맑음.gif',
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition == 801) {
      return Image.asset(
        'assets/구름.gif',
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    } else if (condition <= 804) {
      return Image.asset(
        'assets/흐림뒤맑음.gif',
        width: 50.0, // 아이콘의 가로 크기 조절
        height: 50.0, // 아이콘의 세로 크기 조절
      );
    }
  }

  Widget? getAirIcon(int index) {
    if (index == 1) {
      return Image.asset(
        'image/good.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        'image/fair.png',
        width: 37,
        height: 35,
      );
    } else if (index == 3) {
      return Image.asset(
        'image/moderate.png',
        width: 37,
        height: 35,
      );
    } else if (index == 4) {
      return Image.asset(
        'image/poor.png',
        width: 37,
        height: 35,
      );
    } else if (index == 5) {
      return Image.asset(
        'image/bad.png',
        width: 37,
        height: 35,
      );
    }
  }

  Widget? getAirCondition(int index) {
    if (index == 1) {
      return Text(
        '매우좋음',
        style: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
      );
    } else if (index == 2) {
      return Text('좋음',
        style: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
      );
    } else if (index == 3) {
      return Text(
        '보통',
        style: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
      );
    } else if (index == 4) {
      return Text(
        '나쁨',
        style: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
      );
    } else if (index == 5) {
      return Text(
        '매우나쁨',
        style: GoogleFonts.lato(
          fontSize: 12,
          color: Colors.white,
        ),
      );
    }
  }
}