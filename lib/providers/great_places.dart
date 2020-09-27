import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:place_app/helpers/db_helper.dart';
import 'package:place_app/helpers/location_helpers.dart';
import 'package:place_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(File pickedImage, String pickedTitle,
      PlaceLocation pickedLocation) async {
    print('adding start');

    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
    print('adding end');
  }

  Future<void> fetchAndSetPlaces() async {
    print('fetch start');
    final dataList = await DBHelper.getData('user_places');
    dataList
        .map((e) => Place(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: PlaceLocation(
                  latitude: e['loc_lat'],
                  longitude: e['lng_lat'],
                  address: e['address']),
            ))
        .toList();
    print('fetch end');
    notifyListeners();
  }
}
