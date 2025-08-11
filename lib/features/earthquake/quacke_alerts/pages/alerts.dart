import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import '../../cubit/quake_cubit.dart';
import '../widgets/alert_listview.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  Future<void> _refreshData() async {
    await BlocProvider.of<WebSocketCubit>(context).getAlerts();
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAppBar(
        title:"Nearby Alerts",
        actions: [Icon(Icons.nearby_error_outlined, size: 30,),],),
      body: RefreshIndicator(
        color: appThemeColor,
        onRefresh: _refreshData,
        child: BlocBuilder<WebSocketCubit, WebSocketState>(
          builder: (context, state) {
            
            Widget content;
            
            if (state is WebSocketAlertsReceived) {
              content = state.alerts.isEmpty
                  ? Center(
                      child: Text(
                        "Everything is good :) \n Have a Good Day",
                      ),
                    )
                  : AlertListView(alerts: state.alerts);
            } else if (state is WebSocketLoading || state is WebSocketConnecting) {
              content = const LoadingAnimation();
            } else {
              content = Center(
                child: Text(
                  "SomeThing Went Wrong, \n Check Your Internet Connection",
                ),
              );
            }

            
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: content,
            );
          },
        ),
      ),
    );
  }
}