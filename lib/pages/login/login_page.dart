import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/pages/canteen/canteen_a/canteen_a_page.dart';
import 'package:easy_coupon/pages/student/student_page.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/pages/pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void navigateWithAnimation(BuildContext context, String routeName) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (routeName) {
              case RouteNames.resetPW:
                return const NewUserPwResetPage();
              case RouteNames.student:
                return const StudentHomeScreen();
              case RouteNames.canteenA:
                return const CanteenHomeScreen();
              case RouteNames.canteenB:
                return const CanteenBPage();
              default:
                return const LoginPage();
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: LoginWidget(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is FirstTimeLogin) {
                    navigateWithAnimation(context, RouteNames.resetPW);
                  } else if (state is StudentAuthenticated) {
                    navigateWithAnimation(context, RouteNames.student);
                  } else if (state is CanteenAAuthenticated) {
                    navigateWithAnimation(context, RouteNames.canteenA);
                  } else if (state is CanteenBAuthenticated) {
                    navigateWithAnimation(context, RouteNames.canteenB);
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
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Icon(Icons.person_outline_rounded),
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
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
                            final userName = userNameController.text.toLowerCase();
                            final password = passwordController.text;

                            if (userName.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('All fields are required')),
                              );
                              return;
                            }

                            context.read<AuthBloc>().add(
                                  LoggedInEvent(
                                    username: userName,
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.send_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RouteNames.resetPWEmail);
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
      ),
    );
  }
}
