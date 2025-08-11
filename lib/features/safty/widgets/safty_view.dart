import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';
import 'package:resq_map/features/safty/safty_model.dart';

class SaftyView extends StatefulWidget {
  const SaftyView({super.key, required this.mySafty});
  final SaftyModel mySafty;

  @override
  State<SaftyView> createState() => _SaftyViewState();
}

class _SaftyViewState extends State<SaftyView> {
  bool? safe;
  @override
  void initState() {
    safe = widget.mySafty.isMarkedSafe;
    // TODO: implement initState
    super.initState();
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
            style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w300),
          ),
          subtitle: Text(widget.mySafty.lastLocation),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Icon(
            Icons.safety_check_outlined,
            color: appThemeColor,
            size: 35,
          ),
          title: Text(
            "Mark Safe",
            style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w300),
          ),
          trailing: Switch(
            value: safe ?? false,
            onChanged: (value) {
              setState(() {
                safe = value;
              });
              BlocProvider.of<SaftyCubit>(context).markSafe(safe!);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: PaddingConstants.lg),
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Create Your Safty Network"),
          ),
        ),
      ],
    );
  }
}
