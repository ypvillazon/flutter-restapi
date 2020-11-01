import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_apirest/models/game.dart';
import 'package:http_apirest/services/game_service.dart';
import 'package:http_apirest/ui/widgets/message.dart';

class GameCardWidget extends StatefulWidget {
  final Game game;

  GameCardWidget({Key key, this.game}) : super(key: key);

  @override
  _GameCardState createState() => new _GameCardState();
}

class _GameCardState extends State<GameCardWidget> {

  double _width;
  bool loading=false;

  Game game ;

  GameService gameService = new GameService() ;

  @override
  void initState() {
    game = widget.game ;
    loading=false;
  }

  void _fetchGame() {
    setState(() {
      loading=true;
    });
    gameService.game(game.id).then((value) {
      if (value.statusCode == 0) {
        setState(() {
          game = value.game ;
          loading = false ;
        });
      } else {
        MessageWidget.error(context, "Ha ocurrido un error. Detalles: " + value.message, 4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Card(
        key: UniqueKey(),
        color: Colors.white,
        child: Column(
            children: [

              new Container(
                height: 30,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.update, color: Colors.grey,size: 16,),
                      Text(" " + game.date + "   ", style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic))
                    ]
                ),
              ),

              new Container(
                width: _width,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(game.status.toUpperCase(), style: TextStyle(fontSize: 16, color: ((game.status=="final") ? Colors.red : Colors.indigo), fontWeight: FontWeight.bold),)
                        ]
                      ),
                      width: _width/2
                    )
                    ,
                    new Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(((game.outs != "") ? game.outs : "            "), style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                            Text("   "),
                            IconButton(
                              icon: Icon(Icons.refresh, size: 28, color: Colors.redAccent),
                              onPressed: _fetchGame
                            )
                          ]
                        )
                    )
                  ],
                ),
              ),


              new Container(
                padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset('assets/images/' + game.team1Sigles + '.png', width: 40,height: 40),
                                Text("  " + game.team1Sigles),
                                Text(" ("+game.team1Name+")", style: TextStyle(color: Colors.grey, fontSize: 12),)
                              ]
                          ),
                          width: _width/2+_width/4
                      ),
                      new Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                (loading) ? Icon(Icons.info_outline, size: 18, color: Colors.blue,) : Text(game.team1Runs.toString(), style: TextStyle(fontSize: 18, fontWeight: ((game.team2Runs<game.team1Runs) ? FontWeight.bold : FontWeight.normal)))
                              ]
                          )
                      )
                    ],
                  )
              ),


              new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset('assets/images/' + game.team2Sigles + '.png', width: 40,height: 40),
                                Text("  " + game.team2Sigles),
                                Text(" ("+game.team2Name+")", style: TextStyle(color: Colors.grey, fontSize: 12),)
                              ]
                          ),
                          width: _width/2+_width/4
                      ),
                      new Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                (loading) ? Icon(Icons.info_outline, size: 18, color: Colors.blue,) : Text(game.team2Runs.toString(), style: TextStyle(fontSize: 18, fontWeight: ((game.team1Runs<game.team2Runs) ? FontWeight.bold : FontWeight.normal)))
                              ]
                          )
                      )
                    ],
                  )
              ),
            ])
    );
  }


}