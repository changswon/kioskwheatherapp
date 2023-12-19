import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';

class WeeklyWeatherPage extends StatelessWidget {
  final dynamic parseWeekData;
  WeeklyWeatherPage({required this.parseWeekData});

  @override
  Widget build(BuildContext context) {
    var model = Model(); // Model 클래스의 인스턴스 생성

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder:
            (context, innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('주간날씨',
                  style: GoogleFonts.lato(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                background: Image.asset('./image/background4.jpeg',
                  fit:BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('./image/background3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    var dayData = parseWeekData['list'][index];
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        dayData['dt'] * 1000);
                    var condition = dayData['weather'][0]['id'];
                    var temperature = dayData['main']['temp'];
                    return Card(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${DateFormat('MMM d').format(date)} ${DateFormat('EEEE').format(date)} ${DateFormat('jm').format(date)}',
                              style: GoogleFonts.lato(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.getWeatherIcon(dayData['weather'][0]['id']) ?? Container(),
                            Text(
                              '$temperature \u2103',
                              style: GoogleFonts.lato(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: parseWeekData['list'].length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}