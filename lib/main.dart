import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:ffi';
import 'dart:io' show Platform, Directory;
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import 'testlibrary.dart';

void main() {
  runApp(MyApp());
  //debugPrint('$rc');
  //debugPrint('$rc1');
}

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String mydata = '';
  String mydata2 = '';
  String mydata3 = '';

  void _runclib() {
    setState(() {
      mydata = '';
      mydata2 = '';
      mydata3 = '';
      Vector a = createVector(4,3,2);
      Vector b = createVector(2,3,4);
      Vector c = createVector(3,4,2);

      debugPrint('Vector A = [${a.i}, ${a.j}, ${a.k}]');
      debugPrint('Vector B = [${b.i}, ${b.j}, ${b.k}]');
      debugPrint('Vector C = [${c.i}, ${c.j}, ${c.k}]');

      Vector ab = crossProduct(a, b);
      Vector bc = crossProduct(b, c);
      Vector ca = crossProduct(c, a);

      debugPrint('Vector AxB = [${ab.i}, ${ab.j}, ${ab.k}]');
      debugPrint('Vector BxC = [${bc.i}, ${bc.j}, ${bc.k}]');
      debugPrint('Vector CxA = [${ca.i}, ${ca.j}, ${ca.k}]');

      double adotbc = dotProduct(a, bc);
      double bdotca = dotProduct(b, ca);
      double cdotab = dotProduct(c, ab);

      debugPrint('${adotbc}, ${bdotca}, ${cdotab}');

      Vector inv_a = inverseVector(a);
      Vector aaddinv_a = addVector(a, inv_a);
      Vector aaddb = addVector(a, b);

      debugPrint('Vector -A = [${inv_a.i}, ${inv_a.j}, ${inv_a.k}]');
      debugPrint('Vector A+(-A) = [${aaddinv_a.i}, ${aaddinv_a.j}, ${aaddinv_a.k}]');
      debugPrint('Vector A+B = [${aaddb.i}, ${aaddb.j}, ${aaddb.k}]');


      mydata = 'Vector A = [${a.i}, ${a.j}, ${a.k}]';
      mydata2 = 'Vector B = [${b.i}, ${b.j}, ${b.k}]';
      mydata3 = 'Vector AxB = [${ab.i}, ${ab.j}, ${ab.k}]';
    });
  }

  void _callclibtext() {
    setState(() {
      mydata = '';
      mydata2 = '';
      mydata3 = '';

      String str = 'alexander';
      mydata = str;
      Pointer<Utf8> rev = reverse(str.toNativeUtf8(), str.length);
      mydata2 = rev.toDartString();
      freeString(rev);
      mydata3 = test_string().toDartString();
    });
  }

  void _incrementCounter() {
    setState(() {
      mydata = '';
      mydata2 = '';
      mydata3 = '';

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      mydata = '$_counter';
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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              //'$_counter',
              //Directory.current.path,
              mydata,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              mydata2,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              mydata3,
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: _runclib,
                child: Text(
                  'Run C Lib',
                  style: TextStyle(fontSize: 20),
                ),
            ),
            TextButton(
                onPressed: _callclibtext,
                child: Text(
                  'Call C Text',
                  style: TextStyle(fontSize: 20),
                ),
            ),
            TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TableBasicsExample()),
                ),
                child: Text(
                  'Calender screen',
                  style: TextStyle(fontSize: 20),
            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: //() => Navigator.push(
          //context,
          //MaterialPageRoute(builder: (_) => TableBasicsExample()),
        //),
        _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
