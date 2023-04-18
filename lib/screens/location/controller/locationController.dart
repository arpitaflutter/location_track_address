import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController
{
  RxDouble lan = 0.0.obs;
  RxDouble lat = 0.0.obs;

  RxList<Placemark> PlaceList = <Placemark>[].obs;
}