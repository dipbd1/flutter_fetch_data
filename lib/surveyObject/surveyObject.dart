import 'package:flutter/cupertino.dart';

class surveyObject {
  String question;
  String type;
  String options;
  bool required;

  surveyObject({this.question, this.type, this.options, this.required});

  surveyObject.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    type = json['type'];
    options = json['options'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['type'] = this.type;
    data['options'] = this.options;
    data['required'] = this.required;
    return data;
  }
}
