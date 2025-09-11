import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/sections/medical_record/pages/user_health_recored_view.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';

class UserHealthRecordPage extends StatefulWidget {
  const UserHealthRecordPage({super.key, required this.record});
  final MedicalRecord record;
  @override
  State<UserHealthRecordPage> createState() => _UserHealthRecordPageState();
}

class _UserHealthRecordPageState extends State<UserHealthRecordPage> {
  MedicalRecord? copy;
  @override
  void initState() {
    setState(() {
      copy = widget.record;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          Navigator.of(context).pop();
          AppActions.showSnackBar(title: state.msg, context: context);
        }
        if (state is UpdatePersonalInfoProfileSuccess) {
          setState(() {
            copy = state.record;
          });
          Navigator.of(context).pop();
          AppActions.showSnackBar(
            title: "Done Succssesfuly!",
            context: context,
          );
        }
        if (state is ProfileLoading) {
          AppActions.showLoadingDialog(context);
        }
      },

      child: UserHealthRecordView(record: copy!),
    );
  }
}
