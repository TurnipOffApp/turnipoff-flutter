import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turnipoff/constants/network_constants.dart';

import '../models/MovieCreditsData.dart';
import '../models/MovieData.dart';

abstract class MovieRepository {
  Future<MovieData> getMovie(String id);

  Future<MovieCreditsData> getMovieCredits(String id);
}

class MovieRepositoryImpl extends MovieRepository {
  static const API_AND_LANG = NetworkConstants.API_KEY_PARAM +
      NetworkConstants.API_KEY_VALUE +
      NetworkConstants.REGION_FR +
      NetworkConstants.LANGUAGE_FR +
      NetworkConstants.ADULT_FALSE;

  @override
  Future<MovieData> getMovie(String id) async {
    var url = Uri.parse(NetworkConstants.BASE_URL +
        NetworkConstants.MOVIE_PATH +
        id +
        API_AND_LANG);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MovieData.fromJson(jsonResponse);
  }

  @override
  Future<MovieCreditsData> getMovieCredits(String id) async {
    var url = Uri.parse(NetworkConstants.BASE_URL +
        NetworkConstants.MOVIE_PATH +
        id +
        NetworkConstants.MOVIE_CREDITS_PATH +
        API_AND_LANG);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MovieCreditsData.fromJson(jsonResponse);
  }
}
