import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/error_widget.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/earthquake/cubit/quake_cubit.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/widgets/damaged_users_view.dart';

class DamagedUserPage extends StatefulWidget {
  const DamagedUserPage({super.key, required this.locationId});
  final String? locationId;

  @override
  State<DamagedUserPage> createState() => _DamagedUserPageState();
}

class _DamagedUserPageState extends State<DamagedUserPage> {
  Future<void> _refreshData() async {
    await BlocProvider.of<WebSocketCubit>(
      context,
    ).getDamagedUsers(widget.locationId);
  }

  @override
  void initState() {
    _refreshData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebSocketCubit, WebSocketState>(
      buildWhen: (previous, current) {
        return current is Loading ||
            current is GetDamagedUsersSuccess ||
            current is Error;
      },
      listener: (context, state) {
        if (state is Error) {
          Navigator.of(context).pop();
          AppActions.showSnackBar(
            title: "Check Your Internet Connection",
            context: context,
          );
        }
        if (state is LoadingDamaged) {
          AppActions.showLoadingDialog(context);
        }
        if (state is GetDamagedUsersSuccess) {
          if (state.markedRescued) {
            Navigator.of(context).pop();
            AppActions.showSnackBar(
            title: "Marked Rescued Succssfully!",
            context: context,
          );
          }
        }
      },
      builder: (context, state) {
        Widget content = LoadingAnimation();
        if (state is GetDamagedUsersSuccess) {
          content =
              state.damagedUsers.isEmpty
                  ? Center(
                    child: Text(
                      "Everything is good :)\nHave a Good Day",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                  : DamagedUsersView(damagedUsers: state.damagedUsers);
        }
        if (state is Error) {
          content = ErrorView(refreshData: _refreshData);
        }
        return Scaffold(appBar: AppBar(
          title: Text("Damaged Users"),
        ), body: content);
      },
    );
  }
}
