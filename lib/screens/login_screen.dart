import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
//control para mostrar/ocultar contraseña
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    //Para obtener el tamaño de la pantalla
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
                height: 200,
                width: size.width,
                child: const RiveAnimation.asset('login_bear.riv')),
            //para separar los widgets
            const SizedBox(height: 10),
            //campo de texto para el email
            TextField(
              //para mostrar un tipo de teclado
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  //Borde redondeado
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            //para separar los widgets
            const SizedBox(height: 10),
            //campo de texto para el email
            TextField(
              //para mostrar un tipo de teclado.
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    //if Icon
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      //refresca el icono
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    }),
                border: OutlineInputBorder(
                  //Borde redondeado
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
