import 'package:flutter/material.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/widget/input_field.dart';

class FormFields extends StatelessWidget {
  const FormFields({
    super.key,
    required this.labelTexts,
    this.prefixes = const [],
    this.validators = const [],
    this.suffixes = const [],
    this.onSaveds = const [],
  });

  final List<String> labelTexts;
  final List<Widget> prefixes;
  final List<String? Function(String?)> validators;
  final List<Widget> suffixes;
  final List<void Function(String?)> onSaveds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: labelTexts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: PaddingConstants.spaceBtwInputFields),
          child: Field(
            labelText: labelTexts[index],
            validator: _getSafeValue(validators, index, (_) => null),
            suffix: _getSafeValue(suffixes, index, null),
            prefix: _getSafeValue(prefixes, index, null),
            onSaved: _getSafeValue(onSaveds, index, (_) {}),
          ),
        );
      },
    );
  }

  T _getSafeValue<T>(List<T> list, int index, T defaultValue) {
    return index < list.length ? list[index] : defaultValue;
  }
}