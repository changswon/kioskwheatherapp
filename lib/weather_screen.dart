import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart'; // 날짜 및 시간
import './model/model.dart';
import './calendar/calendar.dart';
import 'my_location.dart';
import './weeklyweather/weeklyweather.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution, this.parseWeekData, required this.city, required this.subLocality}); //생성자
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;
  final dynamic parseWeekData;
  final String city; // 추가: 도시 정보
  final String subLocality; // 추가: 구군 정보



  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String cityName;
  late int temp;
  Widget? icon;
  late String des;
  Widget? airIcon;
  Widget? airState;
  late double dust1;
  late double dust2;
  var date = DateTime.now(); // 서버의 날짜를 가져오는 변수
  List<double> temperatures = [];
  late int condition;

  double getMaxTemperature() {
    if (temperatures.isNotEmpty) {
      return temperatures.reduce((max, temp) => temp > max ? temp : max).toDouble();
    }
    return 0.0; // 온도 목록이 비어 있을 때 기본값
  }

  double getMinTemperature() {
    if (temperatures.isNotEmpty) {
      return temperatures.reduce((min, temp) => temp < min ? temp : min).toDouble();
    }
    return 0.0; // 온도 목록이 비어 있을 때 기본값
  }

  Widget? outerwearIcon;
  Widget? topsIcon;
  Widget? bottomsIcon;
  Widget? shoesIcon;
  Widget? accessoriesIcon;

  final int outerwearThreshold = 5;
  final int topsThreshold = 5;
  final int bottomsThreshold = 5;
  final int shoesThreshold = 5;
  final int accessoriesThreshold = 5;

  void updateClothingIcons(int temperature) {
    if (temperature <= outerwearThreshold) {
      outerwearIcon = Icon(Icons.ac_unit); // 실제 외투 아이콘으로 교체
    } else if (temperature <= topsThreshold) {
      topsIcon = Icon(Icons.wb_cloudy); // 실제 상의 아이콘으로 교체
    } else if (temperature <= bottomsThreshold) {
      bottomsIcon = Icon(Icons.wb_sunny); // 실제 하의 아이콘으로 교체
    } else if (temperature <= shoesThreshold) {
      shoesIcon = Icon(Icons.directions_run); // 실제 신발 아이콘으로 교체
    } else {
      accessoriesIcon = Icon(Icons.star); // 실제 악세사리 아이콘으로 교체
    }
  }

  void navigateToWeeklyWeather() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeeklyWeatherPage(parseWeekData: widget.parseWeekData),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution, widget.parseWeekData, widget.city, widget.subLocality);
    updateClothingIcons(temp);
  }

  void updateData(dynamic weatherData, dynamic airData, dynamic weekData, String city, String subLocality) {
    dynamic tempValue = weatherData['main']['temp'];
    double temp2 = tempValue is int ? tempValue.toDouble() : tempValue;
    condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
    temp = temp2.round();
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    setState(() {
      cityName = '$city - $subLocality';
    });

    int conditionValue = weatherData['weather'][0]['id'];
    setState(() {
      condition = conditionValue;
    });


    if (weekData != null && weekData is Map && weekData['list'] != null && weekData['list'] is List) {
      temperatures = (weekData['list'] as List<dynamic>)
          .map<int>((item) => (item['main']['temp'] as num).round())
          .map<double>((temp) => temp.toDouble())
          .toList();

      // Print temperatures to the console
      print('온도: $temperatures');
    } else {
      temperatures = []; // If weekData is null or in an unexpected format, initialize temperatures as an empty list
      print('Week Data is null or has an unexpected format: $weekData');
    }

    //print('Week Data: $weekData');
    //print(temperatures);
    //print(temp);
    //print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now); // AM 기준
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          color: Colors.white,
          onPressed: () async {
            MyLocation myLocation = MyLocation();
            await myLocation.getMyCurrentLocation();
            setState(() {
              cityName = '${myLocation.city} - ${myLocation.subLocality}';
            });
          },
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarWeather()),
            );
            },
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background2.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),

                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                  (Duration(minutes: 1)),
                                  builder:(context){
                                    //print('${getSystemTime()}',); //로그에 시간 현재시간 출력
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date), //포맷 메서드를 이용한 날짜 반영
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('외투'),
                                SizedBox(height: 10.0),
                                outerwearIcon ?? SizedBox(),
                              ],
                            ),
                            Column(
                              children: [
                                Text('상의'),
                                SizedBox(height: 10.0),
                                topsIcon ?? SizedBox(),
                              ],
                            ),
                            Column(
                              children: [
                                Text('하의'),
                                SizedBox(height: 10.0),
                                bottomsIcon ?? SizedBox(),
                              ],
                            ),
                            Column(
                              children: [
                                Text('신발'),
                                SizedBox(height: 10.0),
                                shoesIcon ?? SizedBox(),
                              ],
                            ),
                            Column(
                              children: [
                                Text('악세사리'),
                                SizedBox(height: 10.0),
                                accessoriesIcon ?? SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async{
                                MyLocation myLocation = MyLocation();
                                await myLocation.getMyCurrentLocation();
                                String tempAsString = myLocation.getMyCurrentLocation().toString();
                                navigateToWeeklyWeather();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // 현재 온도와 최고/최저 온도를 맞추기 위해 수정
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic, // textBaseline 설정// 현재 온도와 최고/최저 온도를 맞추기 위해 수정
                                    children: [
                                      Text(
                                        '$temp\u2103',
                                        style: GoogleFonts.lato(
                                          fontSize: 85.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black54,
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        ' 최고: ',
                                        style: GoogleFonts.lato(
                                          fontSize: 16.0, // 작게 설정
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${getMaxTemperature()}\u2103',
                                        style: GoogleFonts.lato(
                                          fontSize: 16.0, // 작게 설정
                                          color: Colors.red, // 빨강색으로 설정
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' / 최저: ',
                                        style: GoogleFonts.lato(
                                          fontSize: 16.0, // 작게 설정
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${getMinTemperature()}\u2103',
                                        style: GoogleFonts.lato(
                                          fontSize: 16.0, // 작게 설정
                                          color: Colors.blue, // 파랑색으로 설정
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                icon!,
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('$des',
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row( // 하단 부분
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('$dust1',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  color: Colors.white,

                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('"㎍/m3"',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('$dust2',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('"㎍/m3"',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              airIcon!,
                              SizedBox(
                                height: 10.0,
                              ),
                              airState!,
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}