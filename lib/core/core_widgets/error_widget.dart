import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.refreshData});
  final void Function()? refreshData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            "Failed to Load",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextButton(onPressed: refreshData, child: const Text("Retry")),
        ],
      ),
    );
  }
}
