import 'package:flutter/material.dart';
import 'package:resq_map/core/services/geolocator_service.dart';
import 'package:resq_map/core/services/permission_handler.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/pages/alerts.dart';
import 'package:resq_map/features/earthquake/quake_news/pages/earthquakes_news_page.dart';
import 'package:resq_map/features/map_and_location/location_page.dart';
import 'package:resq_map/features/profile/pages/profile_page.dart';
import 'package:resq_map/features/safty/safty_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [
    const LocationPage(),
    const SaftyPage(),
    const EarthquakesNewsPage(),
    const AlertsPage(),
     ProfilePage(),
  ];

  int indx = 0;
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
      body: pages[indx],
      bottomNavigationBar: BottomNavigationBar(
        
        showUnselectedLabels: true,
        
        onTap: (value) {
          setState(() {
            indx = value;
          });
        },
        currentIndex: indx,
        items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.location_history),
             label: 'Location'),
          BottomNavigationBarItem(
            icon: Icon(Icons.safety_check_outlined),
             label: 'Safty'),
          BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined),
             label: 'News'),
          BottomNavigationBarItem(
            icon: Icon(Icons.nearby_error_outlined),
             label: 'Alerts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
