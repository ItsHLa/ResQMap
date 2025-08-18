import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/padding_constants.dart';

class UserStatusItem extends StatefulWidget {
  const UserStatusItem({
    super.key,
    required this.photo,
    required this.status,
    required this.firstName,
    required this.lastName, this.action,

  });
  final String photo;
  final String status;
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
                    widget.status == "UnSafe"
                        ? Colors.red.withOpacity(0.5)
                        : Colors.green,
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
                          widget.status == "UnSafe"
                              ? Colors.red.withOpacity(0.4)
                              : Colors.green.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child:
                        widget.status == "UnSafe"
                            ? const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 20,
                            )
                            : const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 20,
                            ),
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
                "${widget.firstName} ${widget.lastName}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.status,
                style: TextStyle(
                  color: widget.status == "UnSafe" ? Colors.red : Colors.green,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const Spacer(),
          if(widget.action!=null)
              SizedBox(
                
                width: 90,
                child: widget.action!,
              )
        ],
      ),
    );
  }
}
