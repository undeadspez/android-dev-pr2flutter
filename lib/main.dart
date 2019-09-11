import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = 'Calculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: title),
    );
  }
}

typedef NumHandler = void Function() Function(int);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _buildResultLabel()
                ),
                Expanded(
                  child: FlatButton(
                    child: Text('Clear'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton(1)),
                Expanded(child: _buildNumButton(2)),
                Expanded(child: _buildNumButton(3)),
                Expanded(child: _buildButton(text: '+', onPressed: () {})),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton(4)),
                Expanded(child: _buildNumButton(5)),
                Expanded(child: _buildNumButton(6)),
                Expanded(child: _buildButton(text: '-', onPressed: () {})),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton(7)),
                Expanded(child: _buildNumButton(8)),
                Expanded(child: _buildNumButton(9)),
                Expanded(child: _buildButton(text: '*', onPressed: () {})),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton(0)),
                Expanded(child: _buildButton(text: '.', onPressed: () {})),
                Expanded(child: _buildButton(text: '=', onPressed: () {})),
                Expanded(child: _buildButton(text: '/', onPressed: () {})),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultLabel() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Text(
        _result.toString(),
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }

  Widget _buildButton({
    @required String text,
    @required void Function() onPressed
  }) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.normal
        ),
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildNumButton(int num) {
    return _buildButton(
      text: num.toString(),
      onPressed: _onNumPressed(num)
    );
  }

  final NumHandler _onNumPressed = (int num) => () {
    debugPrint('Clicked $num');
  };
}
