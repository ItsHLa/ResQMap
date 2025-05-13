import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  const Field({super.key, this.suffix,this.prefix, required this.labelText, this.validator, this.onSaved});
  final Widget? suffix;
  final Widget? prefix;
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefix,
        labelText: labelText,
    
      suffix: suffix,
     
      ));
  }
}
