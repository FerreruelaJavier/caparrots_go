import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import '../providers/camera_provider.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> with WidgetsBindingObserver {
  void initState() {
    getCurrentLocation();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  bool offMusic = false;
  AudioPlayer player = AudioPlayer();
  static AudioCache musicCache = AudioCache();
  void sonarMusica(bool sonando) async {
    if (sonando) {
      sonando = false;
      loop();
      player.play(AssetSource('prueba2.mp3'));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    bool isBackground = false;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused)
      isBackground = true;
    else {
      isBackground = false;
    }

    if (isBackground) {
      player.stop();
    } else {
      sonando = true;
    }
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  bool sonando = true;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  GoogleMapController? mapController;
  bool caparrotSpawned = false;
  LocationData? currentLocation;
  CameraPosition _location =
      CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 17);
  late LatLng caparrotLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;

  LatLng getRandomLocation(LatLng point, int radius) {
    double x0 = point.latitude;
    double y0 = point.longitude;

    Random random = new Random();

    double radiusInDegrees = radius / 111000;

    double u = random.nextDouble();
    double v = random.nextDouble();
    double w = radiusInDegrees * sqrt(u);
    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t) * 1.75;

    double new_x = x / sin(y0);

    double foundLatitude = new_x + x0;
    double foundLongitude = y + y0;
    LatLng randomLatLng = new LatLng(foundLatitude, foundLongitude);

    return randomLatLng;
  }

  void changeCamera(LocationData newLoc) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 15,
          target: LatLng(
            newLoc.latitude!,
            newLoc.longitude!,
          ),
        ),
      ),
    );
  }

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        changeCamera(newLoc);

        setState(() {});
        if (!caparrotSpawned) {
          Random spawn = new Random();
          if (spawn.nextInt(100) <= 10) {
            print("Ha spawneado un caparrot");
            caparrotLocation =
                getRandomLocation(LatLng(39.769416, 3.024395), 60);
            caparrotSpawned = true;
          }
        }
      },
    );
  }

  bool musicOn = true;

  @override
  Widget build(BuildContext context) {
    final actual = Provider.of<CameraProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (musicOn) {
                  musicOn = false;
                  player.stop();
                } else {
                  musicOn = true;
                  sonando = true;
                  sonarMusica(sonando);
                }
              });
            },
            icon: musicOn ? Icon(Icons.volume_up) : Icon(Icons.volume_mute),
          )
        ],
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 245, 37, 37)),
            )
          : GoogleMap(
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 15),
              markers: {
                Marker(
                  markerId: MarkerId("CurrentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                caparrotSpawned == true
                    ? Marker(
                        markerId: MarkerId("caparrot"),
                        position: caparrotLocation)
                    : Marker(markerId: MarkerId("invisible")),
              },
              onCameraMove: ((position) {
                _location = position;
              }),
              onMapCreated: (mapCon) {
                _controller.complete(mapCon);
                player.stop();
                sonando = true;
                sonarMusica(sonando);

                setState(() {});
              },
            ),
    );
  }
}
