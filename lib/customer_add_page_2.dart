import 'package:flutter/material.dart';
import 'customer_add_page_3.dart';

class CustomerAddPage2 extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const CustomerAddPage2({super.key, required this.customerData});

  @override
  State<CustomerAddPage2> createState() => _CustomerAddPage2State();
}

class _CustomerAddPage2State extends State<CustomerAddPage2> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  void _navigateToNextPage() {
    if (_companyController.text.trim().isEmpty || _roleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    widget.customerData['company'] = _companyController.text.trim();
    widget.customerData['role'] = _roleController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerAddPage3(customerData: widget.customerData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer - Step 2'),
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
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: 'Company',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.business),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _roleController,
                      decoration: InputDecoration(
                        labelText: 'Role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.work),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _navigateToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Next',
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
