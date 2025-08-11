import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:resq_map/core/core_widgets/my_map_widget.dart';

class AlertRoutePage extends StatefulWidget {
  const AlertRoutePage({
    super.key,
    this.path,
    required this.start,
    required this.end,
  });

  final LatLng start;
  final LatLng end;

  final List<LatLng>? path;

  @override
  State<AlertRoutePage> createState() => _AlertRoutePageState();
}

class _AlertRoutePageState extends State<AlertRoutePage> {
  @override
  Widget build(BuildContext context) {
    return MyMap(
      usePolylines: true,polylines: [widget.path!],
      useMarks: true, latLng: [widget.start, widget.end]);
  }
}
