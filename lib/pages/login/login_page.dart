import '../../bloc/bloc.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
        Expanded(
          child: LoginWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Log in to Easy Coupon',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 1, bottom: 20),
                  child: TextField(
                    autocorrect: false,
                    controller: emailC,
                    decoration: InputDecoration(
                      hintText: 'Enter the Email',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 158, 154, 154),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Icon(Icons.email),
                      ),

                      alignLabelWithHint: true, // Center the hint text
                    ),
                    // textAlign: TextAlign.center, // Center the input text
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 0, bottom: 20),
                  child: TextField(
                    autocorrect: false,
                    controller: passC,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter the Password',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 158, 154, 154),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Icon(Icons.lock),
                      ),

                      alignLabelWithHint: true, // Center the hint text
                    ),
                    // textAlign: TextAlign.center, // Center the input text
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 40),  // button responsive
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login actio
                      context.read<AuthBloc>().add(
                            AuthEventLogin(emailC.text, passC.text),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),  //
                      backgroundColor: const Color(0xFFFFC129), // Yellow color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 10, // Add shadow to the button
                      shadowColor: Colors.black, // Shadow color
                    ),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthStateLogin) {
                          Navigator.pushReplacementNamed(context, '/student');
                        }
                        if (state is AuthStateError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthStateLoading) {
                          return const SizedBox(
                            width: 100, // Set a fixed width
                            child: Center(
                              child: Text(
                                "LOADING...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          );
                        }
                        return const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                TextButton(
                      onPressed: () {
                        // Handle forget password action

                        Navigator.pushReplacementNamed(context, '/reset');
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],),
    );
  }
}
