import 'package:flutter/material.dart';

Widget googleLogin(funtionAct) => InkWell(
    onTap: funtionAct,
    child: Ink(
      color: const Color(0xFF397AF3),
      child:Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                    'assets/images/google_PNG19635.png',
                    width: 50,
                    fit:BoxFit.fill
                ),
              ),// <-- Use 'Image.asset(...)' here
              const SizedBox(width: 12),
              const Text(
                'Login com a Conta da Google',
                style: TextStyle(
                  color:Colors.white
                )
              ),
            ],
          ),
        ),
      ),
  );