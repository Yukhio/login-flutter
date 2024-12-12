import 'package:flutter/material.dart';
import 'package:login_flutter/assign_position_page.dart';
import 'core/core_datasources/models/database_helper.dart';


Future<void> main() async {
  runApp(const MyApp());

  try {
    print('Intentando conectar a la base de datos...');
    var connection = await DatabaseHelper.getConnection();
    print('Conexión exitosa');
    
    // Opcional: Ejecutar una consulta para confirmar
    var results = await connection.query('SELECT * FROM S_Coordenadas');
    for (var row in results) {
      print('Fecha y hora desde la base de datos: ${row[0]}');
    }
    
    await connection.close();
  } catch (e) {
    print('Error al conectar: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;


  // Simulated user credentials
  final String correctEmail = "main@alfapcsmax.com";
  final String correctPassword = "123";


  void login() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      if (email == correctEmail && password == correctPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OptionsPage()),
        );
      } else {
        showErrorDialog("Correo o contraseña incorrectos");
      }
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[100],
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (imagen desde assets)
              ClipOval(
  child: Image.asset(
    'assets/logh.png', // Ruta de tu imagen
    width: 80, // Tamaño de la imagen
    height: 80, // Tamaño de la imagen
    fit: BoxFit.cover, // Ajuste de la imagen para que cubra el área circular
  ),
),

              const SizedBox(height: 40),
              // Card with form
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Inicia sesión",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email input
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Correo",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor ingresa tu correo";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return "Ingresa un correo válido";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Password input
                        TextFormField(
  controller: passwordController,
  obscureText: _obscureText, // Usa la variable en lugar de true
  decoration: InputDecoration(
    labelText: "Contraseña",
    prefixIcon: const Icon(Icons.lock),
    border: const OutlineInputBorder(),
    suffixIcon: IconButton( // Agrega el botón para mostrar/ocultar
      icon: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    ),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingresa tu contraseña";
    }
    return null;
  },
),
                        const SizedBox(height: 20),
                        // Login button
                        ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255,0,53,103),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}

//Apartado de los botones a seleccionar
class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255,0,53,103),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50), // Botón de ancho completo
                ),
                child: const Text(
                  "Escaner",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AssignPositionPage()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255,0,53,103),
      padding: const EdgeInsets.symmetric(vertical: 15),
      minimumSize: const Size(double.infinity, 50), // Botón de ancho completo
    ),
    child: const Text(
      "Asignar posición",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}