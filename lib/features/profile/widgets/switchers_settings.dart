import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/core/services/geolocator_service.dart';
import 'package:resq_map/features/home/cubit/cubit/settings_cubit.dart';
import 'package:resq_map/features/map_and_location/cubit/map_cubit.dart';

class SwitchersSettings extends StatefulWidget {
  const SwitchersSettings({super.key});

  @override
  State<SwitchersSettings> createState() => _SwitchersSettingsState();
}

class _SwitchersSettingsState extends State<SwitchersSettings> {
  List<String> switches = ["Dark Mode", "Live Location Tracking"];

  List<IconData> switchersIcons = [
    Icons.dark_mode,
    Icons.person_pin_circle_outlined,
  ];

  List<bool> switchersValues = [false, false];

  List? onTapswitchers;

  @override
  void initState() {
    onTapswitchers = [
      (value) {
        BlocProvider.of<SettingsCubit>(context).darkModeOn(darkOn: value);
      },
      (value) {
        if (value) {
          GeolocatorService.startTracking(
            context: context,
            onData: (Position? position) {
              if (position != null) {
                print(position);
                BlocProvider.of<MapCubit>(context).trackLocation(position : position);
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
    ];
    BlocProvider.of<SettingsCubit>(context).getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is TrackingOn) {
          AppActions.showSnackBar(
            title: "Starting Tracking Your Location!",
            context: context,
          );
        }
        if (state is TrackingOff) {
          AppActions.showSnackBar(
            title: "Tracking Turned Off!",
            context: context,
          );
        }
        if (state is AppSettings) {
          setState(() {
            switchersValues[0] = state.darkMode;
            switchersValues[1] = state.tracking;
          });
        }
      
      },
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: switches.length,
        itemBuilder:
            (context, index) => ListTile(
              trailing: Switch(
                value: switchersValues[index],
                onChanged: (value) {
                  setState(() {
                    switchersValues[index] = value;
                  });

                  if (onTapswitchers != null) {
                    onTapswitchers![index](switchersValues[index]);
                  }
                },
              ),
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(switchersIcons[index], color: Colors.red.shade500),
              ),

              title: Text(switches[index]),
            ),
      ),
    );
  }
}
