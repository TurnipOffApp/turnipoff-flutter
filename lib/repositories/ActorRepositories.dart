import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/ActorData.dart';

abstract class ActorRepository {
  Future<ActorData> getActor(String id);
}

class ActorRepositoryImpl extends ActorRepository {
  @override
  Future<ActorData> getActor(String id) {
    // TODO: implement getActor
    throw UnimplementedError();
  }
/*
  
  @override
  Future<ActorData> getActor(String id) async {
    var url = Uri.parse(baseUrl + id);
    var response = await http.get(url);
    
    var jsonResponse = jsonDecode(response) as Map<String, dynamic>;
    return ActorData.fromJson(jsonResponse);
  }

   */

}