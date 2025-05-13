import 'package:flutter/cupertino.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/padding_constants.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.titles});
  final List<Widget> titles;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        const SizedBox(height: PaddingConstants.appBarHeight),
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(appicon, fit: BoxFit.contain),
        ),
        ...titles,
      ],
    );
  }
}
