import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black, backgroundColor: Colors.white),
        ),
        home: const RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(title: Text(pair.asPascalCase));
      });
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
          appBar: AppBar(title: const Text("Saved")),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome To Flutter"),
          actions: [
            IconButton(
                onPressed: _pushSaved,
                icon: const Icon(Icons.list),
                tooltip: "Saved"),
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(24.0),
            itemBuilder: (context, index) {
              if (_suggestions.length <= index) {
                _suggestions.addAll(generateWordPairs().take(10));
              }
              final saved = _saved.contains(_suggestions[index]);

              return ListTile(
                title: Text(
                  _suggestions[index].asPascalCase,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: Icon(
                  saved ? Icons.favorite : Icons.favorite_border,
                  color: saved ? Colors.red : null,
                  semanticLabel: saved ? "Remove" : "Save",
                ),
                onTap: () {
                  setState(() {
                    if (saved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                },
              );
            }));
  }
}
