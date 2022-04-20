import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turnipoff/constants/network_constants.dart';

import '../models/TrendsData.dart';

abstract class TrendsRepository {
  Future<TrendsData> getTrends();
}

class TrendsRepositoryImpl extends TrendsRepository {
  @override
  Future<TrendsData> getTrends() async {
    var url = Uri.parse(
        NetworkConstants.BASE_URL
            + NetworkConstants.TRENDS_MOVIE_WEEK_PATH
            + NetworkConstants.API_KEY_PARAM
            + NetworkConstants.API_KEY_VALUE);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return TrendsData.fromJson(jsonResponse);
  }
}
