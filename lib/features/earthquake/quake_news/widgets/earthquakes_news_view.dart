import 'package:flutter/material.dart';
import 'package:resq_map/features/earthquake/quake_news/model/news.dart';

import 'package:resq_map/features/earthquake/quake_news/widgets/quake_news_item.dart';

class EarthquakesNewsView extends StatefulWidget {
  const EarthquakesNewsView({super.key, required this.news});
  final List<News> news;

  @override
  State<EarthquakesNewsView> createState() => _EarthquakesNewsViewState();
}

class _EarthquakesNewsViewState extends State<EarthquakesNewsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
       shrinkWrap: true,
      itemCount: widget.news.length,
      itemBuilder:
          (context, index) => QuakeNewsItem(
            lat: widget.news[index].lat,
            lon: widget.news[index].lon,
            depth: widget.news[index].depth,
            mag: widget.news[index].mag,
            place: widget.news[index].place,
            time: widget.news[index].time,
          ),
    );
  }
}
