import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';

class ClinicalItem extends StatefulWidget {
  const ClinicalItem({
    super.key,
    required this.disease,
    required this.medication,
    required this.isExample,
    this.onTap,
    this.onDelete,
  });
  final Disease disease;
  final Medication medication;
  final bool isExample;
  final void Function()? onTap;
  final void Function()? onDelete;

  @override
  State<ClinicalItem> createState() => _ClinicalItemState();
}

class _ClinicalItemState extends State<ClinicalItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: appThemeColor, width: 4)),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.disease.name!,
                style: widget.isExample ? TextStyle(color: Colors.blueGrey) : null,
              ),
              trailing: widget.isExample? null : IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(Icons.cancel_outlined),
                  ),
              subtitle: Text(
                        widget.disease.diagnosedYear!,
                        style:
                            widget.isExample
                                ? TextStyle(color: Colors.blueGrey)
                                : null,)),
        
            ListTile(
              title: Text(
                widget.medication.name!,
                style: widget.isExample ? TextStyle(color: Colors.blueGrey) : null,
              ),
              subtitle:
                  Text(
                      widget.medication.frequency!,
                        style:
                            widget.isExample
                                ? TextStyle(color: Colors.blueGrey)
                                : null,
                      )
                    ,
            trailing: Text(
              "${widget.medication.dosage!} mg",
              style:
                  widget.isExample
                      ? TextStyle(color: Colors.blueGrey)
                      : null,
            ),
                  
            ),
          
          ],
        ),
      ),
    
    );
  }
}
