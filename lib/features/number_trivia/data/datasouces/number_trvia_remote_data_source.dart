import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriva> getConcretNumber(int number);
  Future<NumberTriva> getRandomNumberTrivia([int number]);
}
