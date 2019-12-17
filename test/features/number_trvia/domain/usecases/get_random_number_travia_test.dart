import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_project/core/usecases/usecase.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';
import 'package:tdd_project/features/number_trivia/domain/repositories/number_trivia_repostitory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_concrete_number.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_random_number_triva.dart';

class MockNumberTrivaRepostitory extends Mock implements NumberTrivaRepository {
}

void main() {
  GetRandomNumberTravia usecase;
  MockNumberTrivaRepostitory mockNumberTrviaRepository;

  final tNumberTrvia = NumberTriva(number: 1, text: 'test');

  setUp(() {
    mockNumberTrviaRepository = MockNumberTrivaRepostitory();
    usecase = GetRandomNumberTravia(mockNumberTrviaRepository);
  });

  test('Should get trvia from the repo', () async {
    when(mockNumberTrviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrvia));

    final result = await usecase(NoParams());

    expect(result, Right(tNumberTrvia));
    verify(mockNumberTrviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTrviaRepository);
  });
}
