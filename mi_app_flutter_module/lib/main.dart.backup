import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() {
  runApp(const ColorPaletteApp());
}

class ColorPaletteApp extends StatelessWidget {
  const ColorPaletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de Paletas',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const PaletteGeneratorPage(),
    );
  }
}

class PaletteGeneratorPage extends StatefulWidget {
  const PaletteGeneratorPage({super.key});

  @override
  State<PaletteGeneratorPage> createState() => _PaletteGeneratorPageState();
}

class _PaletteGeneratorPageState extends State<PaletteGeneratorPage> {
  List<Color> _colorPalette = _generateRandomPalette();

  static List<Color> _generateRandomPalette() {
    final RandomColor randomColor = RandomColor();
    final List<Color> palette = [];
    for (int i = 0; i < 5; i++) {
      palette.add(
        randomColor.randomColor(
          colorHue: ColorHue.random,
          colorSaturation: ColorSaturation.random,
        ),
      );
    }
    return palette;
  }

  void _updatePalette() {
    setState(() {
      _colorPalette = _generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de Paletas 🎨'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _colorPalette.length,
              itemBuilder: (context, index) {
                return ColorDisplay(color: _colorPalette[index]);
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(20.0)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _updatePalette,
        label: const Text('Generar Nueva Paleta'),
        icon: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ColorDisplay extends StatelessWidget {
  final Color color;

  const ColorDisplay({super.key, required this.color});

  String _toHexString(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: color,
      child: Center(
        child: Text(
          _toHexString(color),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
