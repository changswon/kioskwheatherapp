import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';


class Network {
  final String url; //날씨 url
  final String url2; //미세먼지 url
  final String url3; //날씨 url 5 week
  final String url4;

  Network(this.url, this.url2, this.url3, this.url4);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
  Future<dynamic> getWeekData() async {
    http.Response response = await http.get(Uri.parse(url3));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
  Future<dynamic> getUvData() async {
    var headers = {'x-access-token': apiuvkey};
    http.Response response = await http.get(Uri.parse(url4),headers: headers);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
