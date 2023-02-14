import 'dart:async';
import 'dart:math';

import 'package:caparrots_initial/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../providers/camera_provider.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> with WidgetsBindingObserver {
  bool sonando = true;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  GoogleMapController? mapController;
  bool caparrotSpawned = false;
  CameraPosition _location =
      CameraPosition(target: LatLng(39.769563, 3.024715), zoom: 17);
  late LatLng caparrotLocation;
  late Position currentLocation = Position(
      longitude: _location.target.longitude,
      latitude: _location.target.latitude,
      timestamp: DateTime(2023),
      accuracy: 100,
      altitude: 15,
      heading: 12,
      speed: 2,
      speedAccuracy: 2);
  Set<Marker> markers = {};

  @override
  void initState() {
    localizacionPrueba();
    /*getCurrentLocation();
    changeCamera(currentLocation);
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(currentLocation.latitude, currentLocation.longitude)));
    setState(() {
      if (!caparrotSpawned) {
        Random spawn = new Random();
        if (spawn.nextInt(100) <= 10) {
          print("Ha spawneado un caparrot");
          caparrotLocation = getRandomLocation(LatLng(39.769416, 3.024395), 60);
          caparrotSpawned = true;
        }
      }
    });
    _liveLocation();*/
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Future<Position> getUserCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Activa la localización");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Localización actual no permitida");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Permisos de localización denegados indefinidamente');
    }
    return await Geolocator.getCurrentPosition();
  }

  void localizacionPrueba() async {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());

      CameraPosition cameraPosition = new CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      markers.clear();
      markers.add(Marker(
          markerId: MarkerId("my current position"),
          position: LatLng(value.latitude, value.longitude)));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Set<Marker> getCaparrotList() {
    Set<Marker> caparrots = {};
    for (int i = 0; i < 11; i++) {
      caparrotLocation = getRandomLocation(LatLng(39.769416, 3.024395), 80);
      caparrots.add(Marker(
          markerId: MarkerId("caparrot + ${i + 1}"),
          position: caparrotLocation));
    }
    return caparrots;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  late AppLifecycleState appLifecycleState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState = state;
    setState(() {});
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      player.pause();
    }

    if (state == AppLifecycleState.resumed) {
      player.resume();
    }
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  void getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Activa la localización");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Localización actual no permitida");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Permisos de localización denegados indefinidamente');
    }
    Position position = await Geolocator.getCurrentPosition();
    currentLocation = position;

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? positionU) {
      print(positionU == null
          ? 'Unknown'
          : '${positionU.latitude.toString()}, ${positionU.longitude.toString()}');
      currentLocation = Position(
          longitude: positionU!.longitude!,
          latitude: positionU!.latitude!,
          timestamp: DateTime(2023),
          accuracy: 100,
          altitude: 14,
          heading: 2,
          speed: 2,
          speedAccuracy: 2);
    });
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {});
    });
  }

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

  void changeCamera(Position newLoc) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 15,
          target: LatLng(
            newLoc.latitude,
            newLoc.longitude,
          ),
        ),
      ),
    );
  }

  bool musicOn = true;
  bool offMusic = false;
  AudioPlayer player = AudioPlayer();
  static AudioCache musicCache = AudioCache();
  void sonarMusica(bool sonando) async {
    if (sonando) {
      sonando = false;
      loop();
      player.play(AssetSource('ina.mp3'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final actual = Provider.of<CameraProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (musicOn) {
                  musicOn = false;
                  player.pause();
                } else {
                  musicOn = true;

                  player.resume();
                }
              });
            },
            icon: musicOn
                ? const Icon(Icons.volume_up)
                : const Icon(Icons.volume_mute),
          )
        ],
      ),
      drawer: SideMenu(),
      body: currentLocation == null || currentLocation.latitude == null
          ? const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 245, 37, 37)),
            )
          : GoogleMap(
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 15),
              markers: Set<Marker>.of(markers),
              /*{
                markers.first,
                caparrotSpawned == true
                    ? Marker(
                        markerId: const MarkerId("caparrot"),
                        position: caparrotLocation)
                    : const Marker(markerId: MarkerId("invisible")),
              },*/
              onCameraMove: ((position) {
                _location = position;
              }),
              onMapCreated: (mapCon) {
                _controller.complete(mapCon);
                player.stop();
                sonarMusica(sonando);
                setState(() {});
              },
            ),
    );
  }
}
