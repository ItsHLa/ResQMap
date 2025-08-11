import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/sections/medical_record/pages/update_med_info_page.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';
import 'package:resq_map/features/profile/sections/medical_record/pages/add_med_info_page.dart';
import 'package:resq_map/features/profile/sections/medical_record/widgets/clinical_item.dart';
import 'package:resq_map/features/profile/sections/medical_record/widgets/clinical_section.dart';
import 'package:resq_map/features/profile/widgets/info_fields.dart';

class UserHealthRecordView extends StatefulWidget {
  const UserHealthRecordView({super.key, required this.record});
  final MedicalRecord record;

  @override
  State<UserHealthRecordView> createState() => _UserHealthRecordPageState();
}

class _UserHealthRecordPageState extends State<UserHealthRecordView> {
  late List diseases;
  late List medication;
  late String bloodType;
  List<TextEditingController> activeProblemNMedicationController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<String> headers = ['Blood Type', 'Problems & Medications'];

  TextEditingController bloodTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bloodType = (widget.record.bloodType ?? "eg: A+");
    diseases =
        (widget.record.diseases!.isEmpty
            ? [Disease(name: "eg: Hypertension", diagnosedYear: "eg: 2015")]
            : widget.record.diseases)!;
    medication =
        (widget.record.medications!.isEmpty
            ? [
              Medication(
                name: "eg: Lisinopril",
                dosage: "eg: 10",
                frequency: "eg: Once a day",
              ),
            ]
            : widget.record.medications)!;
    List<Widget> onAddPress = [
      InfoFields(
        onSave: () {
          BlocProvider.of<ProfileCubit>(context).addPersonalData(
            bloodType: bloodTypeController.text,
            record: widget.record,
          );
        },
        controller: [bloodTypeController],
        title: "Add Your Blood Type",
        labels: ["Blood type"],
      ),
      AddMedInfoPage(record: widget.record),
    ];

    List<bool> showAdds = [
      widget.record.bloodType == null ? true : false,
      true,
      false,
      false,
    ];

    List items = [
      [
        ListTile(
          leading: Icon(Icons.bloodtype, color: appThemeColor, size: 30),
          title: Text(
            bloodType,
            style:
                widget.record.bloodType == null
                    ? TextStyle(color: Colors.grey)
                    : null,
          ),
        ),
      ],
      [
        ...diseases.asMap().entries.map((entry) {
          final index = entry.key;
          return ClinicalItem(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UpdateMedInfoPage(
                  index: index,
                  record: widget.record),)
              );
            },
            onDelete: () {
              BlocProvider.of<ProfileCubit>(context).removePersonalData(
                widget.record,
                diseases[index],
                medication[index],
              );
            },
            disease: diseases[index],
            medication: medication[index],
            isExample: widget.record.diseases!.isEmpty,
          );
        }),
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Records',
          style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: headers.length,
        itemBuilder:
            (context, index) => ClinicalSection(
              showAdd: showAdds[index],
              title: headers[index].toUpperCase(),
              items: items[index],
              onPressedAdd: () {
                index == 0
                    ? showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => onAddPress[index],
                    )
                    : Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => onAddPress[index],
                      ),
                    );
              },
            ),
      ),
    );
  }
}
