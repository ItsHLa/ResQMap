import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';
import 'package:resq_map/features/safty/widgets/safty_view.dart';

class SaftyPage extends StatefulWidget {
  const SaftyPage({super.key});

  @override
  State<SaftyPage> createState() => _SaftyPageState();
}

class _SaftyPageState extends State<SaftyPage> {
  @override
  void initState() {
    BlocProvider.of<SaftyCubit>(context).getUserStatus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaftyCubit, SaftyState>(
      listener: (context, state) {
        if (state is MarkSafeSuccess) {
          AppActions.showSnackBar(
            title: "Marked Safe Successfuly!",
            context: context,
          );
        }
        if (state is MarkSafeFailed) {
          AppActions.showSnackBar(
            title: "SomeThing Went Wrong!",
            context: context,
          );
        }
      },
      builder: (context, state) {
        Widget body = Center( child:  Text("SomeThing Went Wrong"));
        if (state is UserStatusSuccess) {
          body = SaftyView(mySafty: state.mySafty);
        }
        if (state is Loading){
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
