import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/earthquake_feature/cubit/quake_cubit.dart';
import 'package:resq_map/features/earthquake_feature/news/widgets/earthquakes_news_view.dart';

class EarthquakesNewsPage extends StatefulWidget {
  const EarthquakesNewsPage({super.key});

  @override
  State<EarthquakesNewsPage> createState() => _EarthquakesNewsPageState();
}

class _EarthquakesNewsPageState extends State<EarthquakesNewsPage> {
  Future<void> _refreshData() async {
    await BlocProvider.of<WebSocketCubit>(context).getQuakeNews();
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAppBar(
        actions: [
          Icon(Icons.public,size: 30,),
        ],
        title: "Latest Earthquakes",
        
      ),
      body: RefreshIndicator(
        color: appThemeColor,
        onRefresh: _refreshData,
        child: BlocBuilder<WebSocketCubit, WebSocketState>(
          builder: (context, state) {
            
            if (state is Loading) {
              return const Center(child: Text("Loading >>>"));
            } else if (state is GetNewsSuccess) {
              return EarthquakesNewsView(news: state.news);
            } else {
              
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Something Went Wrong!"),
                        
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


// Text(
//           "All Quakes News in One Place – Stay Informed, Worldwide!",
//           style: TextStyles.textStyle12.copyWith(color: softWhite),)