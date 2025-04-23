import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/widget/geolocator_service.dart';
import 'package:resq_map/core/widget/permission_handler.dart';
import 'package:resq_map/maps/maps.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _askLocation();
  }

  Future<void> _askLocation() async {
    if (await PermissionHandlerUtil.requestLocation()) {
      await GeolocatorService.checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Demo Home Page',
          style: TextStyle(color: softWhite),
        ),
      ),
      body:  Container(),
    );
  }
}
