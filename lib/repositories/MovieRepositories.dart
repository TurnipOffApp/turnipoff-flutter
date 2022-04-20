import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turnipoff/constants/network_constants.dart';

import '../models/MovieData.dart';

abstract class MovieRepository {
  Future<MovieData> getMovie(String id);
}

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<MovieData> getMovie(String id) async {
    var url = Uri.parse(NetworkConstants.BASE_URL +
        NetworkConstants.MOVIE_PATH +
        id +
        NetworkConstants.API_KEY_PARAM +
        NetworkConstants.API_KEY_VALUE );
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MovieData.fromJson(jsonResponse);
  }

}
