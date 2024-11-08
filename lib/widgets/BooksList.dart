import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entities/Books.dart';
import '../fragments/FragmentDetails.dart';
import 'CardWidget.dart';

class BooksList extends StatelessWidget {
  const BooksList({super.key, required this.booksList});

  final List<BooksDatum> booksList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: booksList.length,
      itemBuilder: (context, index) {
        var book = booksList[index];

        var title = book.attributes?.title ?? "";
        var coverUrl = book.attributes?.cover ?? "";

        return CardWidget(coverUrl, title, () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$coverUrl $title'),
          ));
        }, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FragmentDetails(bookData: book)),
          );
        });
      },
    );
  }
}