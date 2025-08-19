import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStateWidget extends StatelessWidget {
  const MyStateWidget({
    super.key,
    this.refreshData,
    required this.title,
    required this.iconData,
  });
  final void Function()? refreshData;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(iconData, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (refreshData != null) 
              TextButton(onPressed: refreshData, child: const Text("Retry")),
        ],
      ),
    );
  }
}
