import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/pages/canteen/canteen_a/qr_generation.dart';
import 'package:easy_coupon/widgets/common/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CanteenAHomePage extends StatefulWidget {
  const CanteenAHomePage({super.key});

  @override
  State<CanteenAHomePage> createState() => _CanteenAHomePageState();
}

class _CanteenAHomePageState extends State<CanteenAHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Canteen Page',
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xFFFCD170),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: UserProfileAvatar(),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final user = state.users.firstWhere(
              (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
            );
            return Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF9E6BD),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCD170),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      Container(
                        height: 110,
                        width: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8900),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/studentImage.jpg',
                                fit: BoxFit.cover,
                              ),
                              const Positioned(
                                left: 20,
                                top: 10,
                                child: Text(
                                  'The Reliable\nCoupon System',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF5C00), Color(0xFFFFFB10)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          height: 140,
                          width: 180,
                          margin: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Card(
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    user.canteenCount.toString(),
                                    style: const TextStyle(
                                      fontSize: 75,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Container(
                        height: 50,
                        width: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QRGenerationPage(user: user),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(290, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "My QR",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}
