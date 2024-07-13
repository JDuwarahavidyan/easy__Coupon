import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_coupon/bloc/auth/auth_bloc.dart';
import 'package:easy_coupon/bloc/report/report_bloc.dart';
import 'package:easy_coupon/bloc/report/report_state.dart';
import 'package:easy_coupon/bloc/report/report_event.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:easy_coupon/routes/routes.dart';

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
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _fetchData() {
    final startDate = _startDateController.text;
    final endDate = _endDateController.text;
    context
        .read<ReportBloc>()
        .add(GetData(startDate: startDate, endDate: endDate));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated || state is AuthStateError) {
          Navigator.pushReplacementNamed(context, RouteNames.login);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated || state is StudentAuthenticated) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Student Report', textAlign: TextAlign.left),
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
                  double baseWidth = 390.0;
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
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                  ElevatedButton(
                                    onPressed: _fetchData,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          const Color(0xFFFF8A00), // text color
                                    ),
                                    child: const Text('Fetch Data'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: BlocBuilder<ReportBloc, ReportState>(
                                builder: (context, state) {
                                  if (state is ReportLoaded) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        border: TableBorder
                                            .all(), // Add borders to the table
                                        columns: const [
                                          DataColumn(label: Text('Number')),
                                          DataColumn(label: Text('Time')),
                                          DataColumn(label: Text('Date')),
                                        ],
                                        rows: state.reportData.map((data) {
                                          return DataRow(cells: [
                                            DataCell(Text(data.Number)),
                                            DataCell(Text(data.Time)),
                                            DataCell(Text(data.Date)),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              bottomNavigationBar: BottomNavBar(
                currentIndex: 1, // Report page is the 1st item
                onTap: (index) {
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, RouteNames.student);
                      break;
                    case 1:
                      // Already on the Student Report page
                      break;
                    case 2:
                      // Navigate to Profile Page
                      break;
                    case 3:
                      Navigator.pushNamed(context, '/settings');
                      break;
                  }
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
