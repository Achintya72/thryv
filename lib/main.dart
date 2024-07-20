import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:thryv/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:thryv/service/auth.dart';
import 'package:thryv/userProvider.dart';
import 'package:thryv/views/placeholder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Thryv());
}

final _router = GoRouter(redirectLimit: 10, initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const ThryvPlaceholder(),
  )
]);

class Thryv extends StatelessWidget {
  const Thryv({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      initialData: null,
      child: UserProvider(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      ),
    );
  }
}
