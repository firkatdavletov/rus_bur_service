import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsWidget extends StatefulWidget {
  const GpsWidget({Key? key}) : super(key: key);

  @override
  _GpsWidgetState createState() => _GpsWidgetState();
}

class _GpsWidgetState extends State<GpsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: determinePosition(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Position position = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ш: ${position.latitude} Д: ${position.longitude}'),
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.gps_not_fixed)
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${snapshot.error}'),
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.gps_not_fixed)
              )
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Получение геопозиции...'),
              Icon(Icons.blur_circular)
            ],
          );
        }
      },
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
