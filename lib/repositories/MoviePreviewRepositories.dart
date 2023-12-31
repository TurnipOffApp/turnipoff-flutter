import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turnipoff/constants/network_constants.dart';

import '../models/MoviePreviewData.dart';

abstract class MoviePreviewRepository {
  Future<MoviePreviewData> getCustomTrends();

  Future<MoviePreviewData> getActionPreview(int page);

  Future<MoviePreviewData> getComedyPreview(int page);

  Future<MoviePreviewData> getEightysPreview(int page);

  Future<MoviePreviewData> getNineteensPreview(int page);
}

class MoviePreviewRepositoryImpl extends MoviePreviewRepository {

  static const base = NetworkConstants.BASE_URL +
      NetworkConstants.MOVIE_PREVIEW_PATH +
      NetworkConstants.API_KEY_PARAM +
      NetworkConstants.API_KEY_VALUE +
      NetworkConstants.REGION_FR +
      NetworkConstants.LANGUAGE_FR +
      NetworkConstants.ADULT_FALSE +
      NetworkConstants.AND_VOTE_COUNT;

  @override
  Future<MoviePreviewData> getCustomTrends() async {
    var url = Uri.parse(base + NetworkConstants.AND_LOWEST_FIRST);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getActionPreview(int page) async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_ACTION_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_PAGE +
        page.toString());
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getComedyPreview(int page) async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_COMEDY_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_PAGE +
        page.toString());
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getEightysPreview(int page) async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_EIGHTYS_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_PAGE +
        page.toString());
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getNineteensPreview(int page) async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_NINETEENS_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_PAGE +
        page.toString());
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }
}
