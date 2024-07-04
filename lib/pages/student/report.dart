import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFF8A00), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF8A00), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Page',
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define a base width for iPhone 12 Pro
          double baseWidth = 390.0;
          // Calculate the scale factor
          double scaleFactor = constraints.maxWidth / baseWidth;

          return Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFF9E6BD),
            child: Center(
              child: Container(
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCD170),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20), // Spacer to push content down
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context, _startDateController),
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: _startDateController,
                                  decoration: const InputDecoration(
                                    labelText: "Start Date",
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context, _endDateController),
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: _endDateController,
                                  decoration: const InputDecoration(
                                    labelText: "End Date",
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add more widgets here
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // settings is the 1st item
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../widgets/widgets.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});

//   @override
//   State<ReportPage> createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();
//   DateTime? _selectedStartDate;
//   DateTime? _selectedEndDate;

//   Future<void> _selectDate(BuildContext context, TextEditingController controller, bool isStart) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: const Color(0xFFFF8A00), // header background color
//               onPrimary: Colors.white, // header text color
//               onSurface: Colors.black, // body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: const Color(0xFFFF8A00), // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (pickedDate != null) {
//       setState(() {
//         controller.text = "${pickedDate.toLocal()}".split(' ')[0];
//         if (isStart) {
//           _selectedStartDate = pickedDate;
//         } else {
//           _selectedEndDate = pickedDate;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Report Page',
//           textAlign: TextAlign.left,
//         ),
//         backgroundColor: const Color(0xFFFCD170),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 25.0),
//             child: UserProfileAvatar(),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Define a base width for iPhone 12 Pro
//           double baseWidth = 390.0;
//           // Calculate the scale factor
//           double scaleFactor = constraints.maxWidth / baseWidth;

//           return Container(
//             padding: const EdgeInsets.all(20),
//             color: const Color(0xFFF9E6BD),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20), // Spacer to push content down
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () => _selectDate(context, _startDateController, true),
//                               child: AbsorbPointer(
//                                 child: TextField(
//                                   controller: _startDateController,
//                                   decoration: const InputDecoration(
//                                     labelText: "Start Date",
//                                     suffixIcon: Icon(Icons.calendar_today),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () => _selectDate(context, _endDateController, false),
//                               child: AbsorbPointer(
//                                 child: TextField(
//                                   controller: _endDateController,
//                                   decoration: const InputDecoration(
//                                     labelText: "End Date",
//                                     suffixIcon: Icon(Icons.calendar_today),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     if (_selectedStartDate != null && _selectedEndDate != null)
//                       MealsTable(startDate: _selectedStartDate!, endDate: _selectedEndDate!),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: 1, // settings is the 1st item
//         onTap: (index) {
//           // Handle bottom navigation tap
//         },
//       ),
//     );
//   }
// }

// class MealsTable extends StatefulWidget {
//   final DateTime startDate;
//   final DateTime endDate;

//   const MealsTable({required this.startDate, required this.endDate, Key? key}) : super(key: key);

//   @override
//   _MealsTableState createState() => _MealsTableState();
// }

// class _MealsTableState extends State<MealsTable> {
//   late Future<List<Map<String, dynamic>>> _mealsData;

//   @override
//   void initState() {
//     super.initState();
//     _mealsData = _fetchMealsData();
//   }

//   Future<List<Map<String, dynamic>>> _fetchMealsData() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('meals')
//         .where('date', isGreaterThanOrEqualTo: widget.startDate)
//         .where('date', isLessThanOrEqualTo: widget.endDate)
//         .get();

//     return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 390.0;
//     double scaleFactor = MediaQuery.of(context).size.width / baseWidth;

//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _mealsData,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text('Error fetching data'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return DataTable(
//             columns: [
//               DataColumn(
//                 label: Container(
//                   color: const Color(0xFFFF8A00),
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Date',
//                     style: TextStyle(
//                       fontSize: 16.0 * scaleFactor,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Container(
//                   color: const Color(0xFFFF8A00),
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Time',
//                     style: TextStyle(
//                       fontSize: 16.0 * scaleFactor,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Container(
//                   color: const Color(0xFFFF8A00),
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Number of Meals',
//                     style: TextStyle(
//                       fontSize: 16.0 * scaleFactor,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             rows: [],
//             border: TableBorder.all(color: Colors.black),
//           );
//         }

//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: [
//                 DataColumn(
//                   label: Container(
//                     color: const Color(0xFFFF8A00),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Date',
//                       style: TextStyle(
//                         fontSize: 16.0 * scaleFactor,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Container(
//                     color: const Color(0xFFFF8A00),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Time',
//                       style: TextStyle(
//                         fontSize: 16.0 * scaleFactor,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Container(
//                     color: const Color(0xFFFF8A00),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Number of Meals',
//                       style: TextStyle(
//                         fontSize: 16.0 * scaleFactor,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//               rows: snapshot.data!.map((meal) {
//                 return DataRow(cells: [
//                   DataCell(Text(
//                     meal['date'],
//                     style: TextStyle(fontSize: 14.0 * scaleFactor),
//                   )),
//                   DataCell(Text(
//                     meal['time'],
//                     style: TextStyle(fontSize: 14.0 * scaleFactor),
//                   )),
//                   DataCell(Text(
//                     meal['number_of_meals'].toString(),
//                     style: TextStyle(fontSize: 14.0 * scaleFactor),
//                   )),
//                 ]);
//               }).toList(),
//               border: TableBorder.all(color: Colors.black),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
