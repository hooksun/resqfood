import 'package:flutter/material.dart';
import 'package:resqfood/Pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jdrlytkwtapnrjksxycs.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impkcmx5dGt3dGFwbnJqa3N4eWNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk4ODczMzAsImV4cCI6MjAyNTQ2MzMzMH0.S4ER7dBLT6jspT6n7JbIr5vPR38KY3b52Y0zo_hGuK0',
  );
  await supabase.auth.signInWithPassword(email: 'vincent.tadeo1206@gmail.com', password: 'notarealpassword'); //TODO: Replace with login page
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Res Q Food',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(255, 139, 19, 1)),
        useMaterial3: true,
      ),
      home: const HomePage()//const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
