import 'dart:convert';

import 'package:demo_app/detail_page.dart';
import 'package:demo_app/home/widget/card_list_view.dart';
import 'package:demo_app/home/widget/news_list_view.dart';
import 'package:demo_app/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      // print('offset = ${_scrollController.offset}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            "환영합니다!",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                )),
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            MovieList(),
            SizedBox(
              height: 20,
            ),
            Flexible(fit: FlexFit.loose, child: NewsList())
          ],
        ),
      ),
    );
  }
}
