import 'package:flutter/material.dart';

// 各ページで押したカウンターを保持する方法
// 1. グローバル変数?(Dartでの呼び方を確認)でマップ<String, int>で保持する
// 2. provider パッケージを使う?

Map<String, int> _counters = {
  'Initial page': 0,
  'page A': 0,
  'page B': 0,
  'page C': 0,
};

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
      _counters[widget.title]++;
    });
  }

  Widget naviButton(String title, String routeName) {
    return ElevatedButton(
        child: Text(title),
        onPressed: () {
          if (title == 'Initial page') {
            // Inital Pageが押されたときは、それまで積み上がっていたPageをすべて取り出す
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else {
            try {
              Navigator.pushNamed(context, routeName);
            } catch (e) {
              final SnackBar snackBar = SnackBar(
                content: Text("${title}が見つかりません"),
                duration: Duration(seconds: 3),
              );
              try {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } catch (e) {
                print(e.toString());
              }
            }
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _counter = _counters[widget.title];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buttons = List<Widget>.filled(0, null, growable: true);
    switch (widget.title) {
      case 'Initial page':
        _buttons.add(naviButton('page A', '/a'));
        _buttons.add(naviButton('page B', '/b'));
        _buttons.add(naviButton('page C', '/c'));
        break;
      case 'page A':
        _buttons.add(naviButton('Initial page', '/'));
        _buttons.add(naviButton('page B', '/b'));
        _buttons.add(naviButton('page C', '/c'));
        break;
      case 'page B':
        _buttons.add(naviButton('Initial page', '/'));
        _buttons.add(naviButton('page A', '/a'));
        _buttons.add(naviButton('page C', '/c'));
        break;
      case 'page C':
        _buttons.add(naviButton('Initial page', '/'));
        _buttons.add(naviButton('page A', '/a'));
        _buttons.add(naviButton('page B', '/B'));
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
