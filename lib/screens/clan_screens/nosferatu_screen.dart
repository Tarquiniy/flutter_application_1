import 'package:flutter/material.dart';
import '/screens/clan_screens/clan_screen.dart';

class NosferatuScreen extends ClanScreen {
  const NosferatuScreen({super.key, required super.user});

  @override
  List<String> getDisciplines() {
    return ['Animalism', 'Obfuscate', 'Potence'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nosferatu:',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 8),
          buildDisciplinesList(context),
        ],
      ),
    );
  }
}
