import 'package:flutter/material.dart';
import 'package:resq_map/core/padding_constants.dart';

class BackHeader extends StatelessWidget {
  const BackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: PaddingConstants.sm,),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          Spacer(),
          ],
        ),
      ],
    );
  }
}
