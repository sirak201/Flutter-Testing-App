import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_project/features/number_trivia/data/models/number_trvia_model.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Test');

  test('Should be a subclass of a NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTriva>());
  });

  group('fromJson', () {
    test('Should return a valid model when the JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trvia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test('Should return a valid model when the JSON number is an Double',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trvia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map ', () async {
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {
        "text": tNumberTriviaModel.text,
        "number": tNumberTriviaModel.number
      };
      expect(result, expectedMap);
    });
  });
}
