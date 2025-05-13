import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/widget/geolocator_service.dart';
import 'package:resq_map/core/widget/permission_handler.dart';
import 'package:resq_map/features/authentication/pages/login_view.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _askLocation();
    super.initState();
  }

  Future<void> _askLocation() async {
    var permission = await PermissionHandlerUtil.requestLocation();
    if (permission) {
      await GeolocatorService.checkPermission();
    } else {
      print(permission);
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
      body: const LoginView(),
    );
  }
}
