import 'package:flower_app/pages/login.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(93, 64, 55, 1),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 250,
                    width: 300,
                    child: Image.asset('assets/imgs/watch-house.png')),
                ),
                const SizedBox(height: 50,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: const ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(200, 10)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.black)),
                    child: const Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),

                            const SizedBox(height: 10,),
                            
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 10)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.black)),
                    child: const Text('Create Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
                            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
