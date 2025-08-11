import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';
import 'package:resq_map/features/profile/sections/medical_record/widgets/add_med_info_view.dart';

class AddMedInfoPage extends StatefulWidget {
  const AddMedInfoPage({super.key, required this.record});
  final MedicalRecord record;

  @override
  State<AddMedInfoPage> createState() => _AddMedInfoPageState();
}

class _AddMedInfoPageState extends State<AddMedInfoPage> {
  Disease? newDisease;
  Medication? newMedication;

  List<TextEditingController> activeProblemNMedicationController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return MedicalRecordInfoFields(
      onSave: () {
        BlocProvider.of<ProfileCubit>(
          context,
        ).addPersonalData(
         record:  widget.record,
          newDisease:  Disease(
          name: activeProblemNMedicationController[0].text,
          diagnosedYear: activeProblemNMedicationController[1].text,
        ), 
       newMedication:  Medication(
          name: activeProblemNMedicationController[2].text,
          dosage: activeProblemNMedicationController[3].text,
          frequency: activeProblemNMedicationController[4].text,
        )
          );
      },
      labels: [
        "Name Problem",
        "Diagosed year",
        "Name Mediaction",
        "Dosage (in mg)",
        "Frequency",
      ],
      activeProblemNMedicationController: activeProblemNMedicationController,
    );
  }
}
