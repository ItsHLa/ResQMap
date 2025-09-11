import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';

class InfoFields extends StatefulWidget {
  const InfoFields({
    super.key,
    required this.labels,
    required this.title,
    this.onSave,
    required this.controller,
    this.physics,
    this.keyboardType,
    this.maxLength
  });
  final List labels;
  final String title;
  final void Function()? onSave;
  final List<TextEditingController> controller;
  final ScrollPhysics? physics;
  final List<TextInputType?>? keyboardType;
  final List<int?>? maxLength;
 
  @override
  State<InfoFields> createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<InfoFields> {
  final infoKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: widget.physics,
      child: Padding(
        padding: EdgeInsets.only(
          left: PaddingConstants.md,
          right: PaddingConstants.md,
          top: PaddingConstants.md,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyles.textStyle18.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: PaddingConstants.md),
            Form(
              key: infoKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.labels.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        left: PaddingConstants.sm,
                        right: PaddingConstants.sm,
                        bottom: PaddingConstants.md,
                      ),

                      child: TextFormField(
                        
                       buildCounter: (BuildContext context, 
                { required int currentLength, 
                  required bool isFocused, 
                  required int? maxLength }) {
    return maxLength !=null ? Text(
      '$currentLength / $maxLength',
      style: TextStyle(
        color: currentLength == maxLength ? Colors.red : Colors.grey,
        fontSize: 12,
      ),
    ): null;
  },
                        maxLength: widget.maxLength != null
                                ? widget.maxLength![index]
                                : null,
                        keyboardType:
                            widget.keyboardType != null
                                ? widget.keyboardType![index]
                                : null,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Field Can not be Empty"
                                    : null,
                        onSaved: (value) {
                          setState(() {
                            widget.controller[index].text = value!;
                          });
                        },
                        controller: widget.controller[index],
                        decoration: InputDecoration(
                          
                          label: Text(widget.labels[index]),
                        ),
                      ),
                    ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (infoKey.currentState!.validate()) {
                  infoKey.currentState!.save();
                  widget.onSave!();
                }
              },
              child: Text("Save"),
            ),
            SizedBox(height: PaddingConstants.md),
          ],
        ),
      ),
    );
  }
}
