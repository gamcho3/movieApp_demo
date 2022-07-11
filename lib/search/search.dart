import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            elevation: 1,
            backgroundColor: Colors.white,
            title: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "검색어를 입력해주세요",
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 5,
                  (context, index) => ListTile(
                        title: Text("dd"),
                      )))
        ],
      ),
    );
  }
}
