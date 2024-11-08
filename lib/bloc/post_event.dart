part of 'post_bloc.dart';

sealed class BooksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BooksFetched extends BooksEvent {}

class SearchBooks extends BooksEvent {
  SearchBooks({required this.search});
  final String search;
}
