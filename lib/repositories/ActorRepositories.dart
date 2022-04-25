import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:turnipoff/models/CreditsData.dart';

import '../constants/network_constants.dart';
import '../models/ActorData.dart';

abstract class ActorRepository {
  Future<ActorData> getActor(String id);
  Future<CreditsData> getActorCredits(String id);
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

  @override
  Future<CreditsData> getActorCredits(String id) async {
    var url = Uri.parse(NetworkConstants.BASE_URL +
        NetworkConstants.ACTOR_PATH +
        id +
        NetworkConstants.ACTOR_CREDITS_PATH +
        NetworkConstants.API_KEY_PARAM +
        NetworkConstants.API_KEY_VALUE);
    var response = await http.get(url);

    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return CreditsData.fromJson(jsonResponse);
  }
}
