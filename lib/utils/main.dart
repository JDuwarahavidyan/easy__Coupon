import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/bloc/qr/qr_bloc.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/repositories/qrcode/qr_repository.dart';
import 'package:easy_coupon/repositories/repositories.dart';
import 'package:easy_coupon/repositories/user/user_repository.dart';
import 'package:easy_coupon/services/qrcode/qr_service.dart';
import 'package:easy_coupon/services/user/user_service.dart';
import 'package:easy_coupon/routes/routes.dart';
import 'package:easy_coupon/services/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'firebase_options.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:provider/provider.dart';

 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    final AuthRepository authRepository = AuthRepository(
    firebaseAuthService: FirebaseAuthService(),
  );

    runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<ReportBloc>(
          create: (context) => ReportBloc(ReportRepository()),
        ),
        BlocProvider(
          create: (context) => CanteenBloc(FirebaseFirestore.instance),
        ),

         BlocProvider<UserBloc>(
          create: (context) => UserBloc(UserRepository(UserService()))..add(UserReadEvent(),
        )),

        BlocProvider<QrCodeBloc>(
          create: (context) => QrCodeBloc(QrCodeRepository(QrCodeService()))..add(QrCodeReadEvent(),
        )),


         
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
              initialRoute: RouteNames.splash,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
