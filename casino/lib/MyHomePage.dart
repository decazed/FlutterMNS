import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _images = [
    'images/bar.png',
    'images/cerise.png',
    'images/cloche.png',
    'images/diamant.png',
    'images/fer-a-cheval.png',
    'images/pasteque.png',
    'images/sept.png',
  ];

  List<String> _currentImages = [];
  bool _isWin = false;
  bool _isJackpot = false;
  late ConfettiController _confettiController;
  bool _isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _generateRandomImages();
  }

  void _generateRandomImages() {
    final random = Random();
    _currentImages = [];

    for (int i = 0; i < 3; i++) {
      final randomIndex = random.nextInt(_images.length);
      final randomImage = _images[randomIndex];
      _currentImages.add(randomImage);
    }

    _checkWin();
  }


  void _checkWin() {
    setState(() {
      _isWin = _currentImages[0] == _currentImages[1] && _currentImages[1] == _currentImages[2];
      _isJackpot = _isWin && _currentImages[0] == 'images/sept.png';
      if (_isWin) {
        _isButtonEnabled = false;
        _confettiController.play();
        Timer(const Duration(seconds: 2), () {
          setState(() {
            _isButtonEnabled = true;
          });
        });
      }
    });
  }

  Widget _buildPlayButton() {
    return ElevatedButton(
      onPressed: _isButtonEnabled ? _generateRandomImages : null,
      child: const Text('Play'),
    );
  }

  Widget _buildConfetti() {
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirection: -pi / 2,
      maxBlastForce: 100,
      minBlastForce: 80,
      emissionFrequency: 0.05,
      numberOfParticles: 20,
      gravity: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(_currentImages[0], width: 100, height: 100),
                Image.asset(_currentImages[1], width: 100, height: 100),
                Image.asset(_currentImages[2], width: 100, height: 100),
              ],
            ),
            const SizedBox(height: 32),
            _buildPlayButton(),
            const SizedBox(height: 16),
            Text(
              _isJackpot ? 'JACKPOT JACKPOT JACKPOT' : _isWin ? 'Jackpot !' : 'You lost, try again!',
              style: TextStyle(
                fontSize: _isJackpot ? 48 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            _isWin ? _buildConfetti() : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}