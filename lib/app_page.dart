import 'package:flutter/cupertino.dart';
import 'package:resq_map/core/services/fierbase_notifications.dart';
import 'package:resq_map/features/authentication/login/pages/login_page.dart';
import 'package:resq_map/features/home/home_page.dart';


class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.token});
  final String? token;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  Future<void> alertsNotification() async {
    await FirebaseNotificationService.subscribeToTopic('alert');
   
  }

 
  @override
  void initState() {
    alertsNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.token == null) ? LoginPage() : MyHomePage();
  }
}
