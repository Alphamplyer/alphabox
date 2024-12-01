import 'package:alphabox/shared/enum/sorting_order.dart';

class SortingMethod<T1, T2> {
  final String name;
  final int Function(T1, T2) _compareFunction;

  SortingMethod({
    required this.name,
    required int Function(T1, T2) compareFunction,
  }) : _compareFunction = compareFunction;

  int compare(T1 a, T2 b, SortingOrder sortingOrder) {
    int result = _compareFunction(a, b);
    return sortingOrder == SortingOrder.asc ? result : -result;
  }  
}
