import 'package:flutter/material.dart';
import 'package:flutter_2/entities/Books.dart';

class FragmentDetails extends StatefulWidget {
  const FragmentDetails({super.key, required this.bookData});

  final BooksDatum bookData;

  @override
  State<FragmentDetails> createState() => _FragmentDetails(bookData);
}

class _FragmentDetails extends State<FragmentDetails> {
  BooksDatum bookData;

  _FragmentDetails(this.bookData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FragmentDetails'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text("FragmentDetails"),
          Text(bookData.attributes?.title ?? ""),
          Image.network(bookData.attributes?.cover ?? "", scale: 10.0, frameBuilder: (context, child, frame, _) {
            if (frame == null) {
              return CircularProgressIndicator();
            }
            return child;
          }, ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ],
      )),
    );
  }
}
