import 'package:dartz/dartz.dart';
import 'package:tdd_project/core/error/failures.dart';

import '../entities/number_triva.dart';

abstract class NumberTrivaRepository {
  Future<Either<Failure, NumberTriva>> getConcretNumber(int number);
  Future<Either<Failure, NumberTriva>> getRandomNumberTrivia([int number]);
}
