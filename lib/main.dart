import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => MyPage(title: 'Initial page'),
      '/a': (BuildContext context) => MyPage(title: 'page A'),
      '/b': (BuildContext context) => MyPage(title: 'page B'),
      '/c': (BuildContext context) => MyPage(title: 'page C'),
    },
  ));
}

class MyPage extends StatefulWidget {
  MyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget NaviButton(String title, String routeName) {
    return RaisedButton(
        child: Text(title),
        onPressed: () {
          if (title == 'Initial page') {
            // Inital Pageが押されたときは、それまで積み上がっていたPageをすべて取り出す
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else {
            Navigator.pushNamed(context, routeName);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buttons = List<Widget>();
    switch (widget.title) {
      case 'Initial page':
        _buttons.add(NaviButton('page A', '/a'));
        _buttons.add(NaviButton('page B', '/b'));
        _buttons.add(NaviButton('page C', '/c'));
        break;
      case 'page A':
        _buttons.add(NaviButton('Initial page', '/'));
        _buttons.add(NaviButton('page B', '/b'));
        _buttons.add(NaviButton('page C', '/c'));
        break;
      case 'page B':
        _buttons.add(NaviButton('Initial page', '/'));
        _buttons.add(NaviButton('page A', '/a'));
        _buttons.add(NaviButton('page C', '/c'));
        break;
      case 'page C':
        _buttons.add(NaviButton('Initial page', '/'));
        _buttons.add(NaviButton('page A', '/a'));
        _buttons.add(NaviButton('page B', '/B'));
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline3,
            ),
            Divider(),
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buttons,
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _incrementCounter();
        },
      ),
    );
  }
}
