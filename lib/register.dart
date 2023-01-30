import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:biscotto/login.dart';

class Register extends HookWidget {
  const Register({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final _confirmPasswordController = useTextEditingController();
    var confirmPassword;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(112, 31, 21, 1),
        automaticallyImplyLeading: false,
        title: Text(
          'Biscotto',
          style: Theme.of(context).textTheme.headline2?.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                  'https://images.pexels.com/photos/1865131/pexels-photo-1865131.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  fit: BoxFit.cover,
              ),
              Padding(padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100
                ),
              ),
              Padding(padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: TextFormField(
                controller: _emailController,
                autofocus: true,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ ne peut être vide';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!emailValid) {
                    return 'Email invalide';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 223, 223, 223),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 112, 31, 21),
                  ),
                ),
                // style: Theme.of(context).textTheme.headline1
                // //TODO ACN add font-family,
                keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                child: TextFormField(
                  controller: _passwordController,
                  autofocus: true,
                  obscureText: true,
                  validator: (value) {
                  confirmPassword = value;
                  if (value == null || value.isEmpty) {
                    return 'Ce champ ne peut être vide';
                  }
                  if (value.length < 6) {
                    return "Le mot de passe doit contenir au moins 6 charactères";
                  }
                  return null;
                },
                  decoration: InputDecoration(
                    hintText: 'Mot de passe',
                    // hintStyle: Theme.of(context).textTheme.headline1,
                    //TODO ACN add font-family
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 223, 223, 223),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 112, 31, 21),
                    ),
                  ),
                  // style: Theme.of(context).textTheme.headline1,
                  //TODO ACN add font-family
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  autofocus: true,
                  obscureText: true,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ ne peut être vide';
                  }
                  if (value != confirmPassword) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
                  decoration: InputDecoration(
                    hintText: 'Confirmer mot de passe',
                    // hintStyle: Theme.of(context).textTheme.headline1,
                    //TODO ACN add font-family
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 223, 223, 223),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 112, 31, 21),
                    ),
                  ),
                  // style: Theme.of(context).textTheme.headline1,
                  //TODO ACN add font-family
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_emailController.text);
                      print(_passwordController.text);
                      print(_confirmPasswordController.text);
                      print(confirmPassword);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF701F15),
                    side: const BorderSide(
                      width: 1,
                      color:Colors.brown
                      ), 
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.all(20)
                  ),
                  child: Text(
                    "Créer un compte",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                      color:  Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Déjà un compte ?',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                          //TODO ACN add font-family
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                        },
                        child: Text(
                          'Connecter vous',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            decoration: TextDecoration.underline,
                            color: const Color(0xFF701F15),
                          ),
                            //TODO ACN add font-family
                        ),
                      ),
                    ],
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