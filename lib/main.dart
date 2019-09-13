import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input;

  @override
  void initState() {
    input = '0';
    super.initState();
  }

  void resetInput([String value = '0']) {
    setState(() => input = value);
  }

  void eval() {
    try {
      final parser = Parser();
      final expr = parser.parse(input);
      final cm = ContextModel();
      final result = expr.evaluate(EvaluationType.REAL, cm) as double;
      if (result == result.floor()) {
        resetInput(result.round().toString());
      } else {
        resetInput(result.toStringAsFixed(13));
      }
    } on StateError {
      resetInput('bad state');
    }
  }

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
                  color: Theme.of(context).primaryColor,
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
                  child: _buildButton('Clear',
                    onPressed: () => resetInput('0'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton('1')),
                Expanded(child: _buildNumButton('2')),
                Expanded(child: _buildNumButton('3')),
                Expanded(child: _buildOpButton('+',
                  onPressed: replaceZero('+'),
                )),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton('4')),
                Expanded(child: _buildNumButton('5')),
                Expanded(child: _buildNumButton('6')),
                Expanded(child: _buildOpButton('-',
                  onPressed: replaceZero('+')
                )),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton('7')),
                Expanded(child: _buildNumButton('8')),
                Expanded(child: _buildNumButton('9')),
                Expanded(child: _buildOpButton('*')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildNumButton('0')),
                Expanded(child: _buildButton('.')),
                Expanded(
                  child: _buildButton('=', onPressed: eval),
                ),
                Expanded(child: _buildOpButton('/')),
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
            input,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.display1)
    );
  }

  replaceZero(String value) {
    return () {
      if (input == '0') {
        setState(() => input = value);
      } else {
        setState(() => input += value);
      }
    };
  }

  Widget _buildButton(String num, {void Function() onPressed}) {
    return FlatButton(
      child: Text(
        num,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.normal,
        ),
      ),
      onPressed: onPressed ?? () {
        setState(() => input += num);
      }
    );
  }

  Widget _buildNumButton(String num) {
    return _buildButton(num, onPressed: replaceZero(num));
  }

  Widget _buildOpButton(String op, {void Function() onPressed}) {
    return _buildButton(' $op ', onPressed: onPressed);
  }
}
