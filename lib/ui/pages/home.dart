import 'package:flutter/material.dart';
import 'package:http_apirest/models/game.dart';
import 'package:http_apirest/services/games_service.dart';
import 'package:http_apirest/ui/pages/game.dart';
import 'package:http_apirest/ui/widgets/message.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage> {

  GamesService gamesService = GamesService();
  List<Game> games = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._fetchGames() ;
    super.initState();
  }

  void _fetchGames() {
    gamesService.games().then((value) {
      if (value.statusCode == 0) {
        setState(() {
          games = value.games ;
        });
      } else {
        MessageWidget.error(context, "Ha ocurrido un error. Detalles: " + value.message, 4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Juegos en Directo"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh, size: 28), onPressed: () => {
                setState(() {
                  games = [];
                }),
                _fetchGames()
            })
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child:
                    (games.length == 0)
                        ?
                    Center(child: CircularProgressIndicator())
                        :
                    ListView.builder(
                        itemCount: games.length,
                        padding: const EdgeInsets.all(4.0),
                        itemBuilder: (context, index) {
                          return GameCardWidget(game: games[index],) ;
                        }
                    )
                )


              ],
            )
        )
    );
  }

}