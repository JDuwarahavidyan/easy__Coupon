import 'package:easy_coupon/bloc/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'qr_scanner_page.dart';
// import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  int result = 30;
  double spinBoxValue = 0; // Track the SpinBox value

  void handleQRScan(String qrData) {
    setState(() {
      result -= spinBoxValue.toInt(); // Use the SpinBox value
    });
    Navigator.pop(context); // Close the QR scanner page
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
            title: const Text('Student Page'),
            backgroundColor: const Color(0xFFFCD170),
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          drawer: const AppDrawer(), // Use the new AppDrawer widget
          body: Container(
            padding: const EdgeInsets.all(50),
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
                      children: [
                        NavigationButton(text: 'Home'),
                        NavigationButton(text: 'Report'),
                      ],
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
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          result.toString(),
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    /*Container(
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
                          });
                        },
                      ),
                    ),*/
                    Container(
                      height: 50,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              homeBloc.add(HomeClickMinusButtonEvent());
                              // Add your action here
                            },
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              homeBloc.add(HomeClickPlusButtonEvent());
                              // Add your action here
                            },
                          ),
                        ],
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
                            homeBloc.add(HomeScannerButtonNavigatorEvent());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => QRScannerPage(handleQRScan),
                            //   ),
                            // );
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
        );
      },
    );
  }
}
