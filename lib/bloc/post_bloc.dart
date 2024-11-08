import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_2/repository.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../entities/Books.dart';

part 'post_event.dart';

part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc({required this.httpClient}) : super(const BooksState()) {
    on<BooksFetched>(
      _onFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SearchBooks>(
      _onSearchFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onSearchFetched(
    SearchBooks event,
    Emitter<BooksState> emit,
  ) async {
    emit(state.copyWith(status: BooksStatus.initial));
    try {
      final booksList = await Repository().searchBooks(httpClient, event.search);
      if (booksList.isEmpty) {
        emit(BooksState(
          status: BooksStatus.success,
          books: booksList,
        ));
      } else {
        emit(BooksState(
          status: BooksStatus.success,
          books: booksList,
        ));
      }
    } catch (error) {
      developer.log(error.toString());
      emit(state.copyWith(status: BooksStatus.failure));
    }
  }

  Future<void> _onFetched(
    BooksFetched event,
    Emitter<BooksState> emit,
  ) async {
    try {
      final books = await Repository().fetchBooks(httpClient);
      if (books.isEmpty) {
        emit(state.copyWith());
      } else {
        emit(
          state.copyWith(
            status: BooksStatus.success,
            posts: [...state.books, ...books],
          ),
        );
      }
    } catch (error) {
      developer.log(error.toString());
      emit(state.copyWith(status: BooksStatus.failure));
    }
  }
}
