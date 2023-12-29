import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_benchmark/localized_benchmark_names.dart';
import 'package:flutter_benchmark/database_benchmark.dart';
import 'package:flutter_benchmark/factorial_benchmark.dart';
import 'package:flutter_benchmark/matrix_multiplication_benchmark.dart';
import 'package:flutter_benchmark/memory_speed_benchmark.dart';
import 'package:flutter_benchmark/save_load_benchmark.dart';
import 'package:progress_state_button/progress_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('pl')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyHomePage(title: 'Simple Flutter Benchmark'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ButtonState _buttonState = ButtonState.idle;
  List<Map<String, int>> _benchmarkResults = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(tr('appMadeBy')),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
              onChanged: (v) => setState(() {
                context.setLocale(Locale(v as String));
              }),
              value: context.locale.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'pl', child: Text('Polski')),
              ],
            ),
            ProgressButton(
              padding: const EdgeInsets.all(8.0),
              stateWidgets: {
                ButtonState.idle: Text(
                  tr('startBenchmark'),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.loading: Text(
                  tr('performingBenchmark'),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.fail: Text(
                  tr('fail'),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.success: Text(
                  tr('success'),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )
              },
              stateColors: {
                ButtonState.idle: Colors.blue.shade800,
                ButtonState.loading: Colors.blue.shade300,
                ButtonState.fail: Colors.red.shade300,
                ButtonState.success: Colors.green.shade400,
              },
              onPressed: () async {
                setState(() {
                  _buttonState = ButtonState.loading;
                  _benchmarkResults = [];
                });

                int result;
                const int delay = 350;
                const int firstTaskDelay = delay * 4;

                // Delayed execution of factorialBenchmark
                await Future.delayed(
                    const Duration(milliseconds: firstTaskDelay), () async {
                  result = await factorialBenchmark();
                  setState(() {
                    _benchmarkResults.add({'factorial': result});
                  });
                });

                // Delayed execution of memorySpeedBenchmark
                await Future.delayed(const Duration(milliseconds: delay),
                    () async {
                  result = await memorySpeedBenchmark();
                  setState(() {
                    _benchmarkResults.add({'memorySpeed': result});
                  });
                });

                // Delayed execution of saveLoadBenchmark
                await Future.delayed(const Duration(milliseconds: delay),
                    () async {
                  result = await saveLoadBenchmark();
                  setState(() {
                    _benchmarkResults.add({'fileSaveLoad': result});
                  });
                });

                // Delayed execution of matrixMultiplicationBenchmark
                await Future.delayed(const Duration(milliseconds: delay),
                    () async {
                  result = await matrixMultiplicationBenchmark();
                  setState(() {
                    _benchmarkResults.add({'matrixMultiplication': result});
                  });
                });

                // Delayed execution of matrixMultiplicationBenchmark
                await Future.delayed(const Duration(milliseconds: delay),
                    () async {
                  result = await databaseQueryBenchmark();
                  setState(() {
                    _benchmarkResults.add({'databaseOperations': result});
                  });
                });

                setState(() {
                  _buttonState = ButtonState.success;
                });
              },
              state: _buttonState,
            ),
            DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    tr('benchmarkName'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    tr('result'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: _benchmarkResults.map((result) {
                final benchmark = result.keys.first;
                final value = result.values.first;
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        getLocatizedBenchmarkName(benchmark),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    DataCell(
                      Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
