import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/earthquake/cubit/quake_cubit.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/widgets/team_status.dart';

class TeamStatusPage extends StatefulWidget {
  const TeamStatusPage({super.key, required this.id, required this.locationId});
  final String id;
  final String locationId;

  @override
  State<TeamStatusPage> createState() => _TeamStatusPageState();
}

class _TeamStatusPageState extends State<TeamStatusPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WebSocketCubit, WebSocketState>(
      listener: (context, state) {
        if (state is Loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator()),
          );
        }
        if (state is Success) {
          AppActions.showSnackBar(
            title: "Status Changed Successfully!",
            context: context,
          );
          Navigator.pop(context);
        }
        if (state is Error) {
        
          AppActions.showSnackBar(
            title: "Something Went Wrong! Try Again...",
            context: context,
          );
        }
      },
      child: TeamStatusView(
        locationId: widget.locationId,
        id: widget.id),
    );
  }
}
