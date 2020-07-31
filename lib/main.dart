import 'package:flutter/material.dart';
import 'package:the_assignment/fetchData/fetchData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Survey Helper'),
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
  String _companyName = "V2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The Assignment',
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 42,
              ),
            ),
            Text(
              '$_companyName',
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_right,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => FetchData()), //NEED TO WORK HERE
          );
        },
      ),
    );
  }
}
