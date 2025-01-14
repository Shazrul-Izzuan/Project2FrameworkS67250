import 'package:flutter/material.dart';
import 'customer_add_page_2.dart';

class CustomerAddPage1 extends StatefulWidget {
  const CustomerAddPage1({super.key});

  @override
  State<CustomerAddPage1> createState() => _CustomerAddPage1State();
}

class _CustomerAddPage1State extends State<CustomerAddPage1> {
  // Controllers for managing the input of the name and email fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Map to store customer data to be passed to the next page
  final Map<String, dynamic> _customerData = {};

  // Method to navigate to the next page after validating input
  void _navigateToNextPage() {
    // Check if the name or email fields are empty
    if (_nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")), // Show error message
      );
      return;
    }

    // Save input data into the `_customerData` map
    _customerData['name'] = _nameController.text.trim();
    _customerData['email'] = _emailController.text.trim();

    // Navigate to the next page, passing the `_customerData` map
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerAddPage2(customerData: _customerData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar title
        title: const Text('Add Customer - Step 1'),
        // Back button to navigate back to the previous page
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        // Gradient background for the page
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43A047), Color(0xFF66BB6A)], // Green shades
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              // Card with rounded corners and elevation for a modern look
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Wrap content height
                  children: [
                    // Text field for entering the customer's name
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name', // Placeholder text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person), // Icon for the field
                      ),
                    ),
                    const SizedBox(height: 16), // Spacing between fields

                    // Text field for entering the customer's email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email', // Placeholder text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.email), // Icon for the field
                      ),
                    ),
                    const SizedBox(height: 24), // Spacing before the button

                    // Button to navigate to the next page
                    ElevatedButton(
                      onPressed: _navigateToNextPage, // Call the navigation method
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Button color
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Next', // Button text
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
