import 'package:demo_app/api/api.dart';
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
              return ListView.separated(
                  controller: _scrollController,
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
                                    MaterialPageRoute(builder: ((context) {
                                  return PageSlideView(
                                    data: data!,
                                    idx: index,
                                  );
                                }))).then((value) {
                                  _scrollController.jumpTo(
                                      double.parse((value * 220).toString()));
                                });
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
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
    );
  }
}
