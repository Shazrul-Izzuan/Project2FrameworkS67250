import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerUpdatePage3 extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const CustomerUpdatePage3({super.key, required this.customerData});

  @override
  _CustomerUpdatePage3State createState() => _CustomerUpdatePage3State();
}

class _CustomerUpdatePage3State extends State<CustomerUpdatePage3> {
  late TextEditingController industryController;
  late TextEditingController detailsController;

  @override
  void initState() {
    super.initState();
    industryController = TextEditingController(text: widget.customerData['industry']);
    detailsController = TextEditingController(text: widget.customerData['details']);
  }

  Future<void> _updateCustomerData() async {
    final updatedData = {
      ...widget.customerData,
      'industry': industryController.text,
      'details': detailsController.text,
    };

    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(widget.customerData['id'])
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer data updated successfully!')),
      );

      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update customer: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Customer - Step 3'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                      controller: industryController,
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
                      controller: detailsController,
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
                      onPressed: _updateCustomerData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.blueAccent),
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
