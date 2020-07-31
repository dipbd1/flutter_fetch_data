import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_assignment/surveyObject/surveyObject.dart';

List<surveyObject> sQuestions;
var sQuestionsFuture;

List<String> questionType = [
  "Checkbox",
  "dropdown",
  "text",
  "multiple Choice",
  "number"
];

// Question Types

class FetchData extends StatefulWidget {
  FetchData({Key key}) : super(key: key);

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Future<bool> _getSurveys() async {
    setState(() {});

    String apiUrl = "https://example-response.herokuapp.com/getSurvey";

    List<surveyObject> parseQuestion(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<surveyObject>((json) {
        return surveyObject.fromJson(json);
      }).toList();
    }

    Future<List<surveyObject>> fetchQuestion(http.Client client) async {
      final response = await client.get(apiUrl);
      return parseQuestion(response.body);
    }

    sQuestionsFuture = fetchQuestion(http.Client());
    sQuestions = await fetchQuestion(http.Client());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._getSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Data Fetch")),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                        child: Text("Fetch"),
                        onPressed: () {
                          this._getSurveys();
                        }),
                    FutureBuilder(
                        future: sQuestionsFuture,
                        builder:
                            (BuildContext context, AsyncSnapshot questionList) {
                          List<Widget> children = <Widget>[];
                          print(questionList);

                          if (questionList.connectionState ==
                              ConnectionState.waiting) {
                            children = <Widget>[
                              SizedBox(
                                child: CircularProgressIndicator(),
                                width: 60,
                                height: 60,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting result...'),
                              )
                            ];
                          } else if (questionList.hasData) {
                            for (int i = 0; i < questionList.data.length; i++) {
                              children.add(Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(questionList.data[i].question),
                                      Text(questionList.data[i].type),
                                      Text(questionList.data[i].options),
                                      Text(questionList.data[i].required
                                          .toString())
                                    ],
                                  ),
                                ),
                              ));
                            }
                            // children = <Widget>[];
                          } else if (questionList.hasError) {
                            children = <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: '),
                              )
                            ];
                          } else {
                            children = <Widget>[
                              SizedBox(
                                child: CircularProgressIndicator(),
                                width: 60,
                                height: 60,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting result...'),
                              )
                            ];
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget objectToUI(surveyObject sObj) {
  if (sObj.type == questionType[0]) {
    return Text(sObj.question);
  } else if (sObj.type == questionType[1]) {
    return Text(sObj.question);
  } else if (sObj.type == questionType[2]) {
    return Text(sObj.question);
  } else if (sObj.type == questionType[3]) {
    return Text(sObj.question);
  } else if (sObj.type == questionType[4]) {
    return Text(sObj.question);
  }
  return Text("Nothing found");
}

// Text(singleQuestion.type.toString()),
// Text(singleQuestion.options),
// Text(singleQuestion.required.toString()),
