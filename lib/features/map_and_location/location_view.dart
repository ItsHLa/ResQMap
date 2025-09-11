import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/core_widgets/map_in_place_item.dart';
import 'package:resq_map/core/services/geolocator_service.dart';
import 'package:resq_map/features/home/cubit/cubit/settings_cubit.dart';
import 'package:resq_map/features/map_and_location/cubit/map_cubit.dart';
import 'package:resq_map/features/map_and_location/model/location_model.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key, required this.status, this.location});
  final String status;
  final Location? location;

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  bool trackingOn = false;

  bool userStatus = false;

  @override
  void initState() {
    userStatus = (widget.status == "Safe" || widget.status == "Rescued");

    BlocProvider.of<SettingsCubit>(context).getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = Colors.white.withOpacity(0.95);
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is AppSettings) {
          setState(() {
            trackingOn = state.tracking;
          });
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MapInPlaceItem(
              lat: widget.location!.lat,
              lon: widget.location!.lon,
              opacity: 0.3,
              leading: Icon(Icons.location_pin, size: 35, color: appThemeColor),
              title: Text(
                "Current Location",
                style: TextStyle(color: textColor),
              ),
              color: Colors.transparent,
              children: [
                Text(
                  widget.location!.fulladdress ?? "Unknown",
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
              child: Icon(
                Icons.person_pin_circle_outlined,
                color: appThemeColor.withOpacity(0.95),
                size: 30,
              ),
            ),
            subtitle: Text("Share your location for emergency tracking"),
            title: Text(
              "Live Location Tracking",
              style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w400),
            ),
            trailing: Switch(
              value: trackingOn,
              onChanged: (value) {
                setState(() {
                  trackingOn = value;
                });
                if (value) {
                  GeolocatorService.startTracking(
                    context: context,
                    onData: (Position? position) {
                      if (position != null) {
                        print(position);
                        BlocProvider.of<MapCubit>(
                          context,
                        ).trackLocation(position: position);
                      }
                    },
                  );
                } else {
                  GeolocatorService.stopTracking();
                }
                BlocProvider.of<SettingsCubit>(
                  context,
                ).trackingLocationOn(trackingOn: value);
              },
            ),
          ),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
              child: Icon(
                Icons.health_and_safety_rounded,
                color: userStatus ?Colors.green : appThemeColor,
                size: 30,
              ),
            ),
            title: Text(
              "I'm ${userStatus ? "Safe" : "NOT Safe"}",
              style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w400),
            ),
            subtitle: Text("Let others know your status"),
            trailing: Switch(
              activeThumbColor: userStatus ?Colors.green : appThemeColor,
              activeTrackColor: userStatus ?Colors.green.withOpacity(0.3) : appThemeColor.withOpacity(0.3),
              value: userStatus,
              onChanged: (value) {
                setState(() {
                  userStatus = value;
                });
                BlocProvider.of<MapCubit>(
                  context,
                ).markSafe(userStatus ? "Safe" : "Unsafe");
              },
            ),
          ),
        ],
      ),
    );
  }
}
