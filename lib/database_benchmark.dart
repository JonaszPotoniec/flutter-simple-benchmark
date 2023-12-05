import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<int> databaseQueryBenchmark() async {
  // Open the database
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'benchmark.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS benchmark (id INTEGER PRIMARY KEY, name TEXT)');
  });

  Stopwatch queryTimer = Stopwatch()..start();
  // Generate sample data
  List<Map<String, dynamic>> data = [];
  for (int i = 0; i < 100000; i++) {
    data.add({'id': i, 'name': 'Item $i'});
  }

  // Insert sample data into the database
  await database.transaction((txn) async {
    for (var item in data) {
      await txn.insert('benchmark', item);
    }
  });

  // Start the benchmark for executing a query
  // ignore: unused_local_variable
  List<Map<String, dynamic>> result =
      await database.rawQuery('SELECT * FROM benchmark');

  // Close the database
  await database.close();

  // Delete the database file
  await deleteDatabase(path);

  queryTimer.stop();
  return queryTimer.elapsedMilliseconds;
}
