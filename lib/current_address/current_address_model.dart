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
  initTast(context) {
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

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}
