import 'package:flutter/material.dart';
import 'achievement.dart';
import 'achievement2.dart';

class Achievement3Screen extends StatelessWidget {
  const Achievement3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF9D48B), // Background color matching the image
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildAchievementGrid(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/widgets/images/gold_trophy.png',
                height: 60,
                width: 60,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'My Achievement',
            style: TextStyle(
              fontFamily: 'Jersey',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  'Achievement 0/10',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildCategoryTabs(context),
          const Divider(color: Colors.brown, thickness: 2),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryTab("Bronze", false, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AchievementScreen()),
          );
        }),
        _buildCategoryTab("Silver", false, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Achievement2Screen()),
          );
        }),
        _buildCategoryTab("Gold", true, () {}),
      ],
    );
  }

  Widget _buildCategoryTab(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 3,
              width: 50,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  Widget _buildAchievementGrid() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildAchievementRow(
            'Step Master',
            'Walked 50,000 steps in a single day.',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Calories Crusher',
            'Burned 1000 calories in a single workout.',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Workout Warrior',
            'Completed 15 workouts in a week.',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Consistency Champion',
            'Logged workouts for 90 consecutive days.',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Distance Dominator',
            'Walked/Ran a total of 50 kilometers.',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Personal Best Breaker',
            'Achieved 10 new personal bests.',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Levels Dominator',
            '',
            0,
          ),
          const SizedBox(height: 12),
          _buildAchievementRow(
            'Achievement Name',
            '',
            0,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementRow(
      String title, String description, int progressPercent) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9D48B).withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/widgets/images/gold_medal.png',
                height: 60,
                width: 40,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Incompleted',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$progressPercent%',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressPercent / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
