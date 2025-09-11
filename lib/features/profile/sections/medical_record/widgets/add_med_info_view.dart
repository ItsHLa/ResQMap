import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/profile/widgets/info_fields.dart';

class MedicalRecordInfoFields extends StatefulWidget {
  const MedicalRecordInfoFields({
    super.key,
    required this.labels,
    this.onSave,
    required this.activeProblemNMedicationController,
  });
  final List labels;
  final void Function()? onSave;
  final List<TextEditingController> activeProblemNMedicationController;

  @override
  State<MedicalRecordInfoFields> createState() =>
      _MedicalRecordInfoFieldsState();
}

class _MedicalRecordInfoFieldsState extends State<MedicalRecordInfoFields> {
 final infoKey = GlobalKey<FormState>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              "Active Problem & Medication",
             style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),
            ),
      ),
      body:  InfoFields(
        maxLength: [null,4,null, 5,null],
        keyboardType: [
          TextInputType.name,
          TextInputType.number,
          TextInputType.name,
          TextInputType.name,
          TextInputType.name,
        ],
        title: "Enter Your Medical Details: ",
        physics: NeverScrollableScrollPhysics(),
          onSave: widget.onSave,
          controller: widget.activeProblemNMedicationController,
          labels:widget.labels,

        ),
      
      
    );
  }
}
