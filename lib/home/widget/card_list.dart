import 'package:flutter/material.dart';

import '../../page_view.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key, required this.scrollController, required this.data})
      : super(key: key);
  final ScrollController scrollController;
  final List? data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: scrollController,
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
                        scrollController
                            .jumpTo(double.parse((value * 220).toString()));
                      });
                    },
                    child: Hero(
                      tag: 'image$index',
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                'https://image.tmdb.org/t/p/w500${data![index]['poster_path'] ?? '.jpg'}',
                                errorBuilder: (context, error, stackTrace) {
                                  return const Text("이미지가 없습니다.");
                                },
                              ).image),
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
                  '${data![index]['original_title']}',
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
                    Text(' ${data![index]['vote_average']}')
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
  }
}
