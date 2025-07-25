import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/features/earthquake_core/news/pages/earthquakes_news_marker.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EarthquakesNewsMarker(
            lat: lat,
            lon: lon,
          )));
      },
      child: Card(
        color: getQuakeColor(mag),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ), // Rounded corners
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                // MAG
                child: Text(
                  mag.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 35,
                    color: softWhite,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //PLACE
                    Text(
                      place,
                      style: TextStyles.textStyle14.copyWith(
                        color: softWhite,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Depth: ${depth.toStringAsFixed(2)} km",
                      style: TextStyles.textStyle14.copyWith(
                        color: softWhite,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: softWhite),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: TextStyles.textStyle14.copyWith(
                            color: softWhite,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
