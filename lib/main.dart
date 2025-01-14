import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'customer_list_page.dart';
import 'customer_add_page_1.dart';
import 'customer_add_page_2.dart';
import 'customer_add_page_3.dart';
import 'customer_update_page_1.dart';
import 'customer_update_page_2.dart';
import 'customer_update_page_3.dart';

// The entry point of the Flutter application
void main() async {
  // Ensures that widget bindings are initialized before executing further code
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase, which is required for database and authentication services
    await Firebase.initializeApp();
    print("Firebase Initialized");
  } catch (e) {
    // Handles initialization errors
    print("Firebase initialization error: $e");
    return;
  }

  // Launches the app
  runApp(const MyApp());
}

// The main widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Builds the widget tree for the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustoMate CRM', // The app's title
      theme: ThemeData(primarySwatch: Colors.blue), // Sets the app theme
      debugShowCheckedModeBanner: false, // Hides the debug banner
      initialRoute: '/login', // Sets the initial route to the Login Page
      onGenerateRoute: (settings) {
        // Dynamically generates routes based on the route name
        switch (settings.name) {
          case '/login': // Login Page route
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/register': // Registration Page route
            return MaterialPageRoute(builder: (context) => const RegisterPage());
          case '/home': // Home Page route (after login)
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/customer_list': // Customer List Page route
            return MaterialPageRoute(builder: (context) => const CustomerListPage());
          case '/customer_add1': // Customer Add Step 1 route
            return MaterialPageRoute(builder: (context) => const CustomerAddPage1());
          case '/customer_add2': // Customer Add Step 2 route with data passed as arguments
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CustomerAddPage2(customerData: args),
            );
          case '/customer_add3': // Customer Add Step 3 route with data passed as arguments
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CustomerAddPage3(customerData: args),
            );
          case '/customer_update1': // Customer Update Step 1 route with data passed as arguments
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CustomerUpdatePage1(customerData: args),
            );
          case '/customer_update2': // Customer Update Step 2 route with data passed as arguments
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CustomerUpdatePage2(customerData: args),
            );
          case '/customer_update3': // Customer Update Step 3 route with data passed as arguments
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CustomerUpdatePage3(customerData: args),
            );
          default: // Default case for unknown routes
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text("Page not found")), // Displays an error message
              ),
            );
        }
      },
    );
  }
}
