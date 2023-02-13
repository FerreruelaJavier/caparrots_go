import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CameraProvider extends ChangeNotifier {
  late CameraPosition _camera;

  set camera(CameraPosition cam) {
    this._camera = cam;
    notifyListeners();
  }

  CameraPosition get camera {
    return this._camera;
  }
}
