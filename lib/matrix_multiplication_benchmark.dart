import 'package:vector_math/vector_math.dart';
import 'dart:math';

Future<int> matrixMultiplicationBenchmark() async {
  Stopwatch stopwatch = Stopwatch()..start();

  // Perform GPU operations here
  for (int i = 0; i < 100000; i++) {
    // Example GPU operation: Matrix multiplication

    Matrix3 matrix1 = Matrix3(
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
    );

    Matrix3 matrix2 = Matrix3(
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
      Random().nextDouble(),
    );

    // ignore: unused_local_variable
    Matrix3 result = matrix1 * matrix2;
  }

  // Stop the benchmark and calculate the elapsed time
  stopwatch.stop();
  int elapsedTime = stopwatch.elapsedMicroseconds;

  return elapsedTime;
}
