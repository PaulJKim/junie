import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: MyHomePage(title: 'Has Juni eaten today?'),
    );
  }
}

class MealStatusBar extends StatefulWidget {
  const MealStatusBar({super.key});

  @override
  State<MealStatusBar> createState() => _MealStatusBarState();
}

class _MealStatusBarState extends State<MealStatusBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        MealStatus(mealName: "Breakfast", served: false),
        MealStatus(mealName: "Dinner", served: true)
      ],
    );
  }
}

class MealStatus extends StatefulWidget {
  const MealStatus({super.key, required this.mealName, required this.served});

  final String mealName;
  final bool served;

  @override
  State<MealStatus> createState() => _MealStatusState();
}

class _MealStatusState extends State<MealStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.mealName),
        Checkbox(
          checkColor: Colors.white,
          value: widget.served,
          onChanged: (value) => {},
        )
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final now = DateTime.now();
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.title, textAlign: TextAlign.center)]),
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
            Text(
                'Today is ${widget.now.year}-${widget.now.month}-${widget.now.day}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const MealStatusBar(),
            Image.asset("assets/images/juni-1.jpg"),
            ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
              },
              icon: const Icon(Icons.fastfood_outlined, size: 18),
              label: const Text("I'm about to feed Juni"),
            )
          ],
        ),
      ),
    );
  }
}
