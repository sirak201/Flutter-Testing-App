import 'package:tdd_project/features/number_trivia/data/models/number_trvia_model.dart';

abstract class NumberTrviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}
