import 'package:demo_app/api/api.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  Future<bool> searching(keyword) async {
    var movies = await MovieAPI.searchMovie(keyword);
    var posts = await NewsAPI.getPosts(keyword: keyword, limit: 10);
    print(movies);
    print(posts);
    return true;
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
      body: Builder(builder: (context) {
        if (isFocus || myFocusNode.hasFocus) {
          return Container();
        }
        return FutureBuilder(
            future: searching(searchingWord),
            builder: (context, snapshot) {
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
                    SliverToBoxAdapter(),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(childCount: 5,
                            (context, index) {
                      return ListTile(
                        title: Text("dd"),
                      );
                    }))
                  ],
                );
              }
              return Container();
            });
      }),
    );
  }
}
