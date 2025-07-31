import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/core_widgets/my_map_widget.dart';

class QuakeNewsItem extends StatelessWidget {
  const QuakeNewsItem({
    super.key,
    required this.lat,
    required this.lon,
    required this.mag,
    required this.depth,
    required this.place,
    required this.time,
  });
  final double lat;
  final double lon;
  final double mag;
  final double depth;
  final String place;
  final String time;

  Color getQuakeColor(double magnitude) {
    if (magnitude < 3.0) return Colors.green.shade500; // Minor - green
    if (magnitude < 5.0) return Colors.orange.shade500; // Moderate - orange
    if (magnitude < 7.0) return Colors.red.shade500; // Strong - red
    return Colors.purple; // Major - purple
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PaddingConstants.inputFieldRadius)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width ,
            child: MyMap(
              flags: InteractiveFlag.none,
              showButtons: false,
              useMarks: true, 
              latLng: [LatLng(lat, lon)]),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(PaddingConstants.inputFieldRadius),
                right: Radius.circular(PaddingConstants.inputFieldRadius)
              )
            ),
            tileColor: getQuakeColor(mag),
            title: Text(
              place,
              style: TextStyles.textStyle12.copyWith(
                
                color: softWhite,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //DEPTH
                Text(
                  "Depth: ${depth.toStringAsFixed(2)} km",
                  style: TextStyles.textStyle12.copyWith(
                    color: softWhite,
                    fontWeight: FontWeight.w300,
                   
                  ),
                ),
      
                
                // TIME
                const SizedBox(width: 4),
                Text(
                  time,
                  style: TextStyles.textStyle12.copyWith(
                    color: softWhite,
                    fontWeight: FontWeight.w300,
                   
                  ),
                ),
              ],
            ),
            leading: Text(
              mag.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: softWhite,
                // color: getQuakeColor(mag)
              ),
            ),
          ),
      
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
