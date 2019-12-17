import 'package:dartz/dartz.dart';
import 'package:tdd_project/core/error/failures.dart';
import 'package:tdd_project/core/usecases/usecase.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';
import 'package:tdd_project/features/number_trivia/domain/repositories/number_trivia_repostitory.dart';

class GetRandomNumberTravia implements UseCase<NumberTriva, NoParams> {
  final NumberTrivaRepository repository;
  GetRandomNumberTravia(this.repository);

  @override
  Future<Either<Failure, NumberTriva>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
