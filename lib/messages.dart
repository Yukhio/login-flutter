import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendSms(String phoneNumber, String message) async {
  const String accountSid = 'AC7d564a2067158f7cd2228a79012fbe8e'; // Tu SID
  const String authToken = '2ecd343ef49065a8da1511e5316f05e2'; // Tu Token de autenticación
  const String twilioNumber = '523122090961'; // Tu número de Twilio

  // Endpoint de la API de Twilio para enviar mensajes
  final Uri uri = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/AC7d564a2067158f7cd2228a79012fbe8e/Messages.json');

  // Autenticación básica con SID y Token
  final String auth = 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}';

  // Hacer la solicitud HTTP POST
  final response = await http.post(
    uri,
    headers: {
      'Authorization': auth, // Autenticación con SID y Auth Token
    },
    body: {
      'From': twilioNumber, // El número de Twilio
      'To': phoneNumber, // El número del destinatario
      'Body': message, // El mensaje a enviar
    },
  );

  if (response.statusCode == 201) {
    print('Mensaje enviado exitosamente');
  } else {
    print('Error al enviar mensaje: ${response.body}');
  }
}
