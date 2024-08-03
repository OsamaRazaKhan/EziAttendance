import 'package:flutter/material.dart';

class GradingSystemView extends StatefulWidget {
  @override
  _GradingSystemViewState createState() => _GradingSystemViewState();
}

class _GradingSystemViewState extends State<GradingSystemView> {
  final Map<String, TextEditingController> _controllers = {
    'A': TextEditingController(),
    'B': TextEditingController(),
    'C': TextEditingController(),
    'D': TextEditingController(),
    'F': TextEditingController(),
  };

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _saveGrades() {
    // Implement save logic here
    // Example: Collect data from the controllers and send it to the backend
    Map<String, int> grades = _controllers.map((key, value) {
      return MapEntry(key, int.tryParse(value.text) ?? 0);
    });

    // Print the grades to console for now
    print(grades);

    // Display a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Grades saved successfully!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Grading System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set the number of days attended for each grade:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ..._controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: 'Days for Grade ${entry.key}',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              );
            }).toList(),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _saveGrades,
                child: Text('Save Grades'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
