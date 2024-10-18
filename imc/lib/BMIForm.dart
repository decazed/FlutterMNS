import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'BodyMassIndex.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIForm extends StatefulWidget {
  const BMIForm({super.key, required this.title});
  final String title;

  @override
  State<BMIForm> createState() => _BMIFormState();
}

class _BMIFormState extends State<BMIForm> {
  String _imcCategory = '';
  double _imcValue = 0.0;
  double _height = 0.0;
  double _weight = 0.0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final BodyMassIndex bodyMassIndex = BodyMassIndex();

  void _getFormValues() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _height = double.parse(_heightController.text) / 100;
        _weight = double.parse(_weightController.text);
        _imcValue = bodyMassIndex.calculateIMC(_height, _weight);
        _imcCategory = bodyMassIndex.getImcCategory(_imcValue);
      });
    }
  }

  Widget _buildBMIForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _getFormValues,
              child: const Text('Calculate IMC'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String imcCategory) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('IMC category : $imcCategory'),
      ],
    );
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 40, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 18.5,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 18.5,
                endValue: 25,
                color: Colors.yellow,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 25,
                endValue: 30,
                color: Colors.orange,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 30,
                endValue: 40,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10)
          ], pointers: <GaugePointer>[
            NeedlePointer(value: _imcValue)
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Text(_imcValue.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.5)
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBMIForm(),
            _buildCategory(_imcCategory),
            _getRadialGauge(),
          ],
        ),
      ),
    );
  }
}