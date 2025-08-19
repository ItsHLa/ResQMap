import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/core_widgets/user_status_item.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';
import 'package:resq_map/features/safty/safty_model.dart';
import 'package:resq_map/features/safty/widgets/add_safty_view.dart';

class SaftyView extends StatefulWidget {
  const SaftyView({super.key, required this.mySafty, required this.userStatus});
  final SaftyModel userStatus;
  final List<User> mySafty;

  @override
  State<SaftyView> createState() => _SaftyViewState();
}

class _SaftyViewState extends State<SaftyView> {
  bool safe = false;
  String userStatus = "Unknown";

  @override
  void initState() {
    // mySafty = widget.mySafty;
    print(widget.mySafty);
    userStatus = widget.userStatus.status;
    safe =
        (widget.userStatus.status == "Safe" ||
                widget.userStatus.status == "Rescued")
            ? true
            : false;
    // TODO: implement initState
    super.initState();
  }

  void navigateTo() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddSaftyView()));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Icon(
            Icons.location_on_outlined,
            color: appThemeColor,
            size: 35,
          ),
          title: Text(
            "Currect Location",
            style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(widget.userStatus.lastLocation),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Icon(
            Icons.safety_check_outlined,
            color: appThemeColor,
            size: 35,
          ),
          subtitle: Text(userStatus),
          title: Text(
            "User Status",
            style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w400),
          ),
          trailing: Switch(
            value: safe,
            onChanged: (value) {
              setState(() {
                safe = value;
              });
              setState(() {
                userStatus = safe ? "Safe" : "UnSafe";
              });
              BlocProvider.of<SaftyCubit>(context).markSafe(safe);
            },
          ),
        ),
        if (widget.mySafty.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingConstants.lg),
            child: ElevatedButton(
              onPressed: navigateTo,
              child: Text("Create Your Safty Network"),
            ),
          ),
        if (widget.mySafty.isNotEmpty)
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
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.mySafty.length,
          itemBuilder:
              (context, index) => UserStatusItem(
                photo: widget.mySafty[index].photos!,
                subtitle: widget.mySafty[index].status ?? "Unknown",
                lastName: widget.mySafty[index].lastName,
                firstName: widget.mySafty[index].firstName,
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
      ],
    );
  }
}
