import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/pages/main_page.dart';
import 'package:finantial_manager/widgets/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // themeMode: ThemeMode.dark,
        theme: ThemeData(
            // primarySwatch: Colors.red,
            useMaterial3: true,
            colorSchemeSeed: Colors.redAccent, //const Color(0xff6750a4),
            // colorSchemeSeed: Colors.blue,
            // colorScheme: ColorScheme(
            //   primary: Colors.red,
            //   brightness: Brightness.light,
            //   onPrimary: Colors.white,
            //   secondary: Colors.red,
            //   onSecondary: Colors.white,
            //   surface: Colors.white,
            //   background: Colors.brown[50]!,
            //   error: Colors.red,
            //   onBackground: Colors.white,
            //   onError: Colors.red,
            //   onSurface: Colors.white,
            // ),
            brightness: Brightness.dark),
        home: NavigationPage()
        /*MyChart(
          entradas: [
            Entrada(
              origin: 'Salário',
              value: 3000.0,
              dateTime: DateTime.now(),
              isFixed: true,
            ),
            Entrada(
              origin: 'Investimentos',
              value: 1500.0,
              dateTime: DateTime.now().subtract(Duration(days: 7)),
              isFixed: false,
            ),
            Entrada(
              origin: 'Aluguel',
              value: 1200.0,
              dateTime: DateTime.now().subtract(Duration(days: 14)),
              isFixed: true,
            ),
            Entrada(
              origin: 'Freelance',
              value: 500.0,
              dateTime: DateTime.now().subtract(Duration(days: 21)),
              isFixed: false,
            ),
            Entrada(
              origin: 'Bônus',
              value: 1000.0,
              dateTime: DateTime.now().subtract(Duration(days: 28)),
              isFixed: false,
            ),
          ],
          saidas: [
            Saida(
                id: 1,
                reason: 'Aluguel',
                value: 1200,
                dateTime: DateTime(2022, 2, 15),
                isFixed: true),
            Saida(
                id: 2,
                reason: 'Compras',
                value: 500,
                dateTime: DateTime(2022, 2, 14),
                isFixed: false),
            Saida(
                id: 3,
                reason: 'Lazer',
                value: 300,
                dateTime: DateTime(2022, 2, 13),
                isFixed: false),
            Saida(
                id: 4,
                reason: 'Transporte',
                value: 200,
                dateTime: DateTime(2022, 2, 12),
                isFixed: false),
            Saida(
                id: 5,
                reason: 'Compras',
                value: 1000,
                dateTime: DateTime(2022, 2, 11),
                isFixed: true),
          ],
        )*/
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
