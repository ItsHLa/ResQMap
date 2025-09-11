import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'  ;
import 'package:resq_map/core/constants/constants.dart';


class MyMap extends StatefulWidget {
  const MyMap({
    super.key,
    this.polylines,
    this.usePolylines = false,
    required this.useMarks,
    this.latLng,
  

  });

  final bool useMarks;
  final bool usePolylines;
  final List<LatLng>? latLng;
  final List<List<LatLng>>? polylines;


  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  @override
  void initState() {
    _markers.add(
     Marker(
      
      markerId: MarkerId("Marker 0"),
      position: widget.latLng![0],),
    );
    if (widget.polylines != null) {
      _polylines =
          widget.polylines!
              .map((polyline) => Polyline(
                 width: 5,
                color: appThemeColor,
                polylineId: PolylineId("Polyline ${polyline.length}"),
                points: polyline))
              .toSet();
      _markers.add(
        Marker(
          position: widget.latLng!.last,
          markerId: MarkerId("Marker 1")
        ),
      );
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      polylines: _polylines,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: widget.latLng![0],
        zoom: 16,
      ),
    );
  }
}
