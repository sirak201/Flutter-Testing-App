import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:tdd_project/core/error/exception.dart';
import 'package:tdd_project/core/error/failures.dart';
import 'package:tdd_project/core/platform/network_info.dart';
import 'package:tdd_project/features/number_trivia/data/datasouces/number_trvia_local_data_source.dart';
import 'package:tdd_project/features/number_trivia/data/datasouces/number_trvia_remote_data_source.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';
import 'package:tdd_project/features/number_trivia/domain/repositories/number_trivia_repostitory.dart';

class NumberTrviaRepositoryImpl implements NumberTrivaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTrviaLocalDataSource localDataSource;
  final NetworkInfo networkinfo;

  NumberTrviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkinfo,
  });

  @override
  Future<Either<Failure, NumberTriva>> getConcretNumber(int number) async {
    if (await networkinfo.isConnected) {
      try {
        final remoteTrvia = await remoteDataSource.getConcretNumber(number);
        localDataSource.cacheNumberTrivia(remoteTrvia);
        return Right(remoteTrvia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTriva>> getRandomNumberTrivia([int number]) {
    return null;
  }
}
