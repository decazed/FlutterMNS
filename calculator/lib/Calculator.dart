import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});
  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _incrementValue = 2;
  double _res = 2.0;
  int _nbClick = 0;
  final List<String> _list = <String>['Add', 'Multiply', 'Substract', 'Divide'];
  String _selectedOperation = 'Add';
  String _operation = '+';

  void _calculate() {
    setState(() {
      switch (_selectedOperation) {
        case 'Add':
          _res = (_counter + _incrementValue) as double;
          _operation = '+';
          break;
        case 'Multiply':
          _res = (_counter * _incrementValue) as double;
          _operation = 'x';
          break;
        case 'Substract':
          _res = (_counter - _incrementValue) as double;
          _operation = '-';
          break;
        case 'Divide':
          if (_incrementValue != 0) {
            _res = _counter / _incrementValue;
            _operation = '/';
          } else {
            _res = (_counter + _incrementValue) as double;
            _operation = '+';
            _alertDivide();
          }
          break;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter += _incrementValue;
      _nbClick++;
      _calculate();
    });
  }

  void _updateIncrementValue(String value) {
    setState(() {
      int newValue = int.tryParse(value) ?? _incrementValue;
      if (newValue == 0) {
        _incrementValue = 1;
        _calculate();
        _alertValue();
      } else {
        _incrementValue = newValue;
        _calculate();
      }
    });
  }

  void _selectOperation(String? value) {
    setState(() {
      if (value != null) {
        _selectedOperation = value;
        _calculate();
      }
    });
  }

  void _alertValue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erreur"),
          content: const Text("La valeur de l'incrément ne doit pas être inférieure à 1"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _alertDivide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erreur"),
          content: const Text("Un nombre ne peut pas être divisé par 0"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetAll() {
    setState(() {
      _counter = 0;
      _incrementValue = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                _resetAll();
              },
              tooltip: "Reset counter and increment value",
              icon: const Icon(Icons.replay_circle_filled_rounded,
              ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedOperation,
              onChanged: _selectOperation,
              items: _list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: "Increment (=$_incrementValue)",
              ),
              onChanged: _updateIncrementValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_counter $_operation $_incrementValue = ',
                ),
                Text(
                  '$_res',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            if (_nbClick >= 1)
              Text(
                'Vous avez cliqué $_nbClick fois',
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Text('+$_incrementValue'),
      ),
    );
  }
}
