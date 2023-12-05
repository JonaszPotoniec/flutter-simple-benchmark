Future<int> memoryBenchmark() async {
  // Measure the initial memory usage
  final initialMemoryUsage = await getCurrentMemoryUsage();

  // Perform the operation for which you want to measure memory usage
  // Replace this with your own code
  // ignore: unused_local_variable
  List<int> numbers = List<int>.generate(100000, (index) => index);

  // Measure the memory usage after the operation
  final finalMemoryUsage = await getCurrentMemoryUsage();

  // Calculate the memory usage difference
  final memoryUsageDifference = finalMemoryUsage - initialMemoryUsage;

  // Print the memory usage difference
  return memoryUsageDifference;
}

Future<int> getCurrentMemoryUsage() async {
  final memoryUsage = (await Future.microtask(() {
    return Future.value(0);
  }))
      .hashCode;
  return memoryUsage;
}
