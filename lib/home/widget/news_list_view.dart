import 'dart:convert';

import 'package:demo_app/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 0))
        ],
      ),
      child: FutureBuilder(
          future: NewsAPI.getPosts(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  for (var i = 0; i < data!.length; i++)
                    Column(
                      children: [
                        ListTile(
                          title: Html(data: data[i]['title']),
                          subtitle: Html(data: data[i]['description']),
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    ),
                ],
              );
            } else {
              return shimmerContainer();
            }
          }),
    );
  }

  Column shimmerContainer() {
    return Column(
      children: [
        for (var i = 0; i < 5; i++)
          Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: true,
                child: ListTile(
                  title: Container(
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.withOpacity(0.5)),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                        ),
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              )
            ],
          ),
      ],
    );
  }
}
