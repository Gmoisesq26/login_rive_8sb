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

//Creamos un cerebro de las animaciones de Rive
  StateMachineController? _controller;
  //SMI: State Machine Input
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _isTrigSuccess;
  SMITrigger? _isTrigFail;

//1.1 Crear variables para focusNode
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

//1.2 Crear los listeners
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        //verifica que no sea nulo
        if (_isHandsUp != null) {
          //manos ariba en el email
          _isHandsUp!.change(false);
        }
      }
    });
    _passwordFocusNode.addListener(() {
      //Manos ariva en password
      _isHandsUp?.change(_passwordFocusNode.hasFocus);
    });
  }

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
              child: RiveAnimation.asset(
                'assets/login_bear.riv',
                stateMachines: ['Login Machine'],

                //Al iniciar la  ainmacion
                onInit: (artboard) {
                  _controller = StateMachineController.fromArtboard(
                    artboard,
                    'Login Machine',
                  );

                  //verificamos que todo este bien
                  if (_controller == null) return;

                  //Agregamos el controlador al artboard
                  artboard.addController(_controller!);

                  //vinculamos las variables de la animacion con las variables de flutter
                  _isChecking = _controller?.findSMI('isChecking');
                  _isHandsUp = _controller?.findSMI('isHandsUp');
                  _isTrigSuccess = _controller?.findSMI('trigSuccess');
                  _isTrigFail = _controller?.findSMI('trigFail');
                },
              ),
            ),

            //para separar los widgets
            const SizedBox(height: 10),
            //campo de texto para el email
            TextField(
              //1.3 Agregar focusNode al TextField
              focusNode: _emailFocusNode,
              onChanged: (value) {
                if (_isHandsUp != null) {
                  //No se tapa los ojos
                  //_isHandsUp!.change(false);
                }
                //si ischecking es nulo
                if (_isChecking == null) return;
                //activar
                _isChecking!.change(true);
              },
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
            //campo de texto para el password
            TextField(
              //1.3 Campo de texto para el password
              focusNode: _passwordFocusNode,
              onChanged: (value) {
                if (_isHandsUp != null) {
                  //No se tapa los ojos
                  //_isHandsUp!.change(true);
                }
                //si ischecking es nulo
                if (_isChecking == null) return;
                //activar
                _isChecking!.change(false);
              },
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

  @override
  void dispose() {
    //1.4 Liberar memoria de los focusNode(al salir de la pantalla)
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
