import 'package:flutter/foundation.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';

class NumberTriviaModel extends NumberTriva {
  NumberTriviaModel({
    @required String text,
    @required int number,
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
        text: json['text'], number: json['number'].toInt());
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
