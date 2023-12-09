Future<int> factorialBenchmark() async {
  int numberOfTasks = 1000;

  // Measure the time taken to run the concurrent tasks
  Stopwatch stopwatch = Stopwatch()..start();

  // Run concurrent CPU-bound tasks
  // ignore: unused_local_variable
  List<int> results = await runConcurrentTasks(numberOfTasks);

  // Stop the stopwatch
  stopwatch.stop();

  return stopwatch.elapsedMilliseconds;
}

Future<List<int>> runConcurrentTasks(int numberOfTasks) async {
  List<Future<int>> futures = [];

  for (int i = 0; i < numberOfTasks; i++) {
    await Future.delayed(const Duration(milliseconds: 1), () {
      futures.add(computeTask(i));
    });
  }

  return await Future.wait(futures);
}

Future<int> computeTask(int taskId) async {
  int result = 0;

  // Simulate a CPU-bound task (calculating factorial)
  for (int j = 0; j < 1000; j++) {
    result = calculateFactorial(taskId * j);
  }

  return result;
}

int calculateFactorial(int n) {
  int factorial = 1;

  for (int i = 2; i <= n; i++) {
    factorial *= i;
  }

  return factorial;
}
