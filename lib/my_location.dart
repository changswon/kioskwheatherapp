import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MyLocation{
  late double latitude2;
  late double longitude2;
  late String city;
  late String subLocality;

  MyLocation() {
    // 변수 초기화
    city = "";
    subLocality = "";


  }

  Future<void> getMyCurrentLocation()async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      city = "";
      subLocality = "";

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude2, longitude2);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        city = placemark.locality ?? "";
        subLocality = placemark.subLocality ?? "";
        print('City: $city');
        print('Sub Locality: $subLocality');
      } else {
        print("Placemarks를 찾을 수 없습니다");
      }

    } catch (e) {
      print('Error getting location: $e');
    }
  }
}