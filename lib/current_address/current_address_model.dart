import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';

class CurrentAddressModel with ChangeNotifier {
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address address;
  Timer timer;
  int startTime = 5;
  initTast(context) {
    fiveSecond();
    time();
  }

  fiveSecond() {
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _streamSubscription = Geolocator()
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print(position);
      final coordinates = Coordinates(position.latitude, position.longitude);
      convertCoordinatesToAddress(coordinates).then((value) => address = value);
      // rr();
      print(address);
      print(address?.addressLine);
      notifyListeners();
    });
  }

  time() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(oneSec, (Timer timer) {
      if (startTime < 1) {
        print(startTime);
      } else {
        startTime = startTime - 1;
        if (startTime == 0) {
          fiveSecond();
          startTime = 5;
          notifyListeners();
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}
