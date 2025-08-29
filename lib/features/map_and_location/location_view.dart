import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
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

  String userStatus = "Unknown";

  @override
  void initState() {
    // setState(() {
    //   userStatus = ;
    // });
    
    BlocProvider.of<SettingsCubit>(context).getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              leading: Icon(Icons.location_pin, size: 35, color: Colors.black),
              title: Text(
                "Current Location",
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.blueGrey,
              children: [
                Text(
                  widget.location!.fulladdress ?? "Unknown",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Icon(
              Icons.person_pin_circle_outlined,
              color: appThemeColor,
              size: 35,
            ),
            subtitle: Text("Allow Tracking Your Location"),
            title: Text(
              "Monitor Live Action",
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
          Padding(
            padding: const EdgeInsets.all(PaddingConstants.md),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (widget.status == "Unsafe" || widget.status == "Unknown")
                        ? appThemeColor
                        : Colors.green,
              ),
              onPressed:
                  (widget.status == "Unsafe" || widget.status == "Unknown")
                      ? () {
                        BlocProvider.of<MapCubit>(context).markSafe("Safe");
                      }
                      : () {
                        BlocProvider.of<MapCubit>(context).markSafe("Unsafe");
                      },
              child:
                  (widget.status == "Unsafe" || widget.status == "Unknown")
                      ? Column(
                        children: [
                          Text("You UnSafe"),
                          Text("Click to Mark Yourself Safe"),
                        ],
                      )
                      : Column(
                        children: [
                          Text("Marked Safe"),
                          Text("Click to Mark Yourself Unsafe"),
                        ],
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
