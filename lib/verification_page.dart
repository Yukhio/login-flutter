import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final String phoneNumber; // Recibimos el número de teléfono del usuario

  const VerificationPage({super.key, required this.phoneNumber});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController codeController = TextEditingController();
  String accessCode = ''; // Aquí almacenamos el código de acceso generado

  @override
  void initState() {
    super.initState();
    accessCode = generateAccessCode(); // Generamos el código de acceso
    sendMessage(widget.phoneNumber, accessCode); // Enviamos el código por mensaje
  }

  // Generación de un código aleatorio de 6 dígitos
  String generateAccessCode() {
    return (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
  }

  // Función para enviar un mensaje con el código (simulación de mensaje)
  void sendMessage(String phoneNumber, String code) {
    // Aquí es donde integrarías tu servicio de mensajería, como Twilio o cualquier otro servicio
    if (kDebugMode) {
      print("Mensaje enviado a $phoneNumber: Tu código es $code");
    }
  }

  // Verificación del código ingresado
  void verifyCode() {
    if (codeController.text == accessCode) {
      // Si el código es correcto
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessPage(),
        ),
      );
    } else {
      // Si el código es incorrecto
      showErrorDialog("Código incorrecto. Por favor intenta de nuevo.");
    }
  }

  // Mostrar un cuadro de diálogo de error
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Verificación de Código",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Ingresar código
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    labelText: "Código de acceso",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingresa el código";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Botón de verificación
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Verificar Código",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Página de éxito después de una verificación exitosa
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("¡Éxito!")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text("Código verificado exitosamente", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
