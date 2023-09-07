import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  bool _locationPermissionGranted = false;
  LatLng _center = const LatLng(37, 127);

  // 지도 초기화
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LatLng> getCurrentLocation() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    LatLng location = LatLng(position.latitude, position.longitude);
    setState(() {
      _center = location;
      _locationPermissionGranted = true;
    });
    return location;
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    // final status = await Permission.location.status;
    var status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      await getCurrentLocation();
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // 사용자가 권한을 거부하거나 영구적으로 거부한 경우 설정으로 이동하도록 안내
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Camera Map'),
          backgroundColor: Colors.green[700],
        ),
        body: _locationPermissionGranted
            ? GoogleMap(
                key: UniqueKey(),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true, //  내 위치 표시
                myLocationButtonEnabled: false, // 현재 위치 보여주는 버튼 표시
                markers: {
                  const Marker(
                    markerId: MarkerId('pyeongtaek'),
                    position: LatLng(37, 127.02),
                  )
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              )
            : const Center(
                child: Text('위치 권한을 허용해주세요.'),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _requestLocationPermission(),
          child: const Icon(Icons.gps_fixed),
        ),
      ),
    );
  }
}
