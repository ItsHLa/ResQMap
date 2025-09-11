import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/core/core_widgets/user_status_item.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';
import 'package:resq_map/features/safty/widgets/add_safty_view.dart';

class SaftyView extends StatefulWidget {
  const SaftyView({super.key, required this.mySafty});

  final List<User> mySafty;

  @override
  State<SaftyView> createState() => _SaftyViewState();
}

class _SaftyViewState extends State<SaftyView> {
  
  

  void navigateTo() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddSaftyView()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
     
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "TRUSTED CONTACTS",
              style: TextStyles.textStyle16.copyWith(
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            IconButton(
              iconSize: 35,
              onPressed: navigateTo,
              icon: Icon(Icons.add),
            ),
          ],
        ),

        if (widget.mySafty.isEmpty)
          Expanded(
            child: Center(
              child: MyStateWidget(
                title: "Create Your Safty Network",
                iconData: Icons.group,
              ),
            ),
          ),
        if (widget.mySafty.isNotEmpty)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.mySafty.length,
              itemBuilder:
                  (context, index) => UserStatusItem(
                    photo: widget.mySafty[index].photos!,
                    status: widget.mySafty[index].status ?? "Unknown",
                    subtitle:
                        widget.mySafty[index].isOnline
                            ? "Online"
                            : widget.mySafty[index].lastSeen ?? "Unknown",
                    lastName: widget.mySafty[index].lastName,
                    firstName: widget.mySafty[index].firstName,
                    showLocationAsText: true,
                    locationText: widget.mySafty[index].location!.fulladdress,
                    action: IconButton(
                      onPressed: () {
                        BlocProvider.of<SaftyCubit>(context).removeFromMySafty(
                          user: widget.mySafty[index],
                          users: widget.mySafty,
                        );
                      },
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                  ),
            ),
          ),
      ],
    );
  }
}
