import 'package:easy_coupon/bloc/qr/qr_bloc.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:intl/intl.dart';

class StudentReportPage extends StatefulWidget {
  const StudentReportPage({super.key});

  @override
  State<StudentReportPage> createState() => _StudentReportPageState();
}

class _StudentReportPageState extends State<StudentReportPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserQrCodes();
  }

  void _fetchUserQrCodes({DateTime? startDate, DateTime? endDate}) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<QrCodeBloc>().add(LoadQrCodesByUid(currentUser.uid,
          startDate: startDate, endDate: endDate));
    }
  }

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
              primary: Color(0xFFFF8A00),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF8A00),
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
      // Fetch QR codes with selected date range
      final startDate = _startDateController.text.isNotEmpty
          ? DateTime.parse(_startDateController.text)
          : null;
      final endDate = _endDateController.text.isNotEmpty
          ? DateTime.parse(_endDateController.text)
          : null;
      _fetchUserQrCodes(startDate: startDate, endDate: endDate);
    }
  }

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
                          const SizedBox(height: 20),
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
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: BlocBuilder<QrCodeBloc, QrCodeState>(
                              builder: (context, state) {
                                if (state is QrCodeLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is QrCodeLoaded) {
                                  // Filter and sort QR codes by scannedAt date
                                  final filteredQrcodes = state.qrcodes
                                      .where((item) {
                                    final itemDate = item.scannedAt;
                                    final startDate =
                                        _startDateController.text.isNotEmpty
                                            ? DateTime.parse(
                                                _startDateController.text)
                                            : null;
                                    final endDate =
                                        _endDateController.text.isNotEmpty
                                            ? DateTime.parse(
                                                _endDateController.text)
                                            : null;

                                    if (startDate != null && endDate != null) {
                                      return itemDate.isAfter(startDate) &&
                                          itemDate.isBefore(endDate
                                              .add(const Duration(days: 1)));
                                    } else if (startDate != null) {
                                      return itemDate.isAfter(startDate);
                                    } else if (endDate != null) {
                                      return itemDate.isBefore(
                                          endDate.add(const Duration(days: 1)));
                                    }
                                    return true;
                                  }).toList()
                                    ..sort((a, b) =>
                                        b.scannedAt.compareTo(a.scannedAt));

                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              columns: const [
                                                DataColumn(
                                                    label: Text('Date & Time')),
                                                DataColumn(
                                                    label:
                                                        Text('Canteen Name')),
                                                DataColumn(
                                                    label: Text('Coupon Used')),
                                              ],
                                              rows: filteredQrcodes
                                                  .map((QRModel item) {
                                                return DataRow(cells: [
                                                  DataCell(
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(item
                                                                    .scannedAt),
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat('hh:mm a')
                                                              .format(item
                                                                  .scannedAt), // Format time to 12-hour format with AM/PM
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: Text(item
                                                                  .canteenName
                                                                  .toLowerCase() ==
                                                              'canteena'
                                                          ? 'Kalderama'
                                                          : 'Hilton'),
                                                    ),
                                                  ),
                                                  DataCell(Center(
                                                    child: Text(
                                                        item.count.toString()),
                                                  )),
                                                ]);
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (state is QrCodeFailure) {
                                  return Center(
                                      child: Text('Error: ${state.message}'));
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
            );
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}
