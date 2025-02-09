import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/services/System/socket_service.dart';
import 'package:realtime_chat/widgets/boton_azul.dart';

import 'package:realtime_chat/services/System/auth_service.dart';
import 'package:realtime_chat/helpers/show_alert.dart';

import 'package:realtime_chat/widgets/custom_input.dart';
import 'package:realtime_chat/widgets/labels.dart';
import 'package:realtime_chat/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(
                  titulo: 'Chat DHV',
                ),
                _Form(),
                const Labels(
                  ruta: 'register',
                  footText: '¿No tienes cuenta?',
                  footText2: '¡Registrate aquí!',
                ),
                GestureDetector(
                  child: const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),

          // TODO: Crear button
          BotonAzul(
            buttonText: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                        if (loginOk) {
                          socketService.connect();
                          Navigator.pushReplacementNamed(context, 'home');

                        } else {
                          // Mostrar alerta
                          mostrarAlerta(context, "Login Incorrecto", "Estas credenciales no corresponden a nuestros registros.");
                        }
                  },
          )
        ],
      ),
    );
  }
}
