import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:resq_map/core/constants/colors_constants.dart';
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
    if (magnitude < 3.0) return ColorsConstants.DANGER_LOW;
    if (magnitude < 5.0) return ColorsConstants.DANGER_MODERATE;
    if (magnitude < 10.0) return ColorsConstants.DANGER_HIGH;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          // MAP
          ClipRRect(
            borderRadius: BorderRadius.circular(PaddingConstants.inputFieldRadius),
            child: SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: MyMap(
                flags: InteractiveFlag.none,
                showButtons: false,
                useMarks: true,
                latLng: [LatLng(lat, lon)],
              ),
            ),
          ),
          
          // INFO CARD
          Positioned(
            width: MediaQuery.of(context).size.width ,
            left: -8,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PaddingConstants.inputFieldRadius),
            color: getQuakeColor(mag),),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(PaddingConstants.inputFieldRadius),
                ),
                tileColor: Colors.transparent,
                title: Text(
                  place,
                  style: TextStyles.textStyle12.copyWith(color: softWhite),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Depth: ${depth.toStringAsFixed(2)} km",
                      style: TextStyles.textStyle12.copyWith(
                        color: softWhite,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}