import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/network_constants.dart';
import '../models/ActorData.dart';

abstract class ActorRepository {
  Future<ActorData> getActor(String id);
}

class ActorRepositoryImpl extends ActorRepository {
  @override
  Future<ActorData> getActor(String id) async {
    var url = Uri.parse(NetworkConstants.BASE_URL +
        NetworkConstants.ACTOR_PATH +
        id +
        NetworkConstants.API_KEY_PARAM +
        NetworkConstants.API_KEY_VALUE);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return ActorData.fromJson(jsonResponse);
  }
}
