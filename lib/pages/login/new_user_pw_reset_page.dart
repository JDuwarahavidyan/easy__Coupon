import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewUserPwResetPage extends StatefulWidget {
  const NewUserPwResetPage({super.key});

  @override
  State<NewUserPwResetPage> createState() => _NewUserPwResetPageState();
}

class _NewUserPwResetPageState extends State<NewUserPwResetPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Expanded(
              child: LoginWidget(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is PasswordUpdated) {
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
                          'Reset your password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 1, bottom: 10),
                          child: TextField(
                            autocorrect: false,
                            controller: currentPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Current Password',
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
                                child: Icon(Icons.lock_clock_outlined),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 0, bottom: 10),
                          child: TextField(
                            autocorrect: false,
                            controller: newPasswordController,
                            obscureText: true,                      
                            decoration: InputDecoration(
                              hintText: 'New Password',
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
                                child: Icon(Icons.lock_outline_rounded),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 0, bottom: 10),
                          child: TextField(
                            autocorrect: false,
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
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
                                child: Icon(Icons.lock_outline_rounded),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentPasswordController.text.isEmpty ||
                                  newPasswordController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('All fields are required'),
                                  ),
                                );
                                return;
                              }
                              if (currentPasswordController.text ==
                                  newPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'New password cannot be the same as the current password'),
                                  ),
                                );
                                return;
                              }
                              if (newPasswordController.text ==
                                  confirmPasswordController.text) {
                                context.read<AuthBloc>().add(
                                      UpdatePasswordEvent(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('New passwords do not match')),
                                );
                              }
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
                            child: const Text('Reset Password'),
                          ),
                        ),
                        const SizedBox(height: 16.0),
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
