import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_project/core/error/exception.dart';
import 'package:tdd_project/core/error/failures.dart';
import 'package:tdd_project/core/platform/network_info.dart';
import 'package:tdd_project/features/number_trivia/data/datasouces/number_trvia_local_data_source.dart';
import 'package:tdd_project/features/number_trivia/data/datasouces/number_trvia_remote_data_source.dart';
import 'package:tdd_project/features/number_trivia/data/models/number_trvia_model.dart';
import 'package:tdd_project/features/number_trivia/data/repositories/number_trvia_repository_impl.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocaleDataSource extends Mock implements NumberTrviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  NumberTrviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocaleDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocaleDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTrviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkinfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrvia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: 'test trivia');
    final NumberTriva tNumberTrvia = tNumberTriviaModel;
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getConcretNumber(tNumber);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('Shoud return data when sucessful ', () async {
        when(mockRemoteDataSource.getConcretNumber(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getConcretNumber(tNumber);

        verify(mockRemoteDataSource.getConcretNumber(tNumber));
        expect(result, equals(Right(tNumberTrvia)));
      });

      test('Shoud cache data locally ', () async {
        when(mockRemoteDataSource.getConcretNumber(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        await repository.getConcretNumber(tNumber);

        verify(mockRemoteDataSource.getConcretNumber(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test('Shoud return server faiuire when unsucessful ', () async {
        when(mockRemoteDataSource.getConcretNumber(any))
            .thenThrow(ServerException());

        final result = await repository.getConcretNumber(tNumber);

        verify(mockRemoteDataSource.getConcretNumber(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return last locally cache data if present ', () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcretNumber(tNumber);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrvia)));
      });

      test('should return last locally cache data is not present ', () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

        final result = await repository.getConcretNumber(tNumber);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
