import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PasswordEmailResetPage extends StatelessWidget {
  const PasswordEmailResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Expanded(
              child: LoginWidget(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is ResetEmailSent) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reset email sent. Check your inbox.'),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, '/login');
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
                          'Enter the email to reset your password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 1, bottom: 20),
                          child: TextField(
                            autocorrect: false,
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                                child: Icon(Icons.email_outlined),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              final email = emailController.text;
                              if (email.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter your email'),
                                  ),
                                );
                                return;
                              }
                              context.read<AuthBloc>().add(
                                    ForgotPasswordEvent(email: email),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50.0),
                              textStyle: const TextStyle(color: Colors.black),
                              backgroundColor:
                                  const Color(0xFFFFC129), // Yellow color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 10,
                              shadowColor: Colors.black, // Shadow color
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Send Reset Email',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 10.0),
                                Icon(Icons.send_rounded, color: Colors.black, size: 20,),
                              ],
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
