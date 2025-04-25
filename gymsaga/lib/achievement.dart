import 'package:flutter/material.dart';
// import 'achievement2.dart';
// import 'achievement3.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9D48B),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildAchievementGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      'assets/widgets/buttons/back_button.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'My Achievement',
                    style: TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 40,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 4),
                          blurRadius: 15.0,
                          color: Color.fromARGB(100, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A3D2B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFF9D48B),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Achievement 0/10',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                'assets/widgets/images/bronze_trophy.png',
                height: 110,
                width: 110,
              ),
            ],
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
        _buildCategoryTab("Bronze", true, () {}),
        _buildCategoryTab("Silver", false, () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Achievement2Screen()),
          // );
        }),
        _buildCategoryTab("Gold", false, () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Achievement3Screen()),
          // );
        }),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildAchievementRow(
              'Step Master',
              'Walked 10,000 steps in a single day.',
              0,
            ),
            _buildAchievementRow(
              'Calories Crusher',
              'Burned 300 calories in a single workout.',
              0,
            ),
            _buildAchievementRow(
              'Workout Warrior',
              'Completed 5 workouts in a week.',
              0,
            ),
            _buildAchievementRow(
              'Consistency Champion',
              'Logged workouts for 7 consecutive days.',
              0,
            ),
            _buildAchievementRow(
              'Distance Dominator',
              'Walked/Ran a total of 10 kilometers.',
              0,
            ),
            _buildAchievementRow(
              'Personal Best Breaker',
              'Achieved a new personal best.',
              0,
            ),
            _buildAchievementRow(
              'Levels Dominator',
              'Reach Levels 10.',
              0,
            ),
            _buildAchievementRow(
              'Achievement Name',
              'Achievement Description',
              0,
            ),
            _buildAchievementRow(
              'Achievement Name',
              'Achievement Description',
              0,
            ),
            _buildAchievementRow(
              'Achievement Name',
              'Achievement Description',
              0,
            ),
          ],
        );
      },
    );
  }

  Widget _buildAchievementRow(
      String title, String description, int progressPercent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Jersey25',
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/widgets/images/bronze_medal.png',
                  height: 110,
                  width: 100,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Incompleted',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        child: Text(
                          '$progressPercent%',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
