import 'dart:async';
import 'dart:typed_data';

import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class RunningMap extends StatefulWidget {
  final RunningData runningData;
  final CameraPosition initialPosition;
  const RunningMap({
    required this.runningData,
    required this.initialPosition,
    Key? key
  }) : super(key: key);
  @override
  State<RunningMap> createState() => _RunningMapState();
}

class _RunningMapState extends State<RunningMap> {
  late Uint8List? img;
  late Timer _timer;
  // 지도에 위치 그리기
  GoogleMapController? mapController;
  late CameraPosition currentPosition;
// 캡처를 위한 키
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPosition = widget.initialPosition;
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      getCurrentLocation();
    });
  }
  @override
  void dispose() async {
    mapController!.dispose();
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
        initialCameraPosition: currentPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: onMapCreated,
        polylines: {
          Polyline(
            polylineId: PolylineId('temp'),
            points: widget.runningData.location,
            color: MAIN_COLOR,
            // jointType: JointType.round,
          ),
        }
      ),
    ]
    );
  }

  void getCurrentLocation() async {
    // 위치 정보 권한 요청
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return ;
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
      if (checkedPermission == LocationPermission.denied) {
        return ;
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return ;
    }
    // 위치 권한 완료
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      var runningData = Provider.of<RunningData>(context, listen: false);
      LatLngBounds bound = LatLngBounds(southwest: LatLng(runningData.minLat, runningData.minLng), northeast: LatLng(runningData.maxLat, runningData.maxLng));
      // mapController.animateCamera();
      currentPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 17);
      if (runningData.curValue != currentPosition.target) {
        runningData.setCurrentPosition(currentPosition);
        runningData.addLocation(currentPosition.target);
        runningData.setLat(currentPosition.target.latitude);
        runningData.setLng(currentPosition.target.longitude);
        mapController!.animateCamera(
            CameraUpdate.newLatLngBounds(bound, 17)
        );

      }
    });
    return ;
  }
  // 맵컨트롤러 받기 => 지도 카메라 위치 조정시 필요
  onMapCreated(GoogleMapController controller) {
    mapController = controller;
    Provider.of<RunningData>(context, listen: false).setMapController(mapController!);
  }
  // 사용자에게 위치 동의 구하기 단계별로
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요';
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요';
    }
    return '위치 권한이 허가 되었습니다.';
  }
}




