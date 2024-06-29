import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/models/students/functions.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import '../../bloc/bloc.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';
// import 'qr_scanner_page.dart';
import '../../widgets/widgets.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String count = '';
  int result = 30;
  int _selectedIndex = 0;
  double spinBoxValue = 0; // Track the SpinBox value
  int val = 1;

  void handleQRScan(String qrData) {
    setState(() {
      result -= spinBoxValue.toInt(); // Use the SpinBox value
    });
    Navigator.pop(context); // Close the QR scanner page
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        // Navigate to Home (Student Page)
        // Currently, we're already on the StudentPage
        break;
      case 1:
        // Navigate to Report Page
        break;
      case 2:
        // Navigate to Profile Page
        break;
      case 3:
        // Navigate to Settings Page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionClass,
      buildWhen: (previous, current) => current is! HomeActionClass,
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomeNavigateToScannerActionState) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Student Page',
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
          body: Container(
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
                        borderRadius:
                            BorderRadius.circular(25), // Outer border radius
                      ),
                      child: Container(
                        height: 140,
                        width: 140,
                        margin: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('students')
                                    .where('email',
                                        isEqualTo: 'student@ruhuna.com')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Center(
                                              child: Text(
                                                (30 -
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['count'])
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 75,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                })),
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
                      child: SpinBox(
                        min: 1,
                        max: 3,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            spinBoxValue = value;
                            val = value.toInt();
                          });
                        },
                      ),
                    ),
                  
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
                            //homeBloc.add(HomeScannerButtonNavigatorEvent());
                            updateCount(val);                        
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
                            "Scan the QR Code",
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
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
