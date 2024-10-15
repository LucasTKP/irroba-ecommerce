import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:irroba/core/models/user.dart';


Future<GeoModel> getLagLong() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    // Solicita a permissão se ainda não foi concedida
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      log('Location permissions are denied');
    }
  }
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  final position = await geolocatorPlatform.getCurrentPosition();

  return GeoModel(lat: position.latitude.toString(), long: position.longitude.toString());
}
