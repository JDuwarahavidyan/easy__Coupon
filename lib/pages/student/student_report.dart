import 'package:flutter/material.dart';

class StudentReport extends StatefulWidget {
  @override
  _StudentReportState createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
