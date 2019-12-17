import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_project/core/usecases/usecase.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_triva.dart';
import 'package:tdd_project/features/number_trivia/domain/repositories/number_trivia_repostitory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_concrete_number.dart';

class MockNumberTrivaRepostitory extends Mock implements NumberTrivaRepository {
}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTrivaRepostitory mockNumberTrviaRepository;

  final tNumber = 1;
  final tNumberTrvia = NumberTriva(number: 1, text: 'test');

  setUp(() {
    mockNumberTrviaRepository = MockNumberTrivaRepostitory();
    usecase = GetConcreteNumberTrivia(mockNumberTrviaRepository);
  });

  test('Should get trvia for the number from the repo', () async {
    when(mockNumberTrviaRepository.getConcretNumber(any))
        .thenAnswer((_) async => Right(tNumberTrvia));

    final result = await usecase(Params(number: tNumber));

    expect(result, Right(tNumberTrvia));
    verify(mockNumberTrviaRepository.getConcretNumber(tNumber));
    verifyNoMoreInteractions(mockNumberTrviaRepository);
  });
}
