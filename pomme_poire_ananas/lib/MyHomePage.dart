import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<int> _fruits = [];
  bool _isPair = false;
  bool _isClicked = false;

  bool _isPrime(int number) {
    if (number <= 1) {
      return false;
    }
    for (int i = 2; i <= number / 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  String _numberType(int number) {
    if (_isPrime(number)) {
      return 'Nombre premier';
    } else if (_numberIsPair(number)) {
      return 'Nombre pair';
    } else {
      return'Nombre impair';
    }
  }

  bool _numberIsPair(int number) {
    return number % 2 == 0;
  }

  Color _getColor(bool isPair) {
    return isPair ? Colors.indigo : Colors.cyan;
  }
  
  Image _getImage(int fruit, bool isPair) {
    if (_isPrime(fruit)) {
      return Image.asset('images/ananas.png', width: 100, height: 100);
    } else if (isPair) {
      return Image.asset('images/poire.png', width: 100, height: 100);
    } else {
      return Image.asset('images/pomme.png', width: 100, height: 100);
    }
  }

  void _incrementCounter() {
    setState(() {
      _isClicked = true;
      _isPair = _numberIsPair(_counter);
      _counter++;
      _fruits.add(_counter);
    });
  }

  Future<void> _showAlert(int fruit, bool isPair, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text(
          '$fruit : ${_numberType(fruit)}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: _getColor(isPair),
        content: _getImage(fruit, isPair),
        actions: [
          IconButton(
            color: Colors.white,
            tooltip: 'Delete',
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _fruits.removeAt(index);
              });
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            color: Colors.white,
            tooltip: 'Close',
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _fruits.length,
      itemBuilder: (BuildContext context, int index) {
        int fruit = _fruits[index];
        bool isPair = _numberIsPair(fruit);
        return Container(
          color: _getColor(isPair),
          child: ListTile(
            textColor: Colors.white,
            leading: _getImage(fruit, isPair),
            title: Text('$fruit'),
            onTap: () { _showAlert(fruit, isPair, index);
            },
          )
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isClicked ? Text('$_counter : ${_numberType(_counter)}') : Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: _buildListView()
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isClicked ? _getColor(_isPair) : Colors.orange,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
