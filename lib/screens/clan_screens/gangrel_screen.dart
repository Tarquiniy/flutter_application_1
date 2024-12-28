import 'package:flutter/material.dart';
import '/screens/clan_screens/clan_screen.dart';

class GangrelScreen extends ClanScreen {
  const GangrelScreen({super.key, required super.user});

  @override
  List<String> getDisciplines() {
    return ['Animalism', 'Fortitude', 'Protean'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gangrel:',
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
