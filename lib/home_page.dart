import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black), // Text color for title
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // White background
        elevation: 0, // Flat app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Black icon color
          onPressed: () {
            // Navigate back to the login page
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43A047), Color(0xFF66BB6A)], // Green gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: Column(
            children: [
              const SizedBox(height: 60), // Space for app bar equivalent
              const Text(
                'CustoMate',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Customer List Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/customer_list');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.list_alt),
                            SizedBox(width: 10),
                            Text(
                              'Customer List',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Add Customer Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/customer_add1');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.person_add_alt_1),
                            SizedBox(width: 10),
                            Text(
                              'Add Customer',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
