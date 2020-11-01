class Game {
  String id;
  String status ;
  String outs;
  String team1Sigles;
  String team1Name;
  int team1Runs;
  String team2Sigles;
  String team2Name;
  int team2Runs;
  String date ;

  Game({this.id, this.status,this.outs, this.team1Sigles, this.team1Name, this.team1Runs, this.team2Sigles, this.team2Name, this.team2Runs, this.date});

  Game.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    status = map['status'];
    outs = map['outs'];
    team1Sigles = map['team1Sigles'];
    team1Name = map['team1Name'];
    team1Runs = map['team1Runs'];
    team2Sigles = map['team2Sigles'];
    team2Name = map['team2Name'];
    team2Runs = map['team2Runs'];
    var s = DateTime.parse(map['updatedAt']).toLocal() ;
    date = "${s.year}/${s.month}/${s.day} ${s.hour}:${s.minute}:${s.second}" ;
  }

}

class GamesResponse {
  int statusCode;
  String message ;
  List<Game> games ;

  GamesResponse({
    this.statusCode,
    this.message,
    this.games,
  });
}

class GameResponse {
  int statusCode;
  String message ;
  Game game ;

  GameResponse({
    this.statusCode,
    this.message,
    this.game,
  });
}
