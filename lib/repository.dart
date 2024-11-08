import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'entities/Books.dart';

class Repository {

  Future<List<BooksDatum>> searchBooks(http.Client client, String query) async {
    final response = await client.get(Uri.parse('https://api.potterdb.com/v1/books?filter[title_cont]=$query'));
    return compute(parseBooks, response.body);
  }

  Future<List<BooksDatum>> fetchBooks(http.Client client) async {
    final response = await client.get(Uri.parse('https://api.potterdb.com/v1/books'));
    return compute(parseBooks, response.body);
  }

  List<BooksDatum> parseBooks(String responseBody) {
    final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
    return Books.fromJson(parsed).booksList ?? <BooksDatum>[];
  }

  void searchBook(String text) {

  }
}
