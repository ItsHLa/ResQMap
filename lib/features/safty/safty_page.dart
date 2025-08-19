import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';
import 'package:resq_map/features/safty/widgets/safty_view.dart';

class SaftyPage extends StatefulWidget {
  const SaftyPage({super.key});

  @override
  State<SaftyPage> createState() => _SaftyPageState();
}

class _SaftyPageState extends State<SaftyPage> {
  Future<void> _refreshData() async {
    await BlocProvider.of<SaftyCubit>(context).getUserStatus();
  }

  List<User> mySafty = [];
  @override
  void initState() {
    _refreshData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaftyCubit, SaftyState>(
      listener: (context, state) {
        if (state is MySaftyLoading) {
          AppActions.showLoadingDialog(context);
        }
        if (state is MarkSafeSuccess) {
          AppActions.showSnackBar(
            title: "Marked Safe Successfuly!",
            context: context,
          );
        }
        if (state is AddedSaftyUsersSuccess) {
          setState(() {
            mySafty.add(state.addedToSafty);
          });
          Navigator.of(context).pop();
          AppActions.showSnackBar(
            title: "Added To Safty Successfuly!",
            context: context,
          );
        }
        if (state is DeleteSaftyUsersSuccess) {
          setState(() {
            mySafty = state.users;
          });
          Navigator.of(context).pop();
          AppActions.showSnackBar(
            title: "Delete To Safty Successfuly!!",
            context: context,
          );
        }
        if (state is MySaftyError) {
          AppActions.showSnackBar(
            title: "SomeThing Went Wrong!",
            context: context,
          );
        }
      },
      buildWhen: (previous, current) {
        return current is UserStatusSuccess ||
            current is Loading ||
            current is Error;
      },
      builder: (context, state) {
        Widget body = MyStateWidget(
                iconData: Icons.error_outline,
                title: "Failed to Load",
                refreshData: _refreshData);
        if (state is UserStatusSuccess) {
          mySafty = state.mySafty;
          print(mySafty[mySafty.length-1].status);
          body = SaftyView(userStatus: state.myStatus, mySafty: mySafty);
        }
        if (state is Loading) {
          body = LoadingAnimation();
        }
        return Scaffold(
          appBar: RAppBar(
            title: "Safty NetWork",
            actions: [Icon(Icons.safety_check_outlined, size: 30)],
          ),
          body: body,
        );
      },
    );
  }
}
