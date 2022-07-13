import 'package:demo_app/api/api.dart';
import 'package:demo_app/home/widget/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  final textEditingController = TextEditingController();
  final myFocusNode = FocusNode();
  var isFocus = true;
  var searchingWord = '';
  @override
  void initState() {
    myFocusNode.addListener(() {
      print("focus ${myFocusNode.hasFocus}");
      isFocus = myFocusNode.hasFocus;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  Future<Map<String, List>> searching(keyword) async {
    var movies = await MovieAPI.searchMovie(keyword);
    var posts = await NewsAPI.getPosts(keyword: keyword, limit: 10);

    print(posts.length);
    return {"movie": movies, "post": posts};
  }

  @override
  Widget build(BuildContext context) {
    print(isFocus);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          focusNode: myFocusNode,
          onSubmitted: (value) {
            searchingWord = value;

            setState(() {});
          },
          onChanged: (value) {
            setState(() {});
          },
          controller: textEditingController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "검색어를 입력해주세요",
          ),
        ),
        actions: [
          if (textEditingController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  textEditingController.clear();
                  setState(() {});
                },
                child: const Icon(
                  Icons.highlight_off,
                  color: Colors.grey,
                ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Builder(builder: (context) {
          if (isFocus || myFocusNode.hasFocus) {
            return Container();
          }
          return FutureBuilder(
              future: searching(searchingWord),
              builder: (context, AsyncSnapshot<Map<String, List>> snapshot) {
                if (snapshot.hasError) {
                  print("error");
                  return Container();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("wating");
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  print("no data");
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  print("done");
                  var data = snapshot.data;
                  return CustomScrollView(
                    slivers: [
                      // SliverAppBar(
                      //   forceElevated: true,
                      //   elevation: 1,
                      //   backgroundColor: Colors.white,
                      //   title: TextField(
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "검색어를 입력해주세요",
                      //         suffixIcon: GestureDetector(
                      //           onTap: () {},
                      //           child: Icon(
                      //             Icons.search,
                      //             color: Colors.black,
                      //           ),
                      //         )),
                      //   ),
                      // ),
                      if (data!['movie']!.isNotEmpty)
                        SliverToBoxAdapter(
                            child: SizedBox(
                          height: 300,
                          child: CardList(
                            scrollController: _scrollController,
                            data: data['movie'],
                          ),
                        )),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: data['post']!.length,
                              (context, index) {
                        return Card(
                          child: ListTile(
                            title: Html(data: data['post']![index]['title']),
                            subtitle:
                                Html(data: data['post']![index]['description']),
                          ),
                        );
                      }))
                    ],
                  );
                }
                return Container();
              });
        }),
      ),
    );
  }
}
