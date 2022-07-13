import 'package:demo_app/api/api.dart';
import 'package:demo_app/home/widget/card_list.dart';
import 'package:flutter/material.dart';

import '../../page_view.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 300,
      child: FutureBuilder(
          future: MovieAPI.getMovie(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              // print(data);
              return CardList(scrollController: _scrollController, data: data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
