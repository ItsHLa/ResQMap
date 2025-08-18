// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:resq_map/core/constants/constants.dart';
// import 'package:resq_map/core/core_widgets/appBar.dart';
// import 'package:resq_map/core/core_widgets/loading_widget.dart';
// import 'package:resq_map/core/services/actions.dart';
// import '../../cubit/quake_cubit.dart';
// import '../widgets/alert_listview.dart';

// class AlertsPage extends StatefulWidget {
//   const AlertsPage({super.key});

//   @override
//   State<AlertsPage> createState() => _AlertsPageState();
// }

// class _AlertsPageState extends State<AlertsPage> {
//   Future<void> _refreshData() async {
//     await BlocProvider.of<WebSocketCubit>(context).getAlerts();
//   }

//   @override
//   void initState() {
//     _refreshData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: RAppBar(
//         title: "Nearby Alerts",
//         actions: [Icon(Icons.nearby_error_outlined, size: 30)],
//       ),
//       body: RefreshIndicator(
//         color: appThemeColor,
//         onRefresh: _refreshData,
//         child: BlocConsumer<WebSocketCubit, WebSocketState>(
//           buildWhen: (previous, current) => ( previous is WebSocketAlertsReceived)||
//             (previous is Loading)||(current is Loading)||
//             (current is WebSocketAlertsReceived) ,
//           listener: (context, state) {
//             if (state is WebSocketError) {
//               AppActions.showSnackBar(
//                 title: "SomeThing Went Wrong,Check Your Internet Connection",
//                 context: context,
//               );
//             }
//           },
//           builder: (context, state) {
//             Widget? content;
//             print(state);
//             if (state is WebSocketAlertsReceived) {
//               content =
//                   state.alerts.isEmpty
//                       ? Center(
//                         child: Text("Everything is good :) \n Have a Good Day"),
//                       )
//                       : AlertListView(alerts: state.alerts);
//             } else if (state is WebSocketLoading ||
//                 state is WebSocketConnecting) {
//               content = const LoadingAnimation();
//             }
//             return SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: content,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/core_widgets/error_widget.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/services/actions.dart';
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
        title: "Nearby Alerts",
        actions: [const Icon(Icons.nearby_error_outlined, size: 30)],
      ),
      body: RefreshIndicator(
        color: appThemeColor,
        onRefresh: _refreshData,
        child: BlocConsumer<WebSocketCubit, WebSocketState>(
          buildWhen: (previous, current) {
            return current is WebSocketAlertsReceived ||
                current is WebSocketLoading ||
                current is WebSocketError;
          },
          listener: (context, state) {
            if (state is WebSocketError) {
              AppActions.showSnackBar(
                title: "Check Your Internet Connection",
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is WebSocketLoading || state is WebSocketConnecting) {
              return const Center(child: LoadingAnimation());
            }

            if (state is WebSocketError) {
              return ErrorView(refreshData: _refreshData);
            }

            if (state is WebSocketAlertsReceived) {
              return state.alerts.isEmpty
                  ? Center(
                    child: Text(
                      "Everything is good :)\nHave a Good Day",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                  : AlertListView(alerts: state.alerts);
            }

            // Initial state
            return const Center(child: LoadingAnimation());
          },
        ),
      ),
    );
  }
}
