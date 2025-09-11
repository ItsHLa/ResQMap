import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/map_and_location/cubit/map_cubit.dart';
import 'package:resq_map/features/map_and_location/location_view.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Future<void> _refreshData() async {
    await BlocProvider.of<MapCubit>(context).getUserStatus();
  }

  bool status = false;

  @override
  void initState() {
    
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAppBar(
        title: "Location",
        actions: [Icon(Icons.location_history, size: 30)],
      ),
      body: BlocConsumer<MapCubit, MapState>(
        buildWhen: (previous, current) {
          return current is MapError ||
              current is MapUserInfo ||
              current is MapLoading;
        },
        listener: (context, state) {
          if (state is MarkSafeLoading) {
            AppActions.showLoadingDialog(context);
          }
          if (state is MarkSafeSuccess) {
            setState(() {
              status = !status;
            });
            Navigator.of(context).pop();
            AppActions.showSnackBar(
              title: "Status Marked Successfuly!",
              context: context,
            );
          }
          if (state is MarkSafeFailed) {
            Navigator.of(context).pop();
            AppActions.showSnackBar(title: state.msg, context: context);
          }
        },
        builder: (context, state) {
          print(state);

          if (state is MapLoading) {
            return LoadingAnimation();
          }
          if (state is MapUserInfo) {
         
            return LocationView(
              location: state.userStatus.location,
              status: state.userStatus.status,
            );
          }
          if (state is MapError) {
            return MyStateWidget(
              iconData: Icons.error_outline,
              title: "Failed to Load",
              refreshData: _refreshData,
            );
          }

          return MyStateWidget(
            iconData: Icons.error_outline,
            title: "Failed to Load",
            refreshData: _refreshData,
          );
        },
      ),
    );
  }
}
