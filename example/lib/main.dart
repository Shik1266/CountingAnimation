import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_counting_animation/number_counting_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Counting Animation Demo',
        value: 12345,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final int value;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int intvalue = 0;
  String var1 = '';
  String var2 = '';
  String var3 = '';
  String var4 = '';

  void initData(int value) {
    intvalue = value;
    var formatCurrency = NumberFormat.simpleCurrency(
      locale: "ko_KR",
      name: '',
      decimalDigits: 0,
    );
    String formatStr = formatCurrency.format(value);

    var1 = value.toString();
    var2 = '₩${value.toString()}.123';
    var3 = '₩$formatStr';
    var4 = '[$formatStr]';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          initData(intvalue + 1111);
        },
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            CountingAnimation(
              value: var1,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              scrollCount: 20,
              singleScollDuration: const Duration(milliseconds: 50),
              lastDuration: const Duration(milliseconds: 1000),
            ),
            const Spacer(),
            CountingAnimation(
              value: var2,
              textStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              useChar: true,
            ),
            const Spacer(),
            CountingAnimation(
              value: var3,
              textStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              useChar: true,
            ),
            const Spacer(),
            CountingAnimation(
              value: var4,
              textStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              useChar: true,
              scrollCount: 10,
              singleScollDuration: const Duration(milliseconds: 200),
              lastDuration: const Duration(milliseconds: 1000),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
