import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;

// 1st player is O
  List<String> f = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int occupied = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'PLAYER X',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('PLAYER O',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(
                          oScore.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _touch(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          f[index],
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.pink,
                  textColor: Colors.black,
                  onPressed: _clearScoreBoard,
                  child: Text("RESTART"),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  void _touch(int index) {
    setState(() {
      if (oTurn && f[index] == '') {
        f[index] = 'O';
        occupied++;
      } else if (!oTurn && f[index] == '') {
        f[index] = 'X';
        occupied++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (f[0] == f[1] && f[0] == f[2] && f[0] != '') {
      _winnerBox(f[0]);
    }
    if (f[3] == f[4] && f[3] == f[5] && f[3] != '') {
      _winnerBox(f[3]);
    }
    if (f[6] == f[7] && f[6] == f[8] && f[6] != '') {
      _winnerBox(f[6]);
    }

    if (f[0] == f[3] && f[0] == f[6] && f[0] != '') {
      _winnerBox(f[0]);
    }
    if (f[1] == f[4] && f[1] == f[7] && f[1] != '') {
      _winnerBox(f[1]);
    }
    if (f[2] == f[5] && f[2] == f[8] && f[2] != '') {
      _winnerBox(f[2]);
    }

    if (f[0] == f[4] && f[0] == f[8] && f[0] != '') {
      _winnerBox(f[0]);
    }
    if (f[2] == f[4] && f[2] == f[6] && f[2] != '') {
      _winnerBox(f[2]);
    } else if (occupied == 9) {
      _drawBox();
    }
  }

  void _winnerBox(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" is Winner!!!"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _drawBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FlatButton(
                child: Text("PLAY AGAIN"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        f[i] = '';
      }
    });

    occupied = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        f[i] = '';
      }
    });
    occupied = 0;
  }
}
