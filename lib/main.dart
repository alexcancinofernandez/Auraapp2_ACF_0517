import 'package:flutter/material.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // Fondo negro absoluto
        fontFamily: 'Roboto',
      ),
      home: const WorkoutSessionScreen(),
    );
  }
}

class WorkoutSessionScreen extends StatelessWidget {
  const WorkoutSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // --- 1. ENCABEZADO SUPERIOR (Entreno - Timer - Botón Termina) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Lado Izquierdo: Triángulo invertido + Texto
                  Row(
                    children: const [
                      Icon(Icons.arrow_drop_down, color: Colors.white, size: 30), // Triángulo invertido
                      SizedBox(width: 4),
                      Text(
                        "Entreno",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Lado Derecho: Reloj + Botón Termina
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: Colors.white, size: 24),
                      const SizedBox(width: 15),
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent, // Color Azul
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text("Termina"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // --- 2. ESTADÍSTICAS GENERALES (Duración, Volumen, Series) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn("Duracion", "5min 51 s"),
                  _buildStatColumn("Volumen", "1000kg"),
                  _buildStatColumn("Series", "16"),
                ],
              ),

              const SizedBox(height: 15),
              const Divider(color: Colors.white24, thickness: 1), // Línea delgada
              const SizedBox(height: 20),

              // --- 3. EJERCICIO 1: JALÓN AL PECHO ---
              const ExerciseSection(
                exerciseName: "Jalon al pecho (Maquina)",
                imageUrl: "https://github.com/alexcancinofernandez/Auraapp2_ACF_0517/blob/main/jalon.jpg?raw=true", // Imagen web representativa
                startWeight: 100,
              ),

              const SizedBox(height: 40), // Espacio entre ejercicios
              const Divider(color: Colors.white24, thickness: 1),
              const SizedBox(height: 20),

              // --- 4. EJERCICIO 2: REMO SENTADO ---
              // Reutilizamos el mismo widget pero cambiamos los datos
              const ExerciseSection(
                exerciseName: "Remo sentado en Maquina",
                imageUrl: "https://github.com/alexcancinofernandez/Auraapp2_ACF_0517/blob/main/remo.jpg?raw=true", // Imagen web representativa
                startWeight: 80, // Un peso diferente para variar
              ),
              
              const SizedBox(height: 50), // Espacio final para scroll
            ],
          ),
        ),
      ),
    );
  }

  // Helper para las columnas de estadísticas (Duración, Volumen, etc)
  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// --- WIDGET PRINCIPAL DEL EJERCICIO (REUTILIZABLE) ---
class ExerciseSection extends StatelessWidget {
  final String exerciseName;
  final String imageUrl;
  final double startWeight;

  const ExerciseSection({
    super.key,
    required this.exerciseName,
    required this.imageUrl,
    required this.startWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Cabecera del Ejercicio (Imagen + Título + Puntos)
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey[800], // Fondo por si falla la carga
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                exerciseName,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(Icons.more_vert, color: Colors.white), // Tres puntitos
          ],
        ),

        const SizedBox(height: 10),

        // 2. Notas
        const Padding(
          padding: EdgeInsets.only(left: 65.0), // Indentado para alinear con texto
          child: Text("agregar notas aqui ...", style: TextStyle(color: Colors.grey, fontSize: 14)),
        ),

        const SizedBox(height: 15),

        // 3. Timer de Descanso
        Row(
          children: const [
            Icon(Icons.timer, color: Colors.white70, size: 20),
            SizedBox(width: 8),
            Text("Descanso: 2min 0s", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),

        const SizedBox(height: 15),

        // 4. TABLA DE SERIES
        // Encabezados
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              _headerText("serie", width: 40),
              _headerText("Anterior", flex: 2),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.fitness_center, color: Colors.grey, size: 14),
                    SizedBox(width: 4),
                    Text("kg", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              _headerText("Reps", flex: 2),
            ],
          ),
        ),
        
        const SizedBox(height: 10),

        // Filas de datos (Generamos 4 filas como pediste)
        // Fila 1 (Específica)
        ExerciseSetRow(index: 1, prev: "60kgX10", weight: startWeight, reps: 6),
        // Fila 2 (Ascendente)
        ExerciseSetRow(index: 2, prev: "65kgX10", weight: startWeight + 5, reps: 8),
        // Fila 3 (Ascendente)
        ExerciseSetRow(index: 3, prev: "70kgX8", weight: startWeight + 10, reps: 10),
        // Fila 4 (Ascendente)
        ExerciseSetRow(index: 4, prev: "75kgX6", weight: startWeight + 15, reps: 12),

        const SizedBox(height: 15),

        // 5. Botón Agregar Serie
        Center(
          child: SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("+ agregar serie", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerText(String text, {double? width, int? flex}) {
    Widget child = Text(
      text, 
      style: const TextStyle(color: Colors.grey, fontSize: 12),
      textAlign: TextAlign.center,
    );
    
    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex ?? 1, child: child);
  }
}

// --- WIDGET DE LA FILA (Para manejar el estado del botón Check) ---
class ExerciseSetRow extends StatefulWidget {
  final int index;
  final String prev;
  final double weight;
  final int reps;

  const ExerciseSetRow({
    super.key,
    required this.index,
    required this.prev,
    required this.weight,
    required this.reps,
  });

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  bool isCompleted = false; // Estado local: si la serie está completada o no

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.transparent, // Sutil fondo verde al completar
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 1. Numero de Serie
          SizedBox(
            width: 40,
            child: Center(
              child: Container(
                width: 24, height: 24,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[900]),
                child: Center(child: Text("${widget.index}", style: const TextStyle(color: Colors.white, fontSize: 12))),
              ),
            ),
          ),
          
          // 2. Anterior
          Expanded(
            flex: 2,
            child: Text(
              widget.prev,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),

          // 3. Peso (Kg)
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  "${widget.weight.toInt()}", // Sin decimales
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // 4. Reps + Botón Confirmar
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text("${widget.reps}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // --- BOTÓN DE CONFIRMACIÓN (Interactivo) ---
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCompleted = !isCompleted; // Alternar estado
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.green : Colors.grey[700], // Cambio de color
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}