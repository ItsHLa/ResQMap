// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:resq_map/core/constants/padding_constants.dart';
// import 'package:resq_map/core/core_widgets/my_map_widget.dart';

// class MapInPlaceItem extends StatelessWidget {
//   const MapInPlaceItem({
//     super.key,
//     required this.lat,
//     required this.lon,
//     this.color,
//     this.title,
//     this.children = const [],
//     this.leading,
//   });
//   final double? lat;
//   final double? lon;
//   final Color? color;
//   final Widget? title;
//   final List<Widget> children;
//   final Widget? leading;
//   @override
//   Widget build(BuildContext context) {
//     return (lat != null && lon != null)
//         ? Container(
//           margin: const EdgeInsets.all(8),
//           child: Stack(
//             children: [
//               // MAP
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(
//                   PaddingConstants.inputFieldRadius,
//                 ),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height / 2.5,
//                   width: MediaQuery.of(context).size.width,
//                   child: MyMap(
//                     flags: InteractiveFlag.none,
//                     showButtons: false,
//                     useMarks: true,
//                     latLng: [LatLng(lat!, lon!)],
//                   ),
//                 ),
//               ),

//               // INFO CARD
//               Positioned(
//                 width: MediaQuery.of(context).size.width,
//                 left: -8,
//                 bottom: 0,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       PaddingConstants.inputFieldRadius,
//                     ),
//                     // color: color,
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                         PaddingConstants.inputFieldRadius,
//                       ),
//                     ),
//                     tileColor: Colors.transparent,
//                     title: title,
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: children,
//                     ),
//                     leading: leading,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//         : ListTile(
//           contentPadding: EdgeInsets.all(PaddingConstants.md),
//           subtitle: Text("Unknown"),
//           leading: leading,
//            title: title);
//   }
// }


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/core/core_widgets/my_map_widget.dart';

class MapInPlaceItem extends StatelessWidget {
  const MapInPlaceItem({
    super.key,
    required this.lat,
    required this.lon,
    this.color,
    this.title,
    this.children = const [],
    this.leading,  this.opacity =  0.2,
  });
  final double opacity ;
  final double? lat;
  final double? lon;
  final Color? color;
  final Widget? title;
  final List<Widget> children;
  final Widget? leading;
  
  @override
  Widget build(BuildContext context) {
    return (lat != null && lon != null)
        ? Container(
          margin: const EdgeInsets.all(8),
          child: Stack(
            children: [
              // MAP
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  PaddingConstants.inputFieldRadius,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  child: MyMap(
                    flags: InteractiveFlag.none,
                    showButtons: false,
                    useMarks: true,
                    latLng: [LatLng(lat!, lon!)],
                  ),
                ),
              ),

              // INFO CARD
              Positioned(
                width: MediaQuery.of(context).size.width,
                left: -8,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      PaddingConstants.inputFieldRadius,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      PaddingConstants.inputFieldRadius,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: color!.withOpacity(opacity),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              PaddingConstants.inputFieldRadius,
                            ),
                          ),
                          tileColor: Colors.transparent,
                          title: title,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children,
                          ),
                          leading: leading,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        : ListTile(
          contentPadding: EdgeInsets.all(PaddingConstants.md),
          subtitle: Text("Unknown"),
          leading: leading,
           title: title);
  }
}