import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pr2flutter/expression_bloc.dart';

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

typedef OpHandler = double Function() Function(double, double);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExpressionBloc _expressionBloc;

  @override
  void initState() {
    _expressionBloc = ExpressionBloc();
    super.initState();
  }

  @override
  void dispose() {
    _expressionBloc.dispose();
    super.dispose();
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
                    onPressed: _expressionBloc.clear,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildButton('1')),
                Expanded(child: _buildButton('2')),
                Expanded(child: _buildButton('3')),
                Expanded(child: _buildButton('+')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildButton('4')),
                Expanded(child: _buildButton('5')),
                Expanded(child: _buildButton('6')),
                Expanded(child: _buildButton('-')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildButton('7')),
                Expanded(child: _buildButton('8')),
                Expanded(child: _buildButton('9')),
                Expanded(child: _buildButton('*')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _buildButton('0')),
                Expanded(child: _buildButton('.')),
                Expanded(
                  child: _buildButton('=',
                    onPressed: _expressionBloc.eval,
                  ),
                ),
                Expanded(child: _buildButton('/')),
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
      child: StreamBuilder<String>(
        stream: _expressionBloc.current,//_resultBloc.result,
        builder: (context, snapshot) {
          return Text(
            snapshot?.data ?? '0',
            overflow: TextOverflow.visible,
            style: Theme
                .of(context)
                .textTheme
                .display1,
          );
        },
      ),
    );
  }

  Widget _buildButton(text, {void Function() onPressed}) =>
    FlatButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.normal,
        ),
      ),
      onPressed: onPressed ?? () => _expressionBloc.concat(text),
    );
}
