import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:math' as math;

enum PlayerNumber {
  player1,
  player2,
  ai,
  none,
}

class Player {
  String name = '';
  bool piece = false;
  PlayerNumber number = PlayerNumber.none;

  Player({
    required this.name,
    required this.piece,
    required this.number,
  });
}

class GameProvider extends ChangeNotifier {
  List<Player> players = [];
  Player currentPlayer =
      Player(name: '', piece: false, number: PlayerNumber.none);
  String _winnerName = '';
  Map<int, bool> board = {};
  Map<int, bool> aiBoard = {};
  int winState = 0; //1 is no win, 2 is win, and 3 is tie
  int difficulty = 0; //ai difficulty level
  bool here =
      false; //controls a silly variable needed to prevent errors. No better place for it.

  String get name {
    return currentPlayer.name;
  }

  bool get piece {
    return currentPlayer.piece;
  }

  String get winnerName {
    return _winnerName;
  }

  Player get currentP {
    return currentPlayer;
  }

  void playerSet(Player p) {
    currentPlayer = p;
  }

  void difficultySet(int d) {
    difficulty = d;
  }

  void addPlayer(bool piece, String player, PlayerNumber num) {
    //adds a player to the list
    if (player == '') {}
    Player p = Player(name: player, piece: piece, number: num);

    players.add(p);
  }

  void switchTurns(bool turn) {
    //if player one, switch name to player two
    //if player two, switch name to player one

    Player p = players.firstWhere((element) => element.piece == turn);

    currentPlayer = p;
    log(p.name);
    notifyListeners();
  }

  void swapTurns() {
    List<Player> newOrder = [];
    newOrder[0] = players[1];
    newOrder[1] = players[0];

    players = newOrder;
  }

  void placePieces(bool piece, int location) {
    board.addEntries([MapEntry(location, piece)]);
  }

  void boardCheck(bool p) {
    //gonna check previous round for a win so p wil always be !piece.
    Player player = players.firstWhere((element) => element.piece == p);
    if (board.isNotEmpty && board.length >= 3) {
      if (board[0] == p && board[1] == p && board[2] == p) {
        //first row win
        _winnerName = player.name;
        winState = 2;
      } else if (board[0] == p && board[3] == p && board[6] == p) {
        //first column win
        _winnerName = player.name;
        winState = 2;
      } else if (board[0] == p && board[4] == p && board[8] == p) {
        //diag 1 win
        _winnerName = player.name;
        winState = 2;
      } else if (board[3] == p && board[4] == p && board[5] == p) {
        //second row win
        _winnerName = player.name;
        winState = 2;
      } else if (board[6] == p && board[7] == p && board[8] == p) {
        //third row win
        _winnerName = player.name;
        winState = 2;
      } else if (board[1] == p && board[4] == p && board[7] == p) {
        //second column win
        _winnerName = player.name;
        winState = 2;
      } else if (board[2] == p && board[5] == p && board[8] == p) {
        //third column win
        _winnerName = player.name;
        winState = 2;
      } else if (board[2] == p && board[4] == p && board[6] == p) {
        //second diag win
        _winnerName = player.name;
        winState = 2;
      } else if (board.length == 9) {
        winState = 3;
      }
    } else {
      winState = 1;
    }
  }

  bool aiWinCheck(bool p, int i) {
    if (aiBoard.isNotEmpty && aiBoard.length >= 3) {
      aiBoard.addEntries([MapEntry(i, p)]);
      if (aiBoard[0] == p && aiBoard[1] == p && aiBoard[2] == p) {
        //first row win
        return true;
      }
      if (aiBoard[0] == p && aiBoard[3] == p && aiBoard[6] == p) {
        //first column win
        return true;
      }
      if (aiBoard[0] == p && aiBoard[4] == p && aiBoard[8] == p) {
        //diag 1 win
        return true;
      }
      if (aiBoard[3] == p && aiBoard[4] == p && aiBoard[5] == p) {
        //second row win
        return true;
      }
      if (aiBoard[6] == p && aiBoard[7] == p && aiBoard[8] == p) {
        //third row win
        return true;
      }
      if (aiBoard[1] == p && aiBoard[4] == p && aiBoard[7] == p) {
        //second column win
        return true;
      }
      if (aiBoard[2] == p && aiBoard[5] == p && aiBoard[8] == p) {
        //third column win
        return true;
      }
      if (aiBoard[2] == p && aiBoard[4] == p && aiBoard[6] == p) {
        //second diag win
        return true;
      }
      aiBoard.remove(i); //gets rid of piece if no win condition
      return false;
    }
    return false;
  }

