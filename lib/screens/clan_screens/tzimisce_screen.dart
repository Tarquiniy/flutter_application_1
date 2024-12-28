import 'package:flutter/material.dart';
import '/screens/clan_screens/clan_screen.dart';

class TzimisceScreen extends ClanScreen {
  const TzimisceScreen({super.key, required super.user});

  @override
  List<String> getDisciplines() {
    return ['Animalism', 'Vicissitude', 'Auspex'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clan: Tzimisce:',
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
