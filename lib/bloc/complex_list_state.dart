import 'package:equatable/equatable.dart';
import '../entities/Books.dart';

enum ListStatus { loading, success, failure }

final class HomeFragmentState extends Equatable {
  const HomeFragmentState._({
    this.status = ListStatus.loading,
    this.items = const <BooksDatum>[],
  });

  const HomeFragmentState.loading() : this._();

  const HomeFragmentState.success(List<BooksDatum> items) : this._(status: ListStatus.success, items: items);

  const HomeFragmentState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<BooksDatum> items;

  @override
  List<Object> get props => [status, items];
}
