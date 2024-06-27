import 'package:easy_coupon/models/students/student.dart';
import 'package:easy_coupon/widgets/common/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_coupon/bloc/report/bloc/report_bloc.dart';
import 'package:easy_coupon/bloc/report/bloc/report_event.dart';
import 'package:easy_coupon/bloc/report/bloc/report_state.dart';

class StudentReport extends StatefulWidget {
  const StudentReport({super.key});

  @override
  State<StudentReport> createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  @override
  void initState() {
    super.initState();
    context.read<ReportBloc>().add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Report'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<ReportBloc, ReportState>(builder: (context, state) {
                  if (state is ReportLoaded) {
                    List<ReportDataModel> data = state.reportData;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data[index].Time),
                              trailing: Text(data[index].Number),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ReportLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReportError) {
                    return Text('Error: ${state.error}');
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
