part of 'post_bloc.dart';

enum BooksStatus { initial, success, failure }

final class BooksState extends Equatable {
  const BooksState({
    this.status = BooksStatus.initial,
    this.books = const <BooksDatum>[]
  });

  final BooksStatus status;
  final List<BooksDatum> books;

  BooksState copyWith({
    BooksStatus? status,
    List<BooksDatum>? posts
  }) {
    return BooksState(
      status: status ?? this.status,
      books: posts ?? this.books
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, posts: ${books.length} }''';
  }

  @override
  List<Object> get props => [status, books];
}
