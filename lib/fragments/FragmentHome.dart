import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../bloc/post_bloc.dart';
import '../entities/Books.dart';
import '../widgets/CardWidget.dart';
import 'FragmentDetails.dart';

class FragmentHomePage extends StatelessWidget {
  const FragmentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider provider = BlocProvider<BooksBloc>.value(
      value: BooksBloc(httpClient: http.Client())..add(BooksFetched()),
      child: FragmentHome(),
    );

    return Scaffold(body: provider);
  }
}

class FragmentHome extends StatefulWidget {
  const FragmentHome({super.key});

  @override
  State<FragmentHome> createState() => FragmentHomeState(title: "Антон Н. цпибв41");
}

class FragmentHomeState extends State<FragmentHome> {
  FragmentHomeState({required this.title});

  final String title;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(88.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Text("Антон Никитин цпибв41"),
              TextField(controller: myController),
              TextButton(
                  child: const Text('Search'),
                  onPressed: () {
                    makeSearch(myController.text);
                  })
            ]),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(child: BlocBuilder<BooksBloc, BooksState>(
              builder: (context, state) {
                switch (state.status) {
                  case BooksStatus.failure:
                    return const Center(child: Text('failed to fetch posts'));
                  case BooksStatus.success:
                    if (state.books.isEmpty) {
                      return const Center(child: Text('no posts'));
                    }
                    return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ItemTile(book: state.books[index]);
                        },
                        itemCount: state.books.length);

                  case BooksStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            )),
          ),
        ],
      ),
    );
  }

  void makeSearch(String text) {
    EasyDebounce.debounce(
        'my-debouncer',
        Duration(milliseconds: 1000),
        () => context
            .read<BooksBloc>()
            .add(SearchBooks(search: text)) // <-- The target method
        );
  }
}

class ItemView extends StatelessWidget {
  const ItemView({required this.items, super.key});

  final List<BooksDatum> items;

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(child: Text('No Content'))
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ItemTile(book: items[index]);
            },
            itemCount: items.length,
          );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({required this.book, super.key});

  final BooksDatum book;

  @override
  Widget build(BuildContext context) {
    var title = book.attributes?.title ?? "";
    var coverUrl = book.attributes?.cover ?? "";
    return Material(
        child: CardWidget(coverUrl, title, () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$coverUrl $title'),
      ));
    }, () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FragmentDetails(bookData: book)),
      );
    }));
  }
}
