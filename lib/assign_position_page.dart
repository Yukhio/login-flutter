import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssignPositionPage extends StatefulWidget {
  const AssignPositionPage({super.key});

  @override
  State<AssignPositionPage> createState() => _AssignPositionPageState();
}

class _AssignPositionPageState extends State<AssignPositionPage> {
  // Lista para almacenar las posiciones seleccionadas
  List<String?> selectedPositions = List<String?>.filled(5, null);

  // Controla qué Dropdown está activo
  int? activeDropdownIndex;

  // Generar las opciones de la matriz 5x5
  List<List<String>> generateMatrix() {
    List<List<String>> matrix = [];
    for (int i = 0; i < 5; i++) {
      List<String> row = [];
      for (int j = 0; j < 5; j++) {
        row.add("Fila ${i + 1}, Col ${j + 1}");
      }
      matrix.add(row);
    }
    return matrix;
  }

  @override
  Widget build(BuildContext context) {
    final matrix = generateMatrix();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Asigna una posición al rollo"),
        titleTextStyle: const TextStyle(color: Color.fromARGB(255,0,53,103), fontSize: 20,),
        backgroundColor:  const Color.fromARGB(255, 241, 248, 255),
        systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF002B5C), // Color de la barra de estado
      statusBarIconBrightness: Brightness.light, // Color de los íconos de la barra de estado (claro u oscuro)
    ),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 248, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select para cada posición
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.5),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDropdownIndex = activeDropdownIndex == index ? null : index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedPositions[index] ?? "Fila ${index + 1}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  activeDropdownIndex == index ? Icons.expand_less : Icons.expand_more,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Matriz 5x5 para la posición seleccionada
                      if (activeDropdownIndex == index)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemCount: 25,
                            itemBuilder: (context, gridIndex) {
                              final row = gridIndex ~/ 5;
                              final col = gridIndex % 5;
                              final value = matrix[row][col];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPositions[index] = value;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedPositions[index] == value
                                        ? const Color.fromARGB(255,0,53,103)
                                        : Colors.white,
                                    border: Border.all(color: const Color.fromARGB(255,0,53,103)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: selectedPositions[index] == value ? Colors.white : const Color.fromARGB(255,0,53,103),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            // Botón para mostrar todas las selecciones
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Posiciones seleccionadas"),
                    content: Text(
                      selectedPositions
                          .where((pos) => pos != null)
                          .join("\n"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: const Text(
                "Siguiente",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
