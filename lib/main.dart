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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Has Juni eaten today?'),
    );
  }
}

class MealStatusBar extends StatefulWidget {
  const MealStatusBar({super.key, required this.breakfastServed, required this.dinnerServed, this.breakfastServer = '', this.dinnerServer = ''});

  final String breakfastServer;
  final bool breakfastServed;
  final String dinnerServer;
  final bool dinnerServed;

  @override
  State<MealStatusBar> createState() => _MealStatusBarState();
}

class _MealStatusBarState extends State<MealStatusBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MealStatus(mealName: "Breakfast", served: widget.breakfastServed, server: widget.breakfastServer,),
        const SizedBox(width: 20),
        MealStatus(mealName: "Dinner", served: widget.dinnerServed, server: widget.dinnerServer,)
      ],
    );
  }
}

class MealStatus extends StatefulWidget {
  const MealStatus({super.key, required this.mealName, required this.served, required this.server});

  final String mealName;
  final String server;
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
        if (widget.served) ...[Text("Server: ${widget.server}")],
        Checkbox(
          checkColor: Colors.white,
          value: widget.served,
          onChanged: (value) => {
            
          },
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

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    super.key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final String groupValue;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<String>(
              groupValue: groupValue,
              value: value,
              onChanged: (String? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class MealSelectorRadio extends StatefulWidget {
  const MealSelectorRadio({super.key});

  @override
  State<MealSelectorRadio> createState() => _MealSelectorRadioState();
}

class _MealSelectorRadioState extends State<MealSelectorRadio> {
  String _selectedMeal = "Breakfast";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <LabeledRadio>[
        LabeledRadio(
          label: 'Breakfast',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: 'Breakfast',
          groupValue: _selectedMeal,
          onChanged: (String newValue) {
            setState(() {
              _selectedMeal = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'Dinner',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: 'Dinner',
          groupValue: _selectedMeal,
          onChanged: (String newValue) {
            setState(() {
              _selectedMeal = newValue;
            });
          },
        ),
      ],
    );
  }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Today is ${widget.now.year}-${widget.now.month}-${widget.now.day}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.all(15)),
            const MealStatusBar(breakfastServed: false, dinnerServed: false,),
            Image.asset("assets/images/juni-1.jpg", width: 200, height: 300),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Feeder Name:',
                                    icon: Icon(Icons.account_box),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(15), child: Text("What meal are you feeding?")),
                                const MealSelectorRadio(),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              child: const Text("Done"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      );
                    });
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
