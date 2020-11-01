import 'dart:async';
import 'dart:convert';
import 'package:http_apirest/models/game.dart';
import 'package:http_apirest/services/common/rest_client_service.dart';

class GameService {

  RestClientService restClientService = RestClientService() ;
  final PATH = '/api/snb/livescore';

  Future<GameResponse> game(String gameId) async {
    var uri = '${PATH}/${gameId}' ;
    GenericResponse response = await restClientService.get(uri) ;
    return _gameResponseFromJson(response.statusCode, response.message, (response.statusCode==0) ? response.data : null);
  }

  GameResponse _gameResponseFromJson(int statusCode, String message, String json) {
    var gameResponse = new GameResponse();
    gameResponse.statusCode = statusCode;
    gameResponse.message = message;
    gameResponse.game = (json != null) ? Game.fromMap(jsonDecode(json)) : [];
    return gameResponse ;
  }

}