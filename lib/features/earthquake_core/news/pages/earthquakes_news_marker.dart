import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:resq_map/core/widget/my_map_widget.dart';

class EarthquakesNewsMarker extends StatefulWidget {
  const EarthquakesNewsMarker({super.key, required this.lat, required this.lon});
  final double lat;
  final double lon;

  @override
  State<EarthquakesNewsMarker> createState() => _EarthquakesNewsMarkerState();
}

class _EarthquakesNewsMarkerState extends State<EarthquakesNewsMarker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyMap(
            useMarks: true,
            latLng: [LatLng(widget.lat, widget.lon)],
            ),
    );
  }
}