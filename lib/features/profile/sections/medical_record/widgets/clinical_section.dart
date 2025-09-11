import 'package:flutter/material.dart';

class ClinicalSection extends StatefulWidget {
  const ClinicalSection({super.key, this.title, this.items, this.onPressedAdd, required this.showAdd});

  final String? title;

  final List<Widget>? items;
  final bool showAdd;
  final void Function()? onPressedAdd;

  @override
  State<ClinicalSection> createState() => _ClinicalSectionState();
}

class _ClinicalSectionState extends State<ClinicalSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            if (widget.showAdd)
              IconButton(
                iconSize: 30,
                onPressed: widget.onPressedAdd, icon: Icon(Icons.add)),
            SizedBox(width: 16),
          ],
        ),

        ...widget.items!,
      ],
    );
  }
}
