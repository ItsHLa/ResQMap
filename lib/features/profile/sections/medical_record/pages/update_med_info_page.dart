import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';
import 'package:resq_map/features/profile/sections/medical_record/widgets/add_med_info_view.dart';

class UpdateMedInfoPage extends StatefulWidget {
  const UpdateMedInfoPage({
    super.key,
    required this.record,
    required this.index,
  });
  final MedicalRecord record;
  final int index;

  @override
  State<UpdateMedInfoPage> createState() => _AddMedInfoPageState();
}

class _AddMedInfoPageState extends State<UpdateMedInfoPage> {
  late Disease disease;
  late Medication medication;

  @override
  void initState() {
    disease = widget.record.diseases![widget.index];
    medication = widget.record.medications![widget.index];
    activeProblemNMedicationController = [
      TextEditingController(text: disease.name),
      TextEditingController(text: disease.diagnosedYear),
      TextEditingController(text: medication.name),
      TextEditingController(text: medication.dosage),
      TextEditingController(text: medication.frequency),
    ];

    super.initState();
  }

  late List<TextEditingController> activeProblemNMedicationController;

  @override
  Widget build(BuildContext context) {
    return MedicalRecordInfoFields(
      onSave: () {
        disease.name = activeProblemNMedicationController[0].text;
        disease.diagnosedYear = activeProblemNMedicationController[1].text;
        medication.name = activeProblemNMedicationController[2].text;
        medication.dosage = activeProblemNMedicationController[3].text;
        medication.frequency = activeProblemNMedicationController[4].text;
        widget.record.diseases![widget.index] = disease;
        widget.record.medications![widget.index] = medication;
        BlocProvider.of<ProfileCubit>(context).addPersonalData(record: widget.record);
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
