import 'package:flutter/material.dart';

class AlertPostButtons extends StatefulWidget {
  final Function()? onTeamStatusPressed;
  final Function()? onMapPressed;

  const AlertPostButtons({
    super.key,
    this.onTeamStatusPressed,
    this.onMapPressed,
  });

  @override
  State<AlertPostButtons> createState() => _AlertPostButtonsState();
}

class _AlertPostButtonsState extends State<AlertPostButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icon(Icons.assistant, color: Colors.grey),
                label: 'Assist',
                onPressed: widget.onTeamStatusPressed,
                // isActive: isLiked,
              ),
              _buildActionButton(
                icon: Icon(Icons.route, color: Colors.grey[600]),
                label: 'Route',
                // count: comments,
                onPressed: widget.onMapPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required Icon icon,
    required String label,
    Function()? onPressed,
    bool isActive = false,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: TextStyle(
                        color: isActive ? Colors.blue : Colors.grey[700],
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
