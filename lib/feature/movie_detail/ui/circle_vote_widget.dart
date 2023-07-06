import 'package:flutter/material.dart';

class CircleVoteAverageWidget extends StatelessWidget {
  final double voteAverage;

  const CircleVoteAverageWidget({
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    double size = 50;
    final value = voteAverage / 10.0;
    final percentage = value.clamp(0.0, 1.0);

    return Container(
      child: Container(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: percentage,
              strokeWidth: 5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(percentage > 0.8
                  ? Colors.green
                  : (percentage > 0.6 ? Colors.orange : Colors.red)),
            ),
            Text(
              voteAverage.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
