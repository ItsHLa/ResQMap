import 'package:flutter/material.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/models/alert_model.dart';
import 'alert_item.dart';

class AlertListView extends StatelessWidget {
  const AlertListView({super.key, required this.alerts});
  final List<Alert> alerts;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: alerts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        
        return  AlertItem(
          alert: alerts[index]
        );
      },
    );
  }
}
