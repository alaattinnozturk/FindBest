import 'package:barber_app/screens/Services_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/basicUserInfo.dart';

void main() {
<<<<<<< HEAD
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BasicUserInfo(),
        ),
      ],
      builder: (_, __) => const MyApp(),
    ),
  );
=======
  runApp(const MyApp());
>>>>>>> 08a5cf629a42e9b65944626fa203ff9425b46220
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      home: MainApp(),
=======
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
>>>>>>> 08a5cf629a42e9b65944626fa203ff9425b46220
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                // foreground
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesPage()),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                child: Text(
                  "assadsadad",
                  style: TextStyle(color: Colors.black),
                )),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splash: Column(
//         children: [
//           Image.asset(
//             'assets/autoImage.png',
//             height: 150,
//             width: (MediaQuery.of(context).size.width) / 2,
//             fit: BoxFit.cover,
//           ),
//           const Text(
//             "3S AUTO",
//             style: TextStyle(
//                 fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
//           )
//         ],
//       ),
//       backgroundColor: Color(0xffffac1c),
//       nextScreen: ServicesPage(),
//       splashIconSize: 250,
//       duration: 2000,
//       splashTransition: SplashTransition.sizeTransition,
//       pageTransitionType: PageTransitionType.leftToRightWithFade,
//       animationDuration: const Duration(seconds: 1),
//     );
//   }
// }