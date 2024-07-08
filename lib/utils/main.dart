import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/bloc/bloc.dart';
import 'package:easy_coupon/pages/student/report_repo.dart';
import 'package:easy_coupon/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:easy_coupon/bloc/report/report_bloc.dart';
import 'package:easy_coupon/bloc/canteen/canteen_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ReportBloc>(
          create: (context) => ReportBloc(ReportRepository()),
        ),
        BlocProvider(
          create: (context) => CanteenBloc(FirebaseFirestore.instance),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(
          ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFF9E6BD),
          ),
        ),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Easy Coupon',
              theme: themeProvider.themeData.copyWith(
                scaffoldBackgroundColor: const Color(0xFFFF8A00),
              ),
              initialRoute: RouteNames.studentReport,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
