import 'package:easy_localization/easy_localization.dart';

String getLocatizedBenchmarkName(String benchmarkName) {
  switch (benchmarkName) {
    case "factorial":
      return tr('factorial');
    case "memorySpeed":
      return tr('memorySpeed');
    case "fileSaveLoad":
      return tr('fileSaveLoad');
    case "matrixMultiplication":
      return tr('matrixMultiplication');
    case "databaseOperations":
      return tr('databaseOperations');
    case "benchmarkName":
      return tr('benchmarkName');
    default:
      return 'Unknown benchmark';
  }
}
