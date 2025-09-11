import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';

class SelectBloodTypeView extends StatefulWidget {
  const SelectBloodTypeView({super.key, required this.record});
  final MedicalRecord record;


  @override
  State<SelectBloodTypeView> createState() => _SelectBloodTypeViewState();
}

class _SelectBloodTypeViewState extends State<SelectBloodTypeView> {
  String? bloodType;
  
  final List<String> _options = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Your Blood Type")),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Icon(Icons.bloodtype_rounded, size: 35, color: appThemeColor,),
              SizedBox(width: 8,),
              Text("Blood Group*", style: TextStyles.textStyle16,)
            ],
          ),
          SizedBox(height: 16,),
          ..._options
              .map(
                (type) => RadioListTile(
                  activeColor: appThemeColor,
                  groupValue: bloodType,
                  title: Text(type),
                  value: type,
                  onChanged: (value) {
                    setState(() {
                      bloodType = value;
                    });
                  },
                ),
              )
              .toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print(bloodType);
                    BlocProvider.of<ProfileCubit>(context).addPersonalData(
            bloodType: bloodType,
            record: widget.record,
          );
              },
              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
