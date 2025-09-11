import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/colors_constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/core_widgets/map_in_place_item.dart';

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
    if (magnitude < 3.0) return ColorsConstants.DANGER_LOW;
    if (magnitude < 5.0) return ColorsConstants.DANGER_MODERATE;
    if (magnitude < 10.0) return ColorsConstants.DANGER_HIGH;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = Colors.white.withOpacity(0.95);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MapInPlaceItem(
        lat: lat,
        lon: lon,
        opacity: 0.3,

        leading: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: getQuakeColor(mag).withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  mag.toStringAsFixed(2),
                  style: TextStyles.textStyle12.copyWith(
                     fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "${depth.toStringAsFixed(2)} km",
                  style: TextStyles.textStyle12.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    
                  ),
                ),
              ),
            ],
          ),
        ),

        color: Colors.transparent,
        title: Text(
          place,
          style: TextStyle(
            fontSize:13,
            fontWeight: FontWeight.w400,
            color: textColor),
        ),

        children: [
          Text(
            time,
            style: TextStyles.textStyle12.copyWith(
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
