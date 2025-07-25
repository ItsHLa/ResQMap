import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap(
      {super.key,
      
      this.polylines,  this.usePolylines = false, required this.useMarks, this.latLng});
 
  final bool useMarks;
  final bool usePolylines;
  final List<LatLng>? latLng;
  final List<Polyline<Object>>? polylines;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          initialZoom: 15,
          initialCenter: widget.latLng![0]),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.ResQMap.app',
        ),
        if(widget.useMarks) MarkerLayer(
          markers: widget.latLng!.map((latLng) => Marker(
              point: latLng,
              width: 40,
              height: 40,
              child: const Icon(
                  Icons.location_pin, color: Colors.red, size: 40),
            ),).toList(),
        ),
        if(widget.usePolylines) PolylineLayer(polylines: widget.polylines!)],
    );
  }
}
