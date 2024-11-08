import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2/bloc/simple_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fragments/FragmentHome.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(App());
}

class App extends MaterialApp {
  App({super.key})
      : super(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const FragmentHomePage());
}
