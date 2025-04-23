import 'package:flutter/material.dart';
import 'navbar.dart';

class PushDayPage extends StatelessWidget {
  const PushDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decor header
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/widgets/background/decor_atas.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/widgets/background/header.png',
                fit: BoxFit.cover,
              ),
            ),
            // Title "Push Day"
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  children: [
                    Text(
                      'Push Day',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jersey25',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    Text(
                      'Push Day',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jersey25',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 5),
                            blurRadius: 0,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol Back di header
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),

            // Main content
            Positioned.fill(
              top: 120,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildExerciseCard('Pushups – 3 x 12 Reps'),
                      const SizedBox(height: 10),
                      buildExerciseCard('Pike Pushups – 3 x 12 Reps'),
                      const SizedBox(height: 10),
                      buildExerciseCard('Dips – 2 x 12 Reps'),
                      const SizedBox(height: 24),
                      const Text(
                        'Rewards',
                        style: TextStyle(
                          fontFamily: 'Jersey25',
                          fontSize: 24,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE9B2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '+120 XP',
                              style: TextStyle(
                                fontFamily: 'Jersey25',
                                fontSize: 22,
                                color: Color(0xFF38B6FF),
                              ),
                            ),
                            Text(
                              '🔥 200 KCAL',
                              style: TextStyle(
                                fontFamily: 'Jersey25',
                                fontSize: 22,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Tombol START dengan posisi text yang benar-benar di tengah
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Fungsi yang dijalankan ketika tombol ditekan
                          },
                          child: Container(
                            width: 200, // Lebar tombol
                            height: 60, // Tinggi tombol
                            child: Stack(
                              children: [
                                // Gambar tombol
                                Positioned.fill(
                                  child: Image.asset(
                                    'assets/widgets/buttons/golden_button.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // Pastikan teks berada di tengah-tengah dengan alignment
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      'START',
                                      style: TextStyle(
                                        fontFamily: 'Jersey25',
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 0,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontFamily: 'Jersey25',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                'Schedule Workout:',
                                style: TextStyle(
                                  fontFamily: 'Jersey25',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Icon(Icons.calendar_month, color: Colors.orange),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget buildExerciseCard(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE9B2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.fitness_center, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Jersey25',
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
