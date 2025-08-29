import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/padding_constants.dart';

class UserStatusItem extends StatefulWidget {
  const UserStatusItem({
    super.key,
    required this.photo,
    required this.subtitle,
    required this.status,
    required this.firstName,
    required this.lastName,
    this.action,
    this.typeStatus = true,
    this.showLocationAsText = false, 
    this.locationText, 
  });

  final String photo;
  final String subtitle;
  final String status;
  final bool typeStatus;
  final String firstName;
  final String lastName;
  final Widget? action;
  final bool showLocationAsText;
  final String? locationText;

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
          _buildUserAvatar(),

          const SizedBox(width: 16),

          // USER INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // USER FULL NAME
                Text(
                  "${_capitalizeFirstLetter(widget.firstName)} ${_capitalizeFirstLetter(widget.lastName)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // USERNAME
                _buildSubtitle(),

                //LOCATION
                if (widget.showLocationAsText && widget.locationText != null)
                  _buildLocationText(),
              ],
            ),
          ),

          // ACTION BUTTON
          if (widget.action != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(width: 90, child: widget.action!),
            ),
        ],
      ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // AVATAR COLOR
  Widget _buildUserAvatar() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.photo),
        ),
        border: Border.all(color: _getStatusColor()!, width: 2),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _getStatusColor()!.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: _getStatusIcon(),
            ),
          ),
        ],
      ),
    );
  }

  // STATUS COLOR
  Color? _getStatusColor() {
    if (widget.typeStatus) {
      switch (widget.status) {
        case "Unsafe":
          return Colors.red;
        case "Safe":
          return Colors.green;
        case "Rescued":
          return Color(0xFF0097A7);
        default:
          return Colors.blueGrey;
      }
    }
    return Colors.blueGrey;
  }

  // STATUS
  Widget? _getStatusIcon() {
    if (!widget.typeStatus) return null;
    return Text(
      widget.status,
      style: TextStyle(color: Colors.white, fontSize: 8),
    );
  }

  // SUBTITLE
  Widget _buildSubtitle() {
    final subtitleText =
        widget.typeStatus ? widget.subtitle : "@${widget.subtitle}";

    return Text(
      subtitleText,
      style:  TextStyle(color:subtitleText == "Online" ? Colors.green.withOpacity(0.8): Colors.blueGrey, fontSize: 12),
      overflow: TextOverflow.ellipsis,
    );
  }

  // LOCATION INFO
  Widget _buildLocationText() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue[700], size: 14),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.locationText!,
              softWrap: true,
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
