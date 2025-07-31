import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:resq_map/core/constants/constants.dart';

class MyMap extends StatefulWidget {
  const MyMap({
    super.key,
    this.polylines,
    this.usePolylines = false,
    required this.useMarks,
    this.latLng,
    this.showButtons = true,
    this.flags = InteractiveFlag.all
  });

  final bool useMarks;
  final bool usePolylines;
  final List<LatLng>? latLng;
  final List<List<LatLng>>? polylines;
  final bool showButtons;
  final int flags;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final MapController _mapController = MapController();
  double _currentZoom = 16;

  void _zoomIn() {
    final currentCenter = _mapController.camera.center;
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(3, 20); // Limit zoom between 3-20
    });
    _mapController.move(currentCenter, _currentZoom);
  }

  void _zoomOut() {
    final currentCenter = _mapController.camera.center;
    print(currentCenter);
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(3, 20); // Limit zoom between 3-20
    });
    print(_currentZoom);
    _mapController.move(currentCenter, _currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            interactionOptions: InteractionOptions(
              flags: widget.flags
            ),
            initialZoom: _currentZoom,
            initialCenter: widget.latLng![0],
            onPositionChanged: (position, hasGesture) {
              _currentZoom = position.zoom;
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.ResQMap.app',
            ),
            if (widget.useMarks)
              MarkerLayer(
                markers:
                    widget.latLng!
                        .map(
                          (latLng) => Marker(
                            point: latLng,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        )
                        .toList(),
              ),
            if (widget.usePolylines)
              PolylineLayer(
                polylines:
                    widget.polylines!
                        .map(
                          (path) => Polyline(
                            points: path,
                            strokeWidth: 4.0,
                            color: appThemeColor,
                          ),
                        )
                        .toList(),
              ),
          ],
        ),
       if(widget.showButtons)
               Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: 'zoomIn',
                backgroundColor: softWhite,
                foregroundColor: appThemeColor,
                mini: true,
                onPressed: _zoomIn,
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'zoomOut',
                backgroundColor: softWhite,
                foregroundColor: appThemeColor,
                mini: true,
                onPressed: () => _zoomOut,
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      
      ],
    );
  }
}
