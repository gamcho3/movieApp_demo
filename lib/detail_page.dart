import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailPage extends StatelessWidget {
  final Map data;
  final String imageUrl;
  final int index;
  const DetailPage(
      {Key? key,
      required this.imageUrl,
      required this.index,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Hero(
          tag: 'image$index',
          child: SizedBox(
              width: double.infinity,
              height: 400,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              )),
        ),
        Container(
          height: 70,
          color: Colors.black.withOpacity(0.9),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Explain(
                  title: "평점",
                  subTitle: data['vote_average'].toString(),
                ),
                Explain(
                  title: "개봉일",
                  subTitle: data['release_date'],
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data['overview'],
            style: TextStyle(fontSize: 20),
          ),
        )
      ]),
    );
  }
}

class Explain extends StatelessWidget {
  final String title;
  final String subTitle;
  const Explain({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        Text(subTitle, style: TextStyle(color: Colors.white))
      ],
    );
  }
}
