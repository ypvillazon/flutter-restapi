import 'dart:async';
import 'dart:convert';
import 'package:http_apirest/models/game.dart';
import 'package:http_apirest/services/common/rest_client_service.dart';

class GamesService {

  RestClientService restClientService = RestClientService() ;
  final PATH = '/api/snb/livescore';

  Future<GamesResponse> games() async {
    var uri = '${PATH}?dateId=' ;
    GenericResponse response = await restClientService.get(uri) ;
    return _gamesResponseFromJson(response.statusCode, response.message, (response.statusCode==0) ? response.data : null);
  }

  GamesResponse _gamesResponseFromJson(int statusCode, String message, String json) {
    var gamesResponse = new GamesResponse();
    gamesResponse.statusCode = statusCode;
    gamesResponse.message = message;
    gamesResponse.games = (json != null) ? (jsonDecode(json) as List).map((game) => Game.fromMap(game)).toList() : [];
    return gamesResponse ;
  }

}