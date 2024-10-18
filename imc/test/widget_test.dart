import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imc/BodyMassIndex.dart';

void main() {
  group('BodyMassIndex Tests', () {
    test('_calculateIMC returns correct value', () {
      final bodyMassIndex = BodyMassIndex();
      expect(bodyMassIndex.calculateIMC(1.50, 90), 40);
    });

    test('_getImcCategory returns correct category', () {
      final bodyMassIndex = BodyMassIndex();
      expect(bodyMassIndex.getImcCategory(18.4), 'underweight');
      expect(bodyMassIndex.getImcCategory(20.0), 'normal');
      expect(bodyMassIndex.getImcCategory(27.0), 'overweight');
      expect(bodyMassIndex.getImcCategory(35.0), 'obesity');
    });
  });
}
