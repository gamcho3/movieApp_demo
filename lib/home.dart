import 'dart:convert';

import 'package:demo_app/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getPosts().then((value) {
      print(value);
    });
    super.initState();
  }

  Future<List> getMovie() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=a0e37bb376436cf45664b1fa59aa993d');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      Map result = jsonDecode(responseBody);
      return result['results'];
    }
    return [];
  }

  Future<List> getPosts() async {
    var url = Uri.parse(
        'https://openapi.naver.com/v1/search/blog?query=영화&display=5');
    var response = await http.get(url, headers: {
      'Content-Type': "plain/text",
      "X-Naver-Client-Id": "2TjUZlBOTa7Bta7BD0Ft",
      "X-Naver-Client-Secret": "_CaRv7Sh4M"
    });
    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      Map result = jsonDecode(responseBody);
      return result['items'];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            "환영합니다!",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: [
            CircleAvatar(
              backgroundColor: Colors.black,
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              child: FutureBuilder(
                  future: getMovie(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      // print(data);
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: ((context) {
                                          return DetailPage(
                                            index: index,
                                            data: data![index],
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${data[index]['poster_path']}',
                                          );
                                        })));
                                      },
                                      child: Hero(
                                        tag: 'image$index',
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${data![index]['poster_path']}'),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 2))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${data[index]['original_title']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text('평점 : '),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(' ${data[index]['vote_average']}')
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 20,
                            );
                          },
                          itemCount: data!.length);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
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
                    future: getPosts(),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;

                        return Column(
                          children: [
                            for (var i = 0; i < data!.length; i++)
                              Column(
                                children: [
                                  ListTile(
                                    title: Html(data: data[i]['title']),
                                    subtitle:
                                        Html(data: data[i]['description']),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  )
                                ],
                              ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
