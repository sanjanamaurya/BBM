import 'package:flutter/material.dart';

class MinesweeperGrid extends StatelessWidget {
  final int rows;
  final int columns;
  final int numberOfMines;
  final List<List<bool>> grid;
  final bool isTapped;
  final int tappedRow;
  final int tappedColumn;
  final Function(int, int) toggleTappedCell;

  const MinesweeperGrid({
    Key? key,
    required this.rows,
    required this.columns,
    required this.numberOfMines,
    required this.grid,
    required this.isTapped,
    required this.tappedRow,
    required this.tappedColumn,
    required this.toggleTappedCell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: rows * columns,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
      ),
      itemBuilder: (context, index) {
        final row = index ~/ columns;
        final col = index % columns;
        return GestureDetector(
          onTap: () {
            toggleTappedCell(row, col);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: isTapped && row == tappedRow && col == tappedColumn
                  ? Colors.red
                  : Colors.blue,
            ),
            child: Center(
              child: isTapped && row == tappedRow && col == tappedColumn
                  ? grid[row][col]
                  ? Icon(Icons.error_outline, color: Colors.white)
                  : Icon(Icons.star, color: Colors.yellow)
                  : Icon(Icons.circle, color: Colors.transparent),
            ),
          ),
        );
      },
    );
  }
}