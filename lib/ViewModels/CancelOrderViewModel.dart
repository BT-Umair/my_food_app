import 'package:flutter/material.dart';

class CancelOrderViewModel extends ChangeNotifier {
  // Use a controller to manage the text field state
  final TextEditingController reasonController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Validate the text input length or presence
  bool get isValid => reasonController.text.trim().isNotEmpty;

  void updateText(String value) {
    // Notify listeners if you want to dynamically enable/disable the submit button
    notifyListeners();
  }

  Future<void> submitCancellation(BuildContext context) async {
    if (!isValid) {
      _errorMessage = 'Please provide a reason for cancellation';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call to cancel the order
      await Future.delayed(Duration(seconds: 1));

      // Clear controller on success
      reasonController.clear();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order cancelled successfully')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }
}
