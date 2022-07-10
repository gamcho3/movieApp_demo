import 'package:demo_app/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageSlideView extends StatefulWidget {
  final List data;
  final int idx;
  const PageSlideView({Key? key, required this.data, required this.idx})
      : super(key: key);

  @override
  State<PageSlideView> createState() => _PageSlideViewState();
}

class _PageSlideViewState extends State<PageSlideView> {
  late int pageIndex;
  @override
  void initState() {
    pageIndex = widget.idx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, pageIndex);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: PageView.builder(
            onPageChanged: ((value) {
              pageIndex = value;
              setState(() {});
            }),
            itemCount: widget.data.length,
            controller: PageController(initialPage: pageIndex),
            itemBuilder: (context, index) {
              return DetailPage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${widget.data[pageIndex]['poster_path']}',
                  index: widget.idx,
                  data: widget.data[pageIndex]);
            }));
  }
}
