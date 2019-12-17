import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tdd_project/core/error/failures.dart';
import 'package:tdd_project/core/usecases/usecase.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';

import '../repositories/number_trivia_repostitory.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTriva, Params> {
  final NumberTrivaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTriva>> call(Params params) async {
    return await repository.getConcretNumber(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number}) : super([number]);
}
