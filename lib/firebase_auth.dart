import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user with email and password
  Future<UserCredential?> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Registration error: ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected registration error: $e");
      rethrow;
    }
  }

  // Login user with email and password
  Future<UserCredential?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected login error: $e");
      rethrow;
    }
  }

  // Log out the user
  Future<void> logout() async {
    try {
      await _auth.signOut();
      print("User logged out successfully.");
    } catch (e) {
      print("Logout error: $e");
      rethrow;
    }
  }

  // Get the current user
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print("Error getting current user: $e");
      return null;
    }
  }

  // Add customer data to Firestore
  Future<void> addCustomerToFirestore({
    required String name,
    required String email,
    required String company,
    required String role,
    required String industry,
    required String details,
  }) async {
    try {
      // Ensure fields are not empty
      if ([name, email, company, role, industry, details].any((field) => field.isEmpty)) {
        throw Exception('All fields must be filled!');
      }

      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("User is not authenticated.");
      }

      // Prepare customer data
      Map<String, dynamic> customerData = {
        'name': name,
        'email': email,
        'company': company,
        'role': role,
        'industry': industry,
        'details': details,
        'createdAt': FieldValue.serverTimestamp(),
        'userId': user.uid, // Link customer data to the authenticated user
      };

      // Save to Firestore under 'customers' collection
      await _firestore.collection('customers').add(customerData);

      print("Customer data saved successfully!");
    } catch (e) {
      print("Error saving customer data: $e");
      rethrow;
    }
  }

  // Fetch customer data from Firestore by document ID
  Future<Map<String, dynamic>?> fetchCustomerData(String customerId) async {
    try {
      // Get the document from Firestore
      DocumentSnapshot snapshot = await _firestore.collection('customers').doc(customerId).get();

      // Check if the document exists
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      } else {
        print("Customer not found.");
        return null;
      }
    } catch (e) {
      print("Error fetching customer data: $e");
      rethrow;
    }
  }

  // Update or edit customer data in Firestore by document ID
  Future<void> updateCustomerData({
    required String customerId,
    required String name,
    required String email,
    required String company,
    required String role,
    required String industry,
    required String details,
  }) async {
    try {
      // Ensure fields are not empty
      if ([name, email, company, role, industry, details].any((field) => field.isEmpty)) {
        throw Exception('All fields must be filled!');
      }

      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("User is not authenticated.");
      }

      // Fetch the current customer data (optional, if you want to display or modify existing data)
      DocumentSnapshot snapshot = await _firestore.collection('customers').doc(customerId).get();
      if (!snapshot.exists) {
        throw Exception('Customer not found.');
      }

      // Prepare the updated customer data
      Map<String, dynamic> updatedCustomerData = {
        'name': name,
        'email': email,
        'company': company,
        'role': role,
        'industry': industry,
        'details': details,
        'updatedAt': FieldValue.serverTimestamp(),
        'userId': user.uid, // Ensure the customer data is linked to the authenticated user
      };

      // Update the customer data in Firestore
      await _firestore.collection('customers').doc(customerId).update(updatedCustomerData);

      print("Customer data updated successfully!");
    } catch (e) {
      print("Error updating customer data: $e");
      rethrow;
    }
  }

  // Delete customer data from Firestore by document ID
  Future<void> deleteCustomerData(String customerId) async {
    try {
      // Delete the customer document from Firestore
      await _firestore.collection('customers').doc(customerId).delete();

      print("Customer data deleted successfully!");
    } catch (e) {
      print("Error deleting customer data: $e");
      rethrow;
    }
  }
}
