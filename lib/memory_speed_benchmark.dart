import 'dart:math';

Future<int> memorySpeedBenchmark() async {
  const int dataSize =
      100000; // Size of the data to be stored in memory (in bytes)

  // Generate random data
  List<int> data = List.generate(dataSize, (index) => Random().nextInt(256));

  // Start the benchmark
  Stopwatch stopwatch = Stopwatch()..start();

  // ignore: unused_local_variable
  int value = 0;

  // Access the data in a loop
  for (int i = 0; i < 100; i++) {
    await Future.delayed(const Duration(milliseconds: 1), () {
      for (int i = 0; i < dataSize; i++) {
        value = data[i];
      }
    });
  }

  // Stop the benchmark and calculate the elapsed time
  stopwatch.stop();
  int elapsedTime = stopwatch.elapsedMicroseconds;

  return elapsedTime;
}
