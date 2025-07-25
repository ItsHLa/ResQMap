import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/features/earthquake_core/cubit/quake_cubit.dart';
import 'package:resq_map/features/earthquake_core/news/widgets/earthquakes_news_view.dart';

class EarthquakesNewsPage extends StatefulWidget {
  const EarthquakesNewsPage({super.key});

  @override
  State<EarthquakesNewsPage> createState() => _EarthquakesNewsPageState();
}

class _EarthquakesNewsPageState extends State<EarthquakesNewsPage> {
  @override
  void initState() {
    BlocProvider.of<WebSocketCubit>(context).getQuakeNews();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest Earthquakes", style: TextStyle(color: softWhite)),
      ),
      body: BlocBuilder<WebSocketCubit, WebSocketState>(
        builder: (context, state) =>    
           state is GetNewsSuccess ? EarthquakesNewsView(
            news: state.news,
          ) : state is Loading ? Center(child: CircularProgressIndicator(),) : Center(child: Text("SomeThing Went Wrong"),)
        ,
      ),
    );
  }
}
