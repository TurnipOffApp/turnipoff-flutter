import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turnipoff/constants/network_constants.dart';

import '../models/MoviePreviewData.dart';

abstract class MoviePreviewRepository {
  Future<MoviePreviewData> getActionPreview();

  Future<MoviePreviewData> getComedyPreview();

  Future<MoviePreviewData> getEightysPreview();

  Future<MoviePreviewData> getNineteensPreview();
}

class MoviePreviewRepositoryImpl extends MoviePreviewRepository {
  static const base = NetworkConstants.BASE_URL +
      NetworkConstants.MOVIE_PREVIEW_PATH +
      NetworkConstants.API_KEY_PARAM +
      NetworkConstants.API_KEY_VALUE +
      NetworkConstants.REGION_FR +
      NetworkConstants.LANGUAGE_FR +
      NetworkConstants.ADULT_FALSE;

  @override
  Future<MoviePreviewData> getActionPreview() async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_ACTION_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_AVERAGE_ONE +
        NetworkConstants.AND_PAGE_ONE);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getComedyPreview() async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_COMEDY_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_AVERAGE_ONE +
        NetworkConstants.AND_PAGE_ONE);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getEightysPreview() async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_EIGHTYS_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_AVERAGE_ONE +
        NetworkConstants.AND_PAGE_ONE);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }

  @override
  Future<MoviePreviewData> getNineteensPreview() async {
    var url = Uri.parse(base +
        NetworkConstants.PREVIEW_NINETEENS_QUERY +
        NetworkConstants.AND_LOWEST_FIRST +
        NetworkConstants.AND_AVERAGE_ONE +
        NetworkConstants.AND_PAGE_ONE);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePreviewData.fromJson(jsonResponse);
  }
}
