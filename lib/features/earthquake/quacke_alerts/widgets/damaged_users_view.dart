import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/widgets/damaged_user_item.dart';
import 'package:resq_map/features/profile/model/user.dart';

class DamagedUsersView extends StatefulWidget {
  const DamagedUsersView({super.key, required this.damagedUsers});
  final List<User> damagedUsers;

  @override
  State<DamagedUsersView> createState() => _DamagedUsersViewState();
}

class _DamagedUsersViewState extends State<DamagedUsersView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.damagedUsers.length,
      itemBuilder: (context, index) => DamagedUserItem(
        users: widget.damagedUsers,
        damagedUser: widget.damagedUsers[index], 
      ),
    );
  }
}
