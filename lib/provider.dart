import 'package:flutter/material.dart';
import 'dart:developer';

class GameProvider extends ChangeNotifier {
  final Map<bool, String> _player = {};
  String _name = '';
  String _winnerName = '';
  bool _piece = false;
  Map<int, bool> board = {};
  bool _ai = false; //is the AI on?
  bool _turn = false; // is it the AI's turn?
  Map<int, bool> aiBoard = {};

  String get name {
    return _name;
  }

  Map<bool, String> get player {
    return _player;
  }

  bool get piece {
    _piece = _player.keys.firstWhere((element) => _player[element] == _name);
    return _piece;
  }

  String get winnerName {
    return _winnerName;
  }

  bool get ai {
    return _ai;
  }

  bool get turn {
    return _turn;
  }

  void aiOn() {
    _ai = true;
  }

  void turnOn() {
    _turn = true;
  }

  void addPlayer(bool piece, String player) {
    //adds a player to the map
    _player[piece] = player;
    notifyListeners();
  }

  void switchTurns(bool turn) {
    //if player one, switch name to player two
    //if player two, switch name to player one
    if (_player.containsKey(turn)) {
      _name = _player[turn]!;
      log(_name);
    }
    if (_ai && _name == 'Computer') {
      turnOn();
    }
    notifyListeners();
  }

  void placePieces(bool piece, int location) {
    board.addEntries([MapEntry(location, piece)]);
  }

  int boardCheck(bool p) {
    //gonna check previous round for a win so p wil always be !piece.
    if (board.isNotEmpty && board.length >= 3) {
      if (board[0] == p && board[1] == p && board[2] == p) {
        //first row win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[0] == p && board[3] == p && board[6] == p) {
        //first column win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[0] == p && board[4] == p && board[8] == p) {
        //diag 1 win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[3] == p && board[4] == p && board[5] == p) {
        //second row win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[6] == p && board[7] == p && board[8] == p) {
        //third row win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[1] == p && board[4] == p && board[7] == p) {
        //second column win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[2] == p && board[5] == p && board[8] == p) {
        //third column win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board[2] == p && board[4] == p && board[6] == p) {
        //second diag win
        _winnerName = _player[p]!;
        return 2;
      }
      if (board.length == 9) {
        return 3;
      }
      return 1;
    }
    return 1;
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
      if ((aiBoard[0] == p && aiBoard[1] == p)) {
        //player potentially wins row 1
        if (!spaceCheck(0)) {
          return 0;
        }
      }
      if ((aiBoard[0] == p && aiBoard[2] == p)) {
        if (!spaceCheck(1)) {
          return 1;
        }
      }
      if ((aiBoard[1] == p && aiBoard[2] == p)) {
        if (!spaceCheck(2)) {
          return 2;
        }
      }
      if ((aiBoard[0] == p && aiBoard[3] == p)) {
        //player potentially wins column 1
        if (!spaceCheck(6)) {
          return 6;
        }
      }
      if ((aiBoard[0] == p && aiBoard[6] == p)) {
        if (!spaceCheck(3)) {
          return 3;
        }
      }
      if ((aiBoard[3] == p && aiBoard[6] == p)) {
        if (!spaceCheck(0)) {
          return 0;
        }
      }

      if ((aiBoard[0] == p && aiBoard[4] == p)) {
        //player potentially wins diag 1
        if (!spaceCheck(8)) {
          return 8;
        }
      }
      if (aiBoard[0] == p && aiBoard[8] == p) {
        if (!spaceCheck(4)) {
          return 4;
        }
      }
      if (aiBoard[4] == p && aiBoard[8] == p) {
        if (!spaceCheck(0)) {
          return 0;
        }
      }

      if ((aiBoard[3] == p && aiBoard[4] == p)) {
        //player potentially wins row 2
        if (!spaceCheck(5)) {
          return 5;
        }
      }
      if (aiBoard[3] == p && aiBoard[5] == p) {
        if (!spaceCheck(4)) {
          return 4;
        }
      }
      if (aiBoard[4] == p && aiBoard[5] == p) {
        if (!spaceCheck(3)) {
          return 3;
        }
      }

      if ((aiBoard[6] == p && aiBoard[7] == p)) {
        //player potentially wins row 3
        if (!spaceCheck(8)) {
          return 8;
        }
      }
      if ((aiBoard[6] == p && aiBoard[8] == p)) {
        if (!spaceCheck(7)) {
          return 7;
        }
      }
      if ((aiBoard[7] == p && aiBoard[8] == p)) {
        if (!spaceCheck(6)) {
          return 6;
        }
      }

      if ((aiBoard[1] == p && aiBoard[4] == p)) {
        //player potentially wins column 2
        if (!spaceCheck(7)) {
          return 7;
        }
      }
      if (aiBoard[1] == p && aiBoard[7] == p) {
        if (!spaceCheck(4)) {
          return 4;
        }
      }
      if ((aiBoard[4] == p && aiBoard[7] == p)) {
        if (!spaceCheck(1)) {
          return 1;
        }
      }

      if ((aiBoard[2] == p && aiBoard[5] == p)) {
        //player potentially wins column 3
        if (!spaceCheck(8)) {
          return 8;
        }
      }
      if ((aiBoard[2] == p && aiBoard[8] == p)) {
        if (!spaceCheck(5)) {
          return 5;
        }
      }
      if ((aiBoard[5] == p && aiBoard[8] == p)) {
        if (!spaceCheck(2)) {
          return 2;
        }
      }
      if ((aiBoard[2] == p && aiBoard[4] == p)) {
        //player potentially wins diag 2
        if (!spaceCheck(6)) {
          return 6;
        }
      }
      if (aiBoard[2] == p && aiBoard[6] == p) {
        if (!spaceCheck(4)) {
          return 4;
        }
      }
      if (aiBoard[4] == p && aiBoard[6] == p) {
        if (!spaceCheck(2)) {
          return 2;
        }
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
    if (board[i] != null) {
      if (board[i] == true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  int aiTurn(bool p) {
    if (!spaceCheck(4)) {
      log('picked center');
      _turn = false;
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
        if (!spaceCheck(i)) {
          if (aiWinCheck(p, i)) {
            _turn = false;
            return i;
          }
        }
      }
      log('checking for blocks');
      if (aiBlockCheck(!p) != -1) {
        return aiBlockCheck(!p);
      }

      for (int i = 0; i <= 8; i++) {
        if (!spaceCheck(i)) {
          log('randomly picked $i');
          _turn = false;
          return i;
        }
      }
    }
    _turn = false;
    log('oops');
    return -1;
  }

  void emptyBoard() {
    //clears out board when game is done and makes sure AI is turned off
    board.clear();
    aiBoard.clear();
    _ai = false;
    notifyListeners();
  }
}
