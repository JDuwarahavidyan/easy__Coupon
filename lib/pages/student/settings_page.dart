import 'dart:ui';
import 'package:easy_coupon/bloc/auth/auth_bloc.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/widgets/common/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double getResponsiveFontSize(double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseFontSize *
        (screenWidth /
            450); // 390 is roughly the width of iPhone 12 Pro in logical pixels
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 24.0,
          backgroundColor: Colors.white,
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: getResponsiveFontSize(20),
              shadows: const [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 1.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          content: Text(
            'Do you want to logout?',
            style: TextStyle(
              fontSize: getResponsiveFontSize(16),
              shadows: const [],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFF8A00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: getResponsiveFontSize(16),
                  shadows: const [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFF8A00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: getResponsiveFontSize(16),
                  shadows: const [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(LoggedOutEvent());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageSize = screenSize.width / 3;

    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final user = state.users.firstWhere(
              (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
            );

            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: screenSize.width,
                      height: imageSize,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Image.asset(
                          'assets/profile_picture.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        color: const Color(0xFFF9E6BD),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: imageSize /
                                      2), // Space for the overlapping image
                              Container(
                                margin: EdgeInsets.only(top: imageSize / 4),
                                padding: const EdgeInsets.all(16.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF9E6BD),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        'About App',
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(18),
                                        ),
                                      ),
                                      onTap: () {
                                        // Navigate to about app page
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Change Password',
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(18),
                                        ),
                                      ),
                                      onTap: () {
                                        // Navigate to change password page
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Theme',
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(18),
                                        ),
                                      ),
                                      trailing: const ThemeSwitch(),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(18),
                                        ),
                                      ),
                                      onTap: _showLogoutDialog,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: imageSize / 1.5 - imageSize / 6,
                  left: 16.0,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: imageSize / 2,
                        backgroundColor: const Color.fromARGB(255, 2, 1, 0),
                        child: CircleAvatar(
                          radius: imageSize / 2.05,
                          backgroundImage: const AssetImage(
                             'assets/nouser.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: imageSize /
                                  2), // Adjust this value to move the text further down
                          Text(
                           capitalizeFirstLetter(user.fullName),
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              shadows: const [],
                            ),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(14),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              shadows: const [],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}