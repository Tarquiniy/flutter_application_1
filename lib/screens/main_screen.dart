import 'package:flutter/material.dart';
import '/screens/clan_screens/brujah_screen.dart';
import '/screens/clan_screens/gangrel_screen.dart';
import '/screens/clan_screens/lasombra_screen.dart';
import '/screens/clan_screens/malkavian_screen.dart';
import '/screens/clan_screens/nosferatu_screen.dart';
import '/screens/clan_screens/toreador_screen.dart';
import '/screens/clan_screens/tremere_screen.dart';
import '/screens/clan_screens/tzimisce_screen.dart';
import '/screens/clan_screens/ventrue_screen.dart';

import '../models/user.dart';
import '../widgets/gothic_app_bar.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GothicAppBar(title: 'Your Character'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF3A1F14), width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF1A0A06),
                            Color(0xFF0D0604),
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoItem(
                                  'Name', widget.user.username, Icons.person),
                              _buildInfoItem('Nature', widget.user.nature,
                                  Icons.nature_people),
                              _buildInfoItem('Generation',
                                  widget.user.generation, Icons.numbers),
                              _buildInfoItem('Level', '5', Icons.trending_up),
                              _buildInfoItem('Experience', '1200', Icons.star),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Изображение клана (может быть заменено иконкой или другим изображением)
                        CircleAvatar(
                          backgroundColor: const Color(0xFF3A1F14),
                          radius: 50,
                          child: Text(
                            widget.user.clan[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF3A1F14), width: 1.5),
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF1A0A06),
                              Color(0xFF0D0604),
                            ])),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildClanScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[400],
          ),
          const SizedBox(width: 8.0),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildClanScreen() {
    switch (widget.user.clan.toLowerCase()) {
      case 'toreador':
        return ToreadorScreen(user: widget.user);
      case 'malkavian':
        return MalkavianScreen(user: widget.user);
      case 'ventrue':
        return VentrueScreen(user: widget.user);
      case 'brujah':
        return BrujahScreen(user: widget.user);
      case 'gangrel':
        return GangrelScreen(user: widget.user);
      case 'nosferatu':
        return NosferatuScreen(user: widget.user);
      case 'tremere':
        return TremereScreen(user: widget.user);
      case 'lasombra':
        return LasombraScreen(user: widget.user);
      case 'tzimisce':
        return TzimisceScreen(user: widget.user);
      default:
        return Center(
          child: Text(
            'Clan information for ${widget.user.clan} not found',
            style: const TextStyle(color: Colors.white),
          ),
        );
    }
  }
}
