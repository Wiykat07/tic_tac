import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  final Map<bool, String> _player = {};
  String _name = '';
  String _winnerName = '';
  bool _piece = false;
  Map<int, bool> board = {};

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
    }
    notifyListeners();
  }

  void placePieces(bool piece, int location) {
    board.addEntries([MapEntry(location, piece)]);
  }

  int boardCheck(bool p) {
    //gonna check previous round for a win so p wil always be !piece.
    if (board.length == 9) {
      return 3;
    }
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
      return 1;
    }
    return 1;
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

  void emptyBoard() {
    //clears out board when game is done
    board.clear();
    notifyListeners();
  }
}
