import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/core/constants/constants.dart';


import 'package:resq_map/features/earthquake/quacke_alerts/widgets/map_widget.dart';
import 'package:resq_map/features/map_and_location/cubit/map_cubit.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key, required this.lat, required this.lon});
  final double lat;
  final double lon;

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  void initState() {
    BlocProvider.of<MapCubit>(context).route(lat: widget.lat, lon: widget.lon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLoading) {
          AppActions.showLoadingDialog(context);
        }
      },

      builder: (context, state) {
        return Scaffold(
        appBar: AppBar(title:Text( "Route",
        style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),
        )),
          body:
              state is MapSuccess
                ? AlertRoutePage(
                  start: state.route.start,
                  end: state.route.end,
                  path: state.route.path,
                )
                : state is MapLoading
                ? Center(child: Text("Loading >>>"))
                : Center(child: Text("SomeThing Went Wrong!")));
      },
    );
  }
}
