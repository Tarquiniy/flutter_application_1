import 'package:flutter/material.dart';
import '/screens/main_screen.dart';
import '/services/database_service.dart';

import '../models/user.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gothic_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  String? _selectedClan;
  final _passwordController = TextEditingController();
  final _generationController = TextEditingController();
  final _natureController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  // Список всех кланов
  final List<String> _clans = [
    'Toreador',
    'Malkavian',
    'Ventrue',
    'Brujah',
    'Gangrel',
    'Nosferatu',
    'Tremere',
    'Lasombra',
    'Tzimisce'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GothicAppBar(title: "Register"),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: "Username",
                    controller: _usernameController,
                    icon: Icons.person,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF3A1F14), width: 1.5),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.groups,
                              color: const Color.fromARGB(255, 34, 16, 16)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                        ),
                        value: _selectedClan,
                        items: _clans.map((clan) {
                          return DropdownMenuItem<String>(
                            value: clan,
                            child: Text(
                              clan,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 70, 30, 30)),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedClan = value;
                          });
                        },
                        hint: const Text(
                          "Select Clan",
                          style: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a clan';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  CustomTextField(
                    labelText: "Password",
                    controller: _passwordController,
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  CustomTextField(
                    labelText: "Generation (e.g., 8th)",
                    controller: _generationController,
                    icon: Icons.numbers,
                  ),
                  CustomTextField(
                    labelText: "Nature (e.g., Architect)",
                    controller: _natureController,
                    icon: Icons.nature_people,
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text("Embrace the Night"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final dbService = DatabaseService();
      final newUser = User(
        username: _usernameController.text,
        clan: _selectedClan!,
        password: _passwordController.text,
        generation: _generationController.text,
        nature: _natureController.text,
        disciplines: _getDisciplinesForClan(_selectedClan!),
      );
      try {
        await dbService.insertUser(newUser);
        // Переходим на главный экран
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(user: newUser),
          ),
        );
      } catch (e) {
        setState(() {
          _errorMessage = "Error adding user $e";
        });
      }
    }
  }

  List<String> _getDisciplinesForClan(String clan) {
    switch (clan.toLowerCase()) {
      case 'toreador':
        return ['Auspex', 'Celerity', 'Presence'];
      case 'malkavian':
        return ['Auspex', 'Dementation', 'Obfuscate'];
      case 'ventrue':
        return ['Dominate', 'Fortitude', 'Presence'];
      case 'brujah':
        return ['Celerity', 'Potence', 'Presence'];
      case 'gangrel':
        return ['Animalism', 'Fortitude', 'Protean'];
      case 'nosferatu':
        return ['Animalism', 'Obfuscate', 'Potence'];
      case 'tremere':
        return ['Auspex', 'Dominate', 'Thaumaturgy'];
      case 'lasombra':
        return ['Dominate', 'Obtenebration', 'Potence'];
      case 'tzimisce':
        return ['Animalism', 'Vicissitude', 'Auspex'];
      default:
        return [];
    }
  }
}
