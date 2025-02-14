import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    MaterialApp.router(
      routerConfig: _router,
    ),
  );
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const FirstScreen(),
    routes: [
      GoRoute(
        path: '/second',
        builder: (context, state) => const SecondScreen(),
        routes: [
          GoRoute(
              path: '/third', builder: (context, state) => const ThirdScreen()),
        ],
      )
    ],
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: [
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate, // android
      //   GlobalCupertinoLocalizations.delegate, // ios
      // ],
      localizationsDelegates: L10n.localizationsDelegates,
      // supportedLocales: [
      //   const Locale('ja', 'JP'),
      // ],
      supportedLocales: L10n.supportedLocales,
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: const TextTheme(
              bodyMedium:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
          useMaterial3: true,
          extensions: const [MyTheme(themeColor: Color(0xFF0000FF))]),
      darkTheme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.dark,
          extensions: const [MyTheme(themeColor: Color(0xFF0000FF))]),

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyTheme extends ThemeExtension<MyTheme> {
  const MyTheme({required this.themeColor});

  final Color? themeColor;

  @override
  MyTheme copyWith({Color? themeColor}) {
    return MyTheme(
      themeColor: themeColor ?? this.themeColor,
    );
  }

  @override
  MyTheme lerp(MyTheme? other, double t) {
    if (other is! MyTheme) {
      return this;
    }

    return MyTheme(
      themeColor: Color.lerp(themeColor, other.themeColor, t),
    );
  }
}

class ThemedWidget extends StatelessWidget {
  const ThemedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final myTheme = themeData.extension<MyTheme>()!;
    final color = myTheme.themeColor;
    return Container(width: 100, height: 100, color: color);
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
    _counter;
    Intl.defaultLocale = Localizations.localeOf(context).toString();
    final l10n = L10n.of(context);
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
        // title: Text(widget.title),
        title: Text('$_counter'),
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const TextField(),
            Text(DateFormat.yMEd().format(DateTime.now())),
            Text(l10n.helloWorld),
            // Image.asset('assets/fry.png')  // flutter_genを利用しない場合はpathで指定する
            Assets.fry.image(),
            Assets.toast.svg(
              width: 100,
              height: 100,
            ),
            Text(const String.fromEnvironment('apiEndpoint')),
            Text('$_counter'),
            ThemedWidget(),
            ElevatedButton(
              child: const Text('次へ'),
              onPressed: () async {
                final navigatorState = Navigator.of(context);
                final route = MaterialPageRoute(
                  // builder: (context) => SecondScreen(count: _counter),
                  builder: (context) => SecondScreen(),
                );
                final newCount = await navigatorState.push(route);
                setState(() {
                  _counter = newCount;
                });
                // 以下と同じ
                // Navigator.push(context, route);
              },
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

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('first to second'),
              onPressed: () {
                GoRouter.of(context).go('/second');
              },
            ),
            ElevatedButton(
              child: const Text('first to third'),
              onPressed: () {
                GoRouter.of(context).go('/second/third');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('second to third'),
              onPressed: () {
                GoRouter.of(context).go('/second/third');
              },
            ),
            ElevatedButton(
              child: const Text('back'),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('back'),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
