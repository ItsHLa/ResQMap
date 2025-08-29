import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/user_status_item.dart';
import 'package:resq_map/features/earthquake/cubit/quake_cubit.dart';
import 'package:resq_map/features/profile/model/user.dart';

class DamagedUserItem extends StatefulWidget {
  const DamagedUserItem({
    super.key,
    required this.damagedUser,
    required this.users,
  });

  final User damagedUser;
  final List<User> users;

  @override
  State<DamagedUserItem> createState() => _DamagedUserItemState();
}

class _DamagedUserItemState extends State<DamagedUserItem> {
  @override
  Widget build(BuildContext context) {
    return UserStatusItem(
      status:widget.damagedUser.status! ,
      photo: widget.damagedUser.photos!,
      subtitle: widget.damagedUser.isOnline ?"Online" : widget.damagedUser.lastSeen ??"Unknown",
      firstName: widget.damagedUser.firstName,
      lastName: widget.damagedUser.lastName,
      action: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          side: BorderSide(color: Colors.green)
        ),
        onPressed: () {
          BlocProvider.of<WebSocketCubit>(
            context,
          ).postDamagedUserStatus(userId: widget.damagedUser.id, users: widget.users);
        },
        child: Text("Rescue"),
      ),
    );
  }
}
