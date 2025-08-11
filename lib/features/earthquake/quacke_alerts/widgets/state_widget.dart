import 'package:flutter/cupertino.dart';

class StateWidget extends StatelessWidget {
  const StateWidget({super.key, required this.text, required this.url});
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(url),
        Text(
          text
        )
      ],
    );
  }
}
