import 'dart:developer';

// import 'package:geolocator/geolocator.dart';
import 'package:irroba/core/models/user.dart';
import 'package:location/location.dart';


Future<GeoModel> getLagLong() async {
  // throw UnimplementedError();
  // LocationPermission permission = await Geolocator.checkPermission();
  //
  // if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //   // Solicita a permissão se ainda não foi concedida
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //     log('Location permissions are denied');
  //   }
  // }
  // final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  // final position = await geolocatorPlatform.getCurrentPosition();
  //
  // return GeoModel(lat: position.latitude.toString(), long: position.longitude.toString());

  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      log('Location disabled service');
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      log('Location permissions are denied');
    }
  }
  LocationData position =  await location.getLocation();
  return GeoModel(lat: position.latitude.toString(), long: position.longitude.toString());
}
