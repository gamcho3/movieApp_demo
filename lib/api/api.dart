import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieAPI {
  static Future<List> getMovie() async {
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

  static Future<List> searchMovie(keyword) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=a0e37bb376436cf45664b1fa59aa993d&query=$keyword');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      Map result = jsonDecode(responseBody);
      return result['results'];
    }
    return [];
  }
}

class NewsAPI {
  static Future<List> getPosts({String? keyword, int? limit}) async {
    var word = keyword ?? '영화';
    var display = limit ?? 5;
    var url = Uri.parse(
        'https://openapi.naver.com/v1/search/blog?query=$word&display=$display');
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
}
