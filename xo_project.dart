
import 'dart:io';

void displayBoard(List<List<String>> board) {
  print("  1   2   3");
  for (int i = 0; i < 3; ++i) {
    stdout.write("${i + 1} ");
    for (int j = 0; j < 3; ++j) {
      stdout.write(" ${board[i][j]} ");
      if (j < 2) stdout.write("|");
    }
    print("");
    if (i < 2) print(" ---+---+---");
  }
  print("");
}

bool checkWin(List<List<String>> board, String player) {
  // Check rows and columns
  for (int i = 0; i < 3; ++i) {
    if ((board[i][0] == player &&
            board[i][1] == player &&
            board[i][2] == player) ||
        (board[0][i] == player &&
            board[1][i] == player &&
            board[2][i] == player)) {
      return true;
    }
  }

  // Check diagonals
  if ((board[0][0] == player &&
          board[1][1] == player &&
          board[2][2] == player) ||
      (board[0][2] == player &&
          board[1][1] == player &&
          board[2][0] == player)) {
    return true;
  }

  return false;
}

bool isBoardFull(List<List<String>> board) {
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 3; ++j) {
      if (board[i][j] == ' ') {
        return false;
      }
    }
  }
  return true;
}

void main() {
  List<List<String>> board = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' '],
  ];

  String currentPlayer = 'X';

  while (true) {
    displayBoard(board);

    stdout.write("Player $currentPlayer, enter row (1-3) and column (1-3): ");
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print("Invalid input! Try again.");
      continue;
    }

    List<String> parts = input.split(' ');
    if (parts.length != 2) {
      print("Invalid input! Try again.");
      continue;
    }

    int? row = int.tryParse(parts[0]);
    int? col = int.tryParse(parts[1]);

    if (row == null || col == null) {
      print("Invalid input! Try again.");
      continue;
    }

    row--; // Convert to 0-based index
    col--; // Convert to 0-based index

    if (row < 0 || row > 2 || col < 0 || col > 2 || board[row][col] != ' ') {
      print("Invalid input! Try again.");
      continue;
    }

    board[row][col] = currentPlayer;

    if (checkWin(board, currentPlayer)) {
      displayBoard(board);
      print("Player $currentPlayer wins!");
      break;
    }

    if (isBoardFull(board)) {
      displayBoard(board);
      print("It's a draw!");
      break;
    }

    // Switch players
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }
}
