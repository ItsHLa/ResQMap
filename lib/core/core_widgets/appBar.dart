import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/core_widgets/curved_edges.dart';
import 'package:resq_map/core/constants/padding_constants.dart';


class RAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? widgetTitle;
  final List<Widget>? additional;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool? centerTitle;
  final double? appBarHeight;
  final Widget? bottom;

  const RAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.centerTitle,
    this.additional, this.widgetTitle, this.appBarHeight, this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RCustomCurvedEdges(),
      child: AppBar(
        bottomOpacity: 1,
        flexibleSpace: bottom ,
        title: title!=null ? Text(
          title!,
          
        ) : widgetTitle,
        centerTitle: centerTitle,
        backgroundColor: appThemeColor,

        actions: [
          if(actions!=null)
            ...actions!,
           SizedBox(width: PaddingConstants.lg),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight( (kToolbarHeight + 50) + (bottom != null ? 90 : 0));
}
