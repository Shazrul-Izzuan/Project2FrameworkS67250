import 'package:flutter/material.dart';
import 'firebase_auth.dart';

class CustomerAddPage3 extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const CustomerAddPage3({super.key, required this.customerData});

  @override
  State<CustomerAddPage3> createState() => _CustomerAddPage3State();
}

class _CustomerAddPage3State extends State<CustomerAddPage3> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  Future<void> _saveCustomerData() async {
    try {
      widget.customerData['industry'] = _industryController.text.trim();
      widget.customerData['details'] = _detailsController.text.trim();

      await _authService.addCustomerToFirestore(
        name: widget.customerData['name'],
        email: widget.customerData['email'],
        company: widget.customerData['company'],
        role: widget.customerData['role'],
        industry: widget.customerData['industry'],
        details: widget.customerData['details'],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer data saved successfully!')),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving customer data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer - Step 3'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _industryController,
                      decoration: InputDecoration(
                        labelText: 'Industry',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.business_center),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _detailsController,
                      decoration: InputDecoration(
                        labelText: 'Details',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.info),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveCustomerData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
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
