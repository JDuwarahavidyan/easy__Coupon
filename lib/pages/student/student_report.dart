import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_coupon/widgets/widgets.dart';

class StudentReportPage extends StatefulWidget {
  const StudentReportPage({super.key});

  @override
  State<StudentReportPage> createState() => _StudentReportPageState();
}

class _StudentReportPageState extends State<StudentReportPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF8A00), // header background color
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
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  /*void _fetchData() {
    final startDate = _startDateController.text;
    final endDate = _endDateController.text;
    context
        .read<ReportBloc>()
        .add(GetData(startDate: startDate, endDate: endDate));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Report',
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

            return LayoutBuilder(
              builder: (context, constraints) {
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
                          const SizedBox(
                              height: 20), // Spacer to push content down
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectDate(
                                        context, _startDateController),
                                    child: AbsorbPointer(
                                      child: TextField(
                                        controller: _startDateController,
                                        decoration: const InputDecoration(
                                          labelText: "Start Date",
                                          suffixIcon:
                                              Icon(Icons.calendar_today),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectDate(
                                        context, _endDateController),
                                    child: AbsorbPointer(
                                      child: TextField(
                                        controller: _endDateController,
                                        decoration: const InputDecoration(
                                          labelText: "End Date",
                                          suffixIcon:
                                              Icon(Icons.calendar_today),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                /*ElevatedButton(
                                  onPressed:(), //_fetchData,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        const Color(0xFFFF8A00), // text color
                                  ),
                                  child: const Text('Fetch Data'),
                                ),*/
                              ],
                            ),
                          ),
                          const SizedBox(
                              height:
                                  20), // Spacer between date inputs and table
                          /*Expanded(
                            child: BlocBuilder<ReportBloc, ReportState>(
                              builder: (context, state) {
                                if (state is ReportLoaded) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      border: TableBorder
                                          .all(), // Add borders to the table
                                      columns: const [
                                        DataColumn(label: Text('Student ID')),
                                        DataColumn(label: Text('Canteen ID')),
                                        DataColumn(label: Text('Canteen Type')),
                                        DataColumn(label: Text('Student Name')),
                                        DataColumn(label: Text('Canteen Name')),
                                       // DataColumn(label: Text('Scanned At')),
                                        DataColumn(label: Text('Count')),
                                      ],
                                      rows:
                                          state.reportData.map((QRModel data) {
                                        return DataRow(cells: [
                                          DataCell(Text(data.studentId)),
                                          DataCell(Text(data.canteenId)),
                                          DataCell(Text(data.canteenType)),
                                          DataCell(Text(data.studentName)),
                                          DataCell(Text(data.canteenName)),
                                         // DataCell(Text(data.scanedAt)),
                                          DataCell(Text(data.count.toString())),
                                        ]);
                                      }).toList(),
                                    ),
                                  );
                                } else if (state is ReportLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is ReportError) {
                                  return Center(
                                      child: Text('Error: ${state.error}'));
                                } else {
                                  return const Center(child: Text('No data'));
                                }
                              },
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}
