import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';

Future<int> saveLoadBenchmark() async {
  // Get the directory for storing files
  Directory appDirectory;
  try {
    appDirectory = await getApplicationDocumentsDirectory();
  } catch (e) {
    print('Error getting application documents directory: $e');
    return -1;
  }

  final data = LoremIpsumGenerator.generate(words: 1000);

  Stopwatch stopwatch = Stopwatch()..start();

  for (int i = 0; i < 10000; i++) {
    String filePath = '${appDirectory.path}/benchmark_file_$i.txt';

    await File(filePath).writeAsString(data);

    // ignore: unused_local_variable
    String loadedData = await File(filePath).readAsString();

    // Delete the benchmark file
    await File(filePath).delete();
  }

  stopwatch.stop();
  int elapsedTime = stopwatch.elapsedMicroseconds;
  return elapsedTime;
}
