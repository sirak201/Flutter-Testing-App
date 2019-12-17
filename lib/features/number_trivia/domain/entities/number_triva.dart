// {
// "text": "42 is the number of spots (or pips, circular patches or pits) on a pair of standard six-sided dice.",
// "number": 42,
// }

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTriva extends Equatable {
  final String text;
  final int number;

  NumberTriva({@required this.text, @required this.number})
      : super([text, number]);
}
