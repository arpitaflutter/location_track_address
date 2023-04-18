import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location_track_address/screens/location/controller/locationController.dart';
import 'package:permission_handler/permission_handler.dart';

class locationScreen extends StatefulWidget {
  const locationScreen({Key? key}) : super(key: key);

  @override
  State<locationScreen> createState() => _locationScreenState();
}

class _locationScreenState extends State<locationScreen> {
  LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Location tracking"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var status = await Permission.location.status;

                  if (status.isDenied) {
                    Permission.location.request();
                  }
                },
                child: Text("Location Permission",
                    style: TextStyle(fontSize: 17, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  locationController.lan.value = position.longitude;
                  locationController.lat.value = position.latitude;
                },
                child: Text("Location", style: TextStyle(fontSize: 17)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => Text("Latitude:- ${locationController.lat.value}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Text("Longitude:- ${locationController.lan.value}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  List<Placemark> placeMarkList =
                      await placemarkFromCoordinates(
                          locationController.lat.value,
                          locationController.lan.value);

                  locationController.PlaceList.value = placeMarkList;
                },
                child: Text("Address"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800),
              ),
              Obx(
                () => Text(
                    locationController.PlaceList.isEmpty
                        ? "null"
                        : "${locationController.PlaceList[0]}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
