import 'package:flutter/material.dart';
import '../models/course.dart';

const Color mainColor = Colors.blue;

class CourseScoreForm extends StatefulWidget {
  const CourseScoreForm({super.key});

  @override
  State<CourseScoreForm> createState() => _CourseScoreFormState();
}

class _CourseScoreFormState extends State<CourseScoreForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController(text: '50');

  @override
  void dispose() {
    _nameController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        CourseScore(
          studentName: _nameController.text.trim(),
          studenScore: double.parse(_scoreController.text.trim()), value: 0.0,
        ),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length < 2 || value.trim().length > 50) {
      return 'Name must be between 2 and 50 characters.';
    }
    return null;
  }

  String? _validateScore(String? value) {
    final score = double.tryParse(value ?? '');
    if (score == null || score < 0 || score > 100) {
      return 'Score must be between 0 and 100.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Add Score", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: _validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Score'),
                validator: _validateScore,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _saveItem,
                style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                child: const Text("Add Score", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
