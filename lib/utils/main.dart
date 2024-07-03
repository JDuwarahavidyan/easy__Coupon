import 'package:easy_coupon/bloc/bloc.dart';
import 'package:easy_coupon/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
              title: 'Flutter Demo',
              theme: themeProvider.themeData.copyWith(
                scaffoldBackgroundColor: const Color(0xFFFF8A00),
              ),
              initialRoute: RouteNames.report,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
