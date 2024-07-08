import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Expanded(
              child: LoginWidget(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is FirstTimeLogin) {
                      Navigator.pushReplacementNamed(
                          context, '/reset-password');
                    } else if (state is StudentAuthenticated) {
                      Navigator.pushReplacementNamed(context, '/student');
                    } else if (state is CanteenAAuthenticated) {
                      Navigator.pushReplacementNamed(context, '/canteenA');
                    } else if (state is CanteenBAuthenticated) {
                      Navigator.pushReplacementNamed(context, '/canteenB');
                    } else if (state is AuthStateError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
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
                            controller: userNameController,
                            decoration: InputDecoration(
                              hintText: 'Username',
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
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Icon(Icons.email),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 0, bottom: 20),
                          child: TextField(
                            autocorrect: false,
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
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
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Icon(Icons.lock),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40), 
                          child: ElevatedButton(
                            onPressed: () {
                              final email = userNameController.text;
                              final password = passwordController.text;

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('All fields are required')),
                                );
                                return;
                              }

                              context.read<AuthBloc>().add(
                                    LoggedInEvent(
                                      username: email,
                                      password: password,
                                    ),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50.0), //
                              backgroundColor:
                                  const Color(0xFFFFC129), // Yellow color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 10,
                              shadowColor: Colors.black, // Shadow color
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/reset-pw');
                          },
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
