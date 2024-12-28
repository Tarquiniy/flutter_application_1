import 'package:flutter/material.dart';

import '../../models/user.dart';

abstract class ClanScreen extends StatelessWidget {
  final User user;

  const ClanScreen({super.key, required this.user});

  List<String> getDisciplines();

  Widget buildDisciplinesList(BuildContext context) {
    List<String> disciplines = getDisciplines();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Disciplines:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        ...disciplines.map((discipline) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '- $discipline',
                style: const TextStyle(color: Colors.white),
              ),
            )),
      ],
    );
  }
}
