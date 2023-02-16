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
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'dart:typed_data';
import 'dart:ui' as ui;

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> with WidgetsBindingObserver {
  bool sonando = true;
  bool caparrotSpawned = false;
  CameraPosition _location =
      CameraPosition(target: LatLng(39.769563, 3.024715), zoom: 17);
  late LatLng caparrotLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  bool exists = false;
  late String _mapStyle;

  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(39.769563, 3.024715), zoom: 17);
  late Position a;
  Set<Marker> markers = {};
  LocationSettings ls =
      LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0);
  late BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    addCustomIcon();
    rootBundle.loadString('assets/style/styleMap.txt').then((string) {
      _mapStyle = string;
    });
    Geolocator.getPositionStream(locationSettings: ls).listen((location) {
      inicial();
      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  void addCustomIcon() async {
    final icon = await getBitmapDescriptorFromAssetBytes("assets/axel.jpg", 70);
    setState(() {
      markerIcon = icon;
    });
    /*BitmapDescriptor.fromAssetImage("assets/axel.jpg").then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );*/
  }

  void inicial() async {
    var stat = await Permission.location.status;
    if (await Permission.location.serviceStatus.isDisabled ||
        stat.isDenied ||
        stat.isRestricted) {
      Map<Permission, PermissionStatus> status =
          await [Permission.location].request();
    }

    Position position = await _determinePosition();
    if (activo) cameraWork(position);

    Marker current = Marker(
        markerId: const MarkerId("current location"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: "Yo"),
        icon: markerIcon);
    markers.clear();
    markers.add(current);

    setState(() {});
  }

  bool activo = true;

  void cameraWork(Position position) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 20,
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Activa la localización");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Localización actual no permitida");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permisos de localización denegados indefinidamente");
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {});

    return position;
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
        title: const Text('Troba caparrots'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 143, 27, 1),
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
      body: GoogleMap(
          indoorViewEnabled: true,
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
            inicial();
            player.stop();
            googleMapController.setMapStyle(_mapStyle);
            sonarMusica(sonando);
            setState(() {});
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.control_camera_sharp),
        onPressed: () {
          if (activo)
            activo = false;
          else
            activo = true;
        },
      ),
    );
  }
}
