import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:tic_tac/Providers/game_provider.dart';

void main() {
  late GameProvider sut;

  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
    sut = GameProvider();
  });

  test('Initial Values', () {
    expect(sut.players, []);
    expect(
      sut.currentPlayer,
      Player(name: '', piece: false, number: PlayerNumber.none),
    );
    expect(sut.winnerName, '');
    expect(sut.board, {});
    expect(sut.aiBoard, {});
    expect(sut.winState, 0);
    expect(sut.difficulty, 0);
    expect(sut.here, false);
  });

  test('Does get name work?', () {
    expect(sut.name, '');
    final Player p =
        Player(name: 'hi', piece: false, number: PlayerNumber.none);

    sut.playerSet(p);

    expect(sut.name, 'hi');
  });

  test('Does get piece work?', () {
    expect(sut.piece, false);

    final Player p = Player(name: 'hi', piece: true, number: PlayerNumber.none);

    sut.playerSet(p);

    expect(sut.piece, true);
  });

  test('Does get winnerName work?', () {
    expect(sut.winnerName, '');
    const String s = 'me';

    sut.winnerSet(s);

    expect(sut.winnerName, s);
  });

  test('Does get currentP work?', () {
    expect(
      sut.currentPlayer,
      Player(name: '', piece: false, number: PlayerNumber.none),
    );

    final Player p =
        Player(name: 'hi', piece: true, number: PlayerNumber.player1);

    sut.playerSet(p);

    expect(sut.currentP, p);
  });

  test('Does playerSet work?', () {
    expect(
      sut.currentPlayer,
      Player(name: '', piece: false, number: PlayerNumber.none),
    );

    final Player p =
        Player(name: 'hi', piece: true, number: PlayerNumber.player1);

    sut.playerSet(p);

    expect(sut.name, 'hi');
    expect(sut.piece, true);
    expect(sut.currentPlayer.number, PlayerNumber.player1);
  });

  test('Does difficultySet work?', () {
    expect(sut.difficulty, 0);
    sut.difficultySet(1);
    expect(sut.difficulty, 1);
  });

  test('Does addPlayer work?', () {
    expect(sut.players, []);

    final Player p =
        Player(name: 'me', piece: false, number: PlayerNumber.player1);

    sut.addPlayer(false, 'me', PlayerNumber.player1);

    expect(sut.players[0], p);
  });

  test('Does switchTurns work?', () {
    final Player p =
        Player(name: 'me', piece: false, number: PlayerNumber.player1);
    final Player p2 =
        Player(name: 'you', piece: true, number: PlayerNumber.player2);

    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);
    sut.playerSet(p);

    expect(sut.currentPlayer, p);

    sut.switchTurns(true);
    expect(sut.currentPlayer, p2);
  });

  test('Does swapTurns work?', () {
    final Player p =
        Player(name: 'me', piece: false, number: PlayerNumber.player1);
    final Player p2 =
        Player(name: 'you', piece: true, number: PlayerNumber.player2);

    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);

    expect(sut.players[0], p);
    expect(sut.players[1], p2);

    sut.swapTurns();
    final Player newP =
        Player(name: 'you', piece: false, number: PlayerNumber.player1);
    final Player newP2 =
        Player(name: 'me', piece: true, number: PlayerNumber.player2);

    expect(sut.players[0], newP);
    expect(sut.players[1], newP2);
  });

  test('Does placePieces work?', () {
    expect(sut.board, {});
    sut.placePieces(false, 2);

    expect(sut.board, {2: false});
  });

  test('Do boardCheck continue states work?', () {
    //inital values to test
    expect(sut.winState, 0);
    expect(sut.winnerName, '');

    //add some players
    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);

    //less than 3 pieces, always winState = 1
    sut.placePieces(false, 1);
    sut.boardCheck(false);

    expect(sut.winState, 1);

    //put down a few more pieces but no one has won...so winState = 1
    sut.placePieces(true, 5);
    sut.placePieces(false, 2);
    sut.boardCheck(false);

    expect(sut.winState, 1);
  });

  test('Do all boardCheck win states work?', () {
    //oh lord this will be a long one...

    //inital values to test
    expect(sut.winState, 0);
    expect(sut.winnerName, '');

    //add some players
    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);

    //add this because normally boardcheck checks for the lastPlayer name for a winnerName but we're manipulating values here so there is no technical last player
    sut.lastPlayer =
        Player(name: 'me', piece: false, number: PlayerNumber.player1);

    //row 1 win
    sut.placePieces(false, 0);
    sut.placePieces(false, 1);
    sut.placePieces(false, 2);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //row 2 win
    sut.placePieces(false, 3);
    sut.placePieces(false, 4);
    sut.placePieces(false, 5);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //row 3 win
    sut.placePieces(false, 6);
    sut.placePieces(false, 7);
    sut.placePieces(false, 8);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //column 1 win
    sut.placePieces(false, 0);
    sut.placePieces(false, 3);
    sut.placePieces(false, 6);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //column 2 win
    sut.placePieces(false, 1);
    sut.placePieces(false, 3);
    sut.placePieces(false, 7);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //column 3 win
    sut.placePieces(false, 2);
    sut.placePieces(false, 5);
    sut.placePieces(false, 8);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //diag 1 win
    sut.placePieces(false, 0);
    sut.placePieces(false, 4);
    sut.placePieces(false, 8);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();

    //diag 2 win
    sut.placePieces(false, 2);
    sut.placePieces(false, 4);
    sut.placePieces(false, 6);

    sut.boardCheck(false);

    expect(sut.winState, 2);
    expect(sut.winnerName, 'me');

    sut.board.clear();
  });

  test('Does boardCheck tie state work?', () {
    //inital values to test
    expect(sut.winState, 0);
    expect(sut.winnerName, '');

    //add some players
    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);

    //add a bunch of pieces!
    sut.placePieces(false, 0);
    sut.placePieces(true, 1);
    sut.placePieces(false, 2);
    sut.placePieces(true, 3);
    sut.placePieces(false, 4);
    sut.placePieces(true, 5);
    sut.placePieces(true, 6);
    sut.placePieces(false, 7);
    sut.placePieces(true, 8);
    sut.boardCheck(false);

    //winstate should be 3
    expect(sut.winState, 3);
  });

  test('Do all aiWinCheck win states work?', () {
    //row 1 win
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(1, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 2), true);
    sut.aiBoard.clear();

    //row 2 win
    sut.aiBoard.addEntries([const MapEntry(3, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(1, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 5), true);
    sut.aiBoard.clear();

    //row 3 win
    sut.aiBoard.addEntries([const MapEntry(6, false)]);
    sut.aiBoard.addEntries([const MapEntry(7, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 8), true);
    sut.aiBoard.clear();

    //column 1 win
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(3, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 6), true);
    sut.aiBoard.clear();

    //column 2 win
    sut.aiBoard.addEntries([const MapEntry(1, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(3, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 7), true);
    sut.aiBoard.clear();

    //column 3 win
    sut.aiBoard.addEntries([const MapEntry(5, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 2), true);
    sut.aiBoard.clear();

    //diag 1 win
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(3, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 8), true);
    sut.aiBoard.clear();

    //diag 2 win
    sut.aiBoard.addEntries([const MapEntry(2, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(3, false)]);

    //should return true
    expect(sut.aiWinCheck(false, 6), true);
    sut.aiBoard.clear();
  });

  test('Does aiWinCheck continue and tie state work?', () {
    //add some pieces
    sut.aiBoard.addEntries([const MapEntry(0, false)]);

    //checks that aiWinCheck comes out false and doesn't leave a piece at low numbers
    expect(sut.aiWinCheck(false, 1), false);
    expect(sut.aiBoard.length, 1);

    //add a few more pieces
    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(3, false)]);
    sut.aiBoard.addEntries([const MapEntry(5, false)]);

    //check that both aiWinCheck comes out false AND that it doesn't leave the piece on the board
    expect(sut.aiWinCheck(false, 1), false);
    expect(sut.aiBoard.length, 4);

    //check that ties lead to a false
    sut.aiBoard.addEntries([const MapEntry(6, true)]);
    sut.aiBoard.addEntries([const MapEntry(7, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, false)]);
    sut.aiBoard.addEntries([const MapEntry(2, true)]);
    expect(sut.aiWinCheck(false, 1), false);
  });

  test('Does aiBlockCheck work?', () {
    //and we thought the win state checks were long...

    //first check that less than 3 pieces is false
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    expect(sut.aiBlockCheck(true), -1);
    sut.aiBoard.clear();

    //row 1 blocks
    sut.aiBoard.addEntries([const MapEntry(0, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(1, true)]);

    expect(sut.aiBlockCheck(true), 2);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(0, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(2, true)]);

    expect(sut.aiBlockCheck(true), 1);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(2, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(1, true)]);

    expect(sut.aiBlockCheck(true), 0);
    sut.aiBoard.clear();

    //row 2 blocks
    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(5, true)]);

    expect(sut.aiBlockCheck(true), 3);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(3, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(5, true)]);

    expect(sut.aiBlockCheck(true), 4);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(3, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, true)]);

    expect(sut.aiBlockCheck(true), 5);
    sut.aiBoard.clear();

    //row 3 blocks
    sut.aiBoard.addEntries([const MapEntry(6, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(7, true)]);

    expect(sut.aiBlockCheck(true), 8);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(7, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, true)]);

    expect(sut.aiBlockCheck(true), 6);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(6, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, true)]);

    expect(sut.aiBlockCheck(true), 7);
    sut.aiBoard.clear();

    //column 1 blocks
    sut.aiBoard.addEntries([const MapEntry(0, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(3, true)]);

    expect(sut.aiBlockCheck(true), 6);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(6, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(3, true)]);

    expect(sut.aiBlockCheck(true), 0);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(0, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(6, true)]);

    expect(sut.aiBlockCheck(true), 3);
    sut.aiBoard.clear();

    //column 2 blocks
    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(1, true)]);

    expect(sut.aiBlockCheck(true), 7);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(7, true)]);

    expect(sut.aiBlockCheck(true), 1);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(1, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(7, true)]);

    expect(sut.aiBlockCheck(true), 4);
    sut.aiBoard.clear();

    //column 3 blocks
    sut.aiBoard.addEntries([const MapEntry(5, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, true)]);

    expect(sut.aiBlockCheck(true), 2);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(8, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(2, true)]);

    expect(sut.aiBlockCheck(true), 5);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(2, true)]);
    sut.aiBoard.addEntries([const MapEntry(4, false)]);
    sut.aiBoard.addEntries([const MapEntry(5, true)]);

    expect(sut.aiBlockCheck(true), 8);
    sut.aiBoard.clear();

    //diag 1 blocks
    sut.aiBoard.addEntries([const MapEntry(0, true)]);
    sut.aiBoard.addEntries([const MapEntry(5, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, true)]);

    expect(sut.aiBlockCheck(true), 4);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(0, true)]);
    sut.aiBoard.addEntries([const MapEntry(5, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, true)]);

    expect(sut.aiBlockCheck(true), 8);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(5, false)]);
    sut.aiBoard.addEntries([const MapEntry(8, true)]);

    expect(sut.aiBlockCheck(true), 0);
    sut.aiBoard.clear();

    //diag 2 blocks
    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(6, true)]);

    expect(sut.aiBlockCheck(true), 2);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(6, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(2, true)]);

    expect(sut.aiBlockCheck(true), 4);
    sut.aiBoard.clear();

    sut.aiBoard.addEntries([const MapEntry(2, true)]);
    sut.aiBoard.addEntries([const MapEntry(0, false)]);
    sut.aiBoard.addEntries([const MapEntry(4, true)]);

    expect(sut.aiBlockCheck(true), 6);
    sut.aiBoard.clear();
  });

  test('Does spaceCheck work?', () {
    //initially any space should be false as all are free
    expect(sut.spaceCheck(0), false);

    //but if we put something there, it will turn true
    sut.placePieces(false, 0);
    expect(sut.spaceCheck(0), true);

    //and if we clear the board its false again.
    sut.board.clear();
    expect(sut.spaceCheck(0), false);
  });

  test('Does pieceCheck work?', () {
    //piece check helps handle the drawing to place pieces by determining what piece should go on the board
    //defaults to false which could be bad but often its working with spacecheck so that covers it
    expect(sut.pieceCheck(0), false);

    //but if we place a piece that is true (aka O), we expect it to be true
    sut.placePieces(true, 0);
    expect(sut.pieceCheck(0), true);
  });

  test('Does aiTurn at hard difficulty work?', () {
    //okay now the fun part
    //setting the difficulty
    sut.difficultySet(0);

    //first does it go for the center by default?
    expect(sut.aiTurn(true), 4);

    //now let's add some pieces and see if it blocks
    sut.placePieces(true, 4);
    sut.placePieces(false, 2);
    sut.placePieces(false, 5);

    expect(sut.aiTurn(true), 8);
    sut.board.clear();
    sut.aiBoard.clear();

    //alright now let's see if it will take a win
    sut.placePieces(true, 4);
    sut.placePieces(false, 3);
    sut.placePieces(true, 7);

    expect(sut.aiTurn(true), 1);
    sut.board.clear();
    sut.aiBoard.clear();

    //check if it goes for a win over a block
    sut.placePieces(true, 4);
    sut.placePieces(false, 2);
    sut.placePieces(false, 5);
    sut.placePieces(true, 7);

    expect(sut.aiTurn(true), 1);
    sut.board.clear();
    sut.aiBoard.clear();

    //if no other options, takes next available from the top down...so if 4 is taken, it goes for 0
    sut.placePieces(true, 4);
    expect(sut.aiTurn(true), 0);
  });

  test('Does aiTurn at normal difficulty work?', () {
    //very similar to hard mode except it won't block
    //setting the difficulty
    sut.difficultySet(1);

    //first does it go for the center by default?
    expect(sut.aiTurn(true), 4);
    sut.board.clear();
    sut.aiBoard.clear();

    //alright now let's see if it will take a win
    sut.placePieces(true, 4);
    sut.placePieces(false, 3);
    sut.placePieces(true, 7);

    expect(sut.aiTurn(true), 1);
    sut.board.clear();
    sut.aiBoard.clear();

    //now let's see if it won't block
    sut.placePieces(true, 4);
    sut.placePieces(false, 2);
    sut.placePieces(false, 5);

    expect(sut.aiTurn(true), 0);
    sut.board.clear();
    sut.aiBoard.clear();

    //if no other options, takes next available from the top down...so if 4 is taken, it goes for 0
    sut.placePieces(true, 4);
    expect(sut.aiTurn(true), 0);
  });

  test('Does aiTurn at easy difficulty work?', () {
    //this is harder and easier to test cuz it will be a random piece so we're just gonna see if it puts down pieces
    //set difficulty
    sut.difficultySet(2);

    sut.placePieces(false, sut.aiTurn(false));
    sut.placePieces(false, sut.aiTurn(false));

    expect(sut.board.length, 2);
  });

  test('Does resetBoard work?', () {
    //easy enough, are the boards clear but the players are there?

    //gonna put down some pieces for aiboard and board and set up some players and the here flag is true
    sut.placePieces(true, 4);
    sut.placePieces(false, 2);
    sut.placePieces(false, 5);
    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(2, false)]);
    sut.aiBoard.addEntries([const MapEntry(5, true)]);
    final Player p =
        Player(name: 'me', piece: false, number: PlayerNumber.player1);
    final Player p2 =
        Player(name: 'you', piece: true, number: PlayerNumber.player2);
    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);
    sut.here = true;

    expect(sut.board.isNotEmpty, true);
    expect(sut.aiBoard.isNotEmpty, true);
    expect(sut.here, true);
    expect(sut.players.isNotEmpty, true);

    sut.resetBoard();

    //should have boards clear, here equal false, and players still there
    expect(sut.board.isEmpty, true);
    expect(sut.aiBoard.isEmpty, true);
    expect(sut.here, false);
    expect(sut.players[0], p);
    expect(sut.players[1], p2);
  });

  test('Does emptyBoard work?', () {
    //checks if EVERYTHING is clear

    //setting up everything
    //gonna put down some pieces for aiboard and board and set up some players and the here flag is true
    sut.placePieces(true, 4);
    sut.placePieces(false, 2);
    sut.placePieces(false, 5);
    sut.aiBoard.addEntries([const MapEntry(4, true)]);
    sut.aiBoard.addEntries([const MapEntry(2, false)]);
    sut.aiBoard.addEntries([const MapEntry(5, true)]);
    sut.addPlayer(false, 'me', PlayerNumber.player1);
    sut.addPlayer(true, 'you', PlayerNumber.player2);
    sut.here = true;

    expect(sut.board.isNotEmpty, true);
    expect(sut.aiBoard.isNotEmpty, true);
    expect(sut.here, true);
    expect(sut.players.isNotEmpty, true);

    sut.emptyBoard();

    //everything should be empty and here should be false
    expect(sut.board.isEmpty, true);
    expect(sut.aiBoard.isEmpty, true);
    expect(sut.here, false);
    expect(sut.players.isEmpty, true);
  });
}
