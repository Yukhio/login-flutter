import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

Future<void> sendEmail(String email, String accessCode) async {
  // ignore: deprecated_member_use
  final smtpServer = gmail('', ''); // Cambia por tu cuenta y contraseña

  final message = Message()
    ..from = const Address('', '')
    ..recipients.add(email)
    ..subject = 'Código de acceso'
    ..text = 'Tu código de acceso es: $accessCode';

  try {
    final sendReport = await send(message, smtpServer);
    print('Correo enviado: $sendReport');
  } catch (e) {
    print('Error al enviar el correo: $e');
  }
}

String generateAccessCode() {
  final random = Random();
  return (random.nextInt(900000) + 100000).toString();
}
