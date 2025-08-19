import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/padding_constants.dart';

class UserStatusItem extends StatefulWidget {
  const UserStatusItem({
    super.key,
    required this.photo,
    required this.subtitle,
    required this.firstName,
    required this.lastName,
    this.action,
    this.typeStatus = true,
  });
  final String photo;
  final String subtitle;
  final bool typeStatus;
  final String firstName;
  final String lastName;
  final Widget? action;

  @override
  State<UserStatusItem> createState() => _UserStatusItemState();
}

class _UserStatusItemState extends State<UserStatusItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PaddingConstants.md),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.photo),
              ),
              border: Border.all(
                color:
                    widget.typeStatus
                        ? widget.subtitle == "UnSafe"
                            ? Colors.red.withOpacity(0.5)
                            : Colors.green
                        : Colors.blueGrey,
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          widget.typeStatus
                              ? widget.subtitle == "UnSafe"
                                  ? Colors.red.withOpacity(0.4)
                                  : Colors.green.withOpacity(0.4)
                              : Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                    child:
                        widget.typeStatus
                            ? widget.subtitle == "UnSafe"
                                ? const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 20,
                                )
                                : const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 20,
                                )
                            : null,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.firstName.replaceRange(0, 1, widget.firstName[0].toUpperCase())} ${widget.lastName.replaceRange(0, 1, widget.lastName[0].toUpperCase())}",
                style: const TextStyle(
                  fontSize: 16,
                  
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.typeStatus ? widget.subtitle : "@${widget.subtitle}",
                style: TextStyle(
                  color:
                      widget.typeStatus
                          ? widget.subtitle == "UnSafe"
                              ? Colors.red
                              : Colors.green
                          : Colors.blueGrey,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const Spacer(),
          if (widget.action != null) SizedBox(width: 90, child: widget.action!),
        ],
      ),
    );
  }
}
