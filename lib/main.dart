import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

// El punto de entrada de nuestra aplicación
void main() {
  runApp(const ColorPaletteApp());
}

// El widget principal de la aplicación, es Stateless porque no cambia su propio estado.
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
      // Ocultamos la cinta de "Debug" en la esquina
      debugShowCheckedModeBanner: false,
      home: const PaletteGeneratorPage(), // La pantalla principal de la app
    );
  }
}

// Este es nuestro widget principal, es Stateful porque su estado (la lista de colores) cambia.
class PaletteGeneratorPage extends StatefulWidget {
  const PaletteGeneratorPage({super.key});

  @override
  State<PaletteGeneratorPage> createState() => _PaletteGeneratorPageState();
}

// El estado de nuestro widget Stateful. Aquí vive la lógica.
class _PaletteGeneratorPageState extends State<PaletteGeneratorPage> {
  // 2. Definimos una lista para almacenar nuestra paleta de colores.
  // La inicializamos con 5 colores al azar para empezar.
  List<Color> _colorPalette = _generateRandomPalette();

  // 3. Método para generar una nueva paleta de 5 colores.
  static List<Color> _generateRandomPalette() {
    final RandomColor randomColor = RandomColor(); // Instancia del paquete
    final List<Color> palette = [];
    for (int i = 0; i < 5; i++) {
      palette.add(randomColor.randomColor(
        colorHue: ColorHue.random, // Tonalidad aleatoria
        colorSaturation: ColorSaturation.random, // Saturación aleatoria
      ));
    }
    return palette;
  }

  // 4. Método para actualizar la paleta y redibujar la UI.
  void _updatePalette() {
    // setState() notifica a Flutter que el estado ha cambiado y que debe reconstruir el widget.
    setState(() {
      _colorPalette = _generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold es el esqueleto básico de una página de Material Design.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de Paletas 🎨'),
        centerTitle: true,
      ),
      body: Column(
        // 5. El cuerpo de nuestra app es una columna.
        children: [
          // Expanded hace que este widget ocupe todo el espacio vertical disponible.
          Expanded(
            // ListView.builder es eficiente para listas porque solo dibuja los elementos visibles.
            child: ListView.builder(
              itemCount: _colorPalette.length, // La lista tiene 5 elementos
              itemBuilder: (context, index) {
                return ColorDisplay(color: _colorPalette[index]);
              },
            ),
          ),
          // Un padding para separar el botón del borde inferior.
          const Padding(
            padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
      // 6. El botón flotante para generar una nueva paleta.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _updatePalette, // Al presionarlo, llamamos a nuestro método
        label: const Text('Generar Nueva Paleta'),
        icon: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Un widget personalizado y reutilizable para mostrar cada color. Es Stateless.
class ColorDisplay extends StatelessWidget {
  final Color color;

  const ColorDisplay({super.key, required this.color});

  // Método para obtener el valor hexadecimal del color.
  String _toHexString(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    // Usamos un Container para darle un fondo de color y una altura fija.
    return Container(
      height: 100,
      color: color,
      // Centramos el texto dentro del contenedor.
      child: Center(
        child: Text(
          _toHexString(color), // Mostramos el código hexadecimal del color
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // Agregamos una sombra al texto para que sea legible sobre cualquier color.
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