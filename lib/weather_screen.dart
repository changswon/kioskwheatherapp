import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart'; // 날짜 및 시간
import './model/model.dart';
import 'my_location.dart';
import './weeklyweather/weeklyweatherslide.dart';
import './windy/windy.dart';
import './misemise/mise.dart';
import './background/BackgroundImageChanger.dart';
import './windspeed/windspeed.dart';
import './humidity/humidity.dart';
import './pop/pop.dart';
import './visibility/visibility.dart';
import './sunrisesunset/sunrisesunset.dart';
import './uv/uv.dart';
import './feeltemp/feeltemp.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({
    this.parseUvData,
    this.parseWeatherData,
    this.parseAirPollution,
    this.parseWeekData,
    required this.administrativeArea,
    required this.subLocality});
  //생성자
  final dynamic parseUvData;
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;
  final dynamic parseWeekData;
  final String administrativeArea; // 추가: 도시 정보
  final String subLocality; // 추가: 구군 정보



  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String cityName;
  late int temp;
  late double windspeed;
  late double windgust;
  late int humidity;
  Widget? icon;
  late String des;
  Widget? airIcon;
  Widget? airState;
  late double dust1;
  late double dust2;
  var date = DateTime.now(); // 서버의 날짜를 가져오는 변수
  List<double> temperatures = [];
  late int condition;
  late double pop;
  late double rain;
  late int visibility;
  late int sunrise;
  late int sunset;
  late double uvmax;
  late double feeltemp;
  late int pressure;


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

  void refreshWeather(){
    updateData(
      widget.parseUvData,
      widget.parseWeatherData,
      widget.parseAirPollution,
      widget.parseWeekData,
      widget.administrativeArea,
      widget.subLocality,
    );
  }

  void navigateToWeeklyWeatherSlide() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeeklyWeatherSlidePage(parseWeekData: widget.parseWeekData),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    updateData( widget.parseUvData, widget.parseWeatherData, widget.parseAirPollution, widget.parseWeekData, widget.administrativeArea, widget.subLocality);
  }

  void updateData( dynamic uvData, dynamic weatherData, dynamic airData, dynamic weekData, String administrativeArea, String subLocality) {
    dynamic tempValue = weatherData['main']['temp'];
    double temp2 = tempValue is int ? tempValue.toDouble() : tempValue;
    condition = weatherData['weather'][0]['id'];
    feeltemp = weatherData['main']['feels_like'];
    int index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    dust1 = (airData['list'][0]['components']['pm10'] ?? 0).toDouble();
    dust2 = (airData['list'][0]['components']['pm2_5'] ?? 0).toDouble();
    windgust = (weatherData['wind']['gust'] ?? 0).toDouble();
    windspeed = (weatherData['wind']['speed'] ?? 0).toDouble();
    humidity = weatherData['main']['humidity'];
    pop = (weekData['list'][0]['pop'] ?? 0).toDouble();
    rain = (weekData['list'][0]['rain']['3h']?? 0).toDouble();
    visibility = weatherData['visibility'] ?? 0;
    sunrise = weatherData['sys']['sunrise'] ?? 0;
    sunset = weatherData['sys']['sunset'] ?? 0;
    temp = temp2.round(); //소수점 없애기
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    uvmax = (uvData['result']['uv_max']?? 0).toDouble();
    pressure = weatherData['main']['pressure']?? 0;

    setState(() {
      cityName = '$administrativeArea  $subLocality';
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
    } else {
      temperatures = []; // If weekData is null or in an unexpected format, initialize temperatures as an empty list
      print('Week Data is null or has an unexpected format: $weekData');
    }
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
              cityName = '${myLocation.administrativeArea} - ${myLocation.subLocality}';
            });
          },
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.update),
            color: Colors.white,
            onPressed: (){
              refreshWeather();
            },
            iconSize: 30.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 1900.0,
        child: Stack(
          children: [
            BackgroundImageChanger(), //background 시간 설정에 의한 컬러변경 위젯
            Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60.0,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${DateFormat('yyyy년 MM월 d일 EEEE', 'ko').format(date)}', //포맷 메서드를 이용한 날짜 반영
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
                        SizedBox(height: 20.0),
                        Column(
                          children: [
                            GestureDetector(
                              // onTap: () async{
                              //   MyLocation myLocation = MyLocation();
                              //   await myLocation.getMyCurrentLocation();
                              //   String tempAsString = myLocation.getMyCurrentLocation().toString();
                              //   navigateToWeeklyWeather();
                              // },

                              child: Column(
                                children: [
                                  // des 위젯
                                  Text('$des',
                                    style: GoogleFonts.lato(
                                      fontSize: 20.0,
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
                                  SizedBox(height: 10.0),  // des와 icon 사이의 간격

                                  // icon 위젯
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      icon!,
                                    ],
                                  ),
                                  SizedBox(height: 10.0),  // icon과 온도 사이의 간격

                                  // 온도 위젯
                                  Text(
                                    '$temp\u2103',
                                    style: GoogleFonts.lato(
                                      fontSize: 60.0,
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
                                  SizedBox(height: 10.0),  // 온도와 최고/최저 온도 사이의 간격

                                  // 최고/최저 온도 위젯
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '최고: ',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
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
                                      Text(
                                        '${getMaxTemperature()}\u2103',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.red,
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
                                      Text(
                                        ' | 최저: ',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
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
                                      Text(
                                        '${getMinTemperature()}\u2103',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.cyanAccent,
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
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    height: 170,
                                    //width: 400,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: WeeklyWeatherSlidePage(parseWeekData: widget.parseWeekData)
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 110,
                                    //width: 400,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                      child: MiseWidget(
                                        dust1: dust1.toString(),
                                        dust2: dust2.toString(),
                                        airState: airState!,
                                      ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 320,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: WindyMapView(),
                                    ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: WindSpeedPage(
                                            windspeed.toStringAsFixed(1), // AsFixed 소수점 1 자리로 넘김
                                            windgust.toStringAsFixed(1),
                                          ), // 왼쪽 Container에 표시할 내용
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0, // 원하는 간격 크기 설정
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: PopPage(
                                            pop.toString(),
                                            rain.toStringAsFixed(1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: HumidityPage(
                                            humidity.toString(),
                                            temp.toString(),
                                          ), // 왼쪽 Container에 표시할 내용
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0, // 원하는 간격 크기 설정
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: VisibilityPage(
                                            visibility.toString(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SunrisesunsetPage(
                                      sunrise.toInt(),
                                      sunset.toInt(),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 210,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: uvPage(
                                            uvmax.toStringAsFixed(1), // AsFixed 소수점 1 자리로 넘김
                                          ), // 왼쪽 Container에 표시할 내용
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0, // 원하는 간격 크기 설정
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 210,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: FeeltempPage(
                                            feeltemp.toStringAsFixed(1),
                                            pressure.toInt(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