  int aiBlockCheck(bool p) {
    //it's huge but it doesn't have errors
    if (aiBoard.isNotEmpty && aiBoard.length >= 3) {
      if (aiBoard[0] == p && aiBoard[1] == p && !spaceCheck(2)) {
        //player potentially wins row 1
        return 2;
      }
      if (aiBoard[0] == p && aiBoard[2] == p && !spaceCheck(1)) {
        return 1;
      }
      if (aiBoard[1] == p && aiBoard[2] == p && !spaceCheck(0)) {
        return 0;
      }
      if (aiBoard[0] == p && aiBoard[3] == p && !spaceCheck(6)) {
        //player potentially wins column 1
        return 6;
      }
      if (aiBoard[0] == p && aiBoard[6] == p && !spaceCheck(3)) {
        return 3;
      }
      if (aiBoard[3] == p && aiBoard[6] == p && !spaceCheck(0)) {
        return 0;
      }
      if (aiBoard[0] == p && aiBoard[4] == p && !spaceCheck(8)) {
        //player potentially wins diag 1
        return 8;
      }
      if (aiBoard[0] == p && aiBoard[8] == p && !spaceCheck(4)) {
        return 4;
      }
      if (aiBoard[4] == p && aiBoard[8] == p && !spaceCheck(0)) {
        return 0;
      }
      if (aiBoard[3] == p && aiBoard[4] == p && !spaceCheck(5)) {
        //player potentially wins row 2
        return 5;
      }
      if (aiBoard[3] == p && aiBoard[5] == p) {
        if (!spaceCheck(4)) {
          return 4;
        }
      }
      if (aiBoard[4] == p && aiBoard[5] == p && !spaceCheck(3)) {
        return 3;
      }

      if (aiBoard[6] == p && aiBoard[7] == p && !spaceCheck(8)) {
        //player potentially wins row 3
        return 8;
      }
      if (aiBoard[6] == p && aiBoard[8] == p && !spaceCheck(7)) {
        return 7;
      }
      if (aiBoard[7] == p && aiBoard[8] == p && !spaceCheck(6)) {
        return 6;
      }

      if (aiBoard[1] == p && aiBoard[4] == p && !spaceCheck(7)) {
        //player potentially wins column 2
        return 7;
      }
      if (aiBoard[1] == p && aiBoard[7] == p && !spaceCheck(4)) {
        return 4;
      }
      if (aiBoard[4] == p && aiBoard[7] == p && !spaceCheck(1)) {
        return 1;
      }

      if (aiBoard[2] == p && aiBoard[5] == p && !spaceCheck(8)) {
        //player potentially wins column 3
        return 8;
      }
      if (aiBoard[2] == p && aiBoard[8] == p && !spaceCheck(5)) {
        return 5;
      }
      if (aiBoard[5] == p && aiBoard[8] == p && !spaceCheck(2)) {
        return 2;
      }
      if (aiBoard[2] == p && aiBoard[4] == p && !spaceCheck(6)) {
        //player potentially wins diag 2
        return 6;
      }
      if (aiBoard[2] == p && aiBoard[6] == p && !spaceCheck(4)) {
        return 4;
      }
      if (aiBoard[4] == p && aiBoard[6] == p && !spaceCheck(2)) {
        return 2;
      }
    }
    return -1;
  }

  bool spaceCheck(int i) {
    if (board[i] != null) {
      return true;
    }
    return false;
  }

  bool pieceCheck(int i) {
    if (spaceCheck(i) && board[i] == true) {
      return true;
    }
    return false;
  }

  int aiTurn(bool p) {
    if (difficulty == 0) {
      if (!spaceCheck(4)) {
        log('picked center');
        return 4;
      } else if (spaceCheck(4)) {
        board.forEach((key, value) {
          if (!aiBoard.containsKey(key)) {
            aiBoard.addEntries([MapEntry(key, value)]);
            log('${aiBoard[key]}');
          }
        }); //make or update the aiBoard
        log('finished board');
        log('checking for wins');
        for (int i = 0; i <= 8; i++) {
          log('${aiBoard[i]}');
          if (!spaceCheck(i) && aiWinCheck(p, i)) {
            return i;
          }
        }
        log('checking for blocks');
        if (aiBlockCheck(!p) != -1) {
          return aiBlockCheck(!p);
        }

        for (int i = 0; i <= 8; i++) {
          if (!spaceCheck(i)) {
            log('randomly picked $i');
            return i;
          }
        }
      }
    }
    if (difficulty == 1) {
      if (!spaceCheck(4)) {
        log('picked center');
        return 4;
      } else if (spaceCheck(4)) {
        board.forEach((key, value) {
          if (!aiBoard.containsKey(key)) {
            aiBoard.addEntries([MapEntry(key, value)]);
            log('${aiBoard[key]}');
          }
        }); //make or update the aiBoard
        log('finished board');
        log('checking for wins');
        for (int i = 0; i <= 8; i++) {
          log('${aiBoard[i]}');
          if (!spaceCheck(i) && aiWinCheck(p, i)) {
            return i;
          }
        }
        for (int i = 0; i <= 8; i++) {
          if (!spaceCheck(i)) {
            log('randomly picked $i');

            return i;
          }
        }
      }
    }
    if (difficulty == 2) {
      int total = 9;
      board.forEach((key, value) {
        total--; //remove the taken spaces from random options.
      });

      math.Random random = math.Random();
      int piece =
          random.nextInt(total) + 1; //pick a random number for the piece

      for (int i = 0; i <= 8; i++) {
        if (!spaceCheck(i)) //if space not taken
        {
          piece--; //remove one square from piece
          if (piece == 0) //if we've hit the right amount of squares...
          {
            return i; //return the piece!
          }
        }
      }
    }
    log('oops');
    return -1;
  }

  void resetBoard() {
    board.clear();
    aiBoard.clear();
    switchTurns(false);
    here = false;
    notifyListeners();
  }

  void emptyBoard() {
    //clears out board when game is done
    board.clear();
    aiBoard.clear();
    players.clear();
    here = false;
    notifyListeners();
  }
}
