import 'package:flutter/material.dart';

class WorkoutHistoryPage extends StatefulWidget {
  const WorkoutHistoryPage({super.key});

  @override
  State<WorkoutHistoryPage> createState() => _WorkoutHistoryPageState();
}

class _WorkoutHistoryPageState extends State<WorkoutHistoryPage> {
  String currentMonth = 'May 2023';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D0A9),
      body: SafeArea(
        child: Column(
          children: [
            // Title area with back button
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7D1A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/back_button.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'WORKOUT HISTORY',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jersey25',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173F5F),
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Image.asset(
                'assets/garis.png',
                width: double.infinity,
                height: 12,
              ),
            ),
            
            // Calendar container
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Month title with navigation
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentMonth,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  onPressed: () {
                                    // Handle previous month
                                  },
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right),
                                  onPressed: () {
                                    // Handle next month
                                  },
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Calendar header
                      Container(
                        color: const Color(0xFFFF5252),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Mo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Tu',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'We',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Th',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Fr',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Sa',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Su',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Calendar grid
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: 35, // 5 weeks * 7 days
                          itemBuilder: (context, index) {
                            // Get day number and adjust for May 2023 (Monday as first day)
                            int day = index + 1;
                            bool isCurrentMonth = day <= 31;
                            bool isMarked = day == 23; // The day marked with X in the image
                            
                            // For next month days (in gray)
                            String displayDay = isCurrentMonth ? day.toString() : (day - 31).toString();
                            
                            return GestureDetector(
                              onTap: () {
                                if (isMarked) {
                                  _showWorkoutDetails(context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  color: isCurrentMonth ? const Color(0xFFF5E1B9) : const Color(0xFFD3D3D3),
                                ),
                                child: Center(
                                  child: isMarked
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Text(
                                              displayDay,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              'X',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          displayDay,
                                          style: TextStyle(
                                            color: isCurrentMonth ? Colors.black : Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
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
    );
  }

  void _showWorkoutDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9F45),
                  border: Border.all(color: Colors.deepOrange, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Leg Day',
                      style: TextStyle(
                        fontFamily: 'Jersey25',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Exercises:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const WorkoutExerciseItem(
                      name: 'Pushups',
                      sets: 3,
                      reps: 12,
                      activeTime: 'none',
                      restTime: '02:00',
                    ),
                    const SizedBox(height: 8),
                    const WorkoutExerciseItem(
                      name: 'Pike Pushups',
                      sets: 3,
                      reps: 12,
                      activeTime: 'none',
                      restTime: '02:00',
                    ),
                    const SizedBox(height: 8),
                    const WorkoutExerciseItem(
                      name: 'Dips',
                      sets: 2,
                      reps: 12,
                      activeTime: 'none',
                      restTime: '02:00',
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9F45),
                  border: Border.all(color: Colors.deepOrange, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monday workout (Custom)',
                      style: TextStyle(
                        fontFamily: 'Jersey25',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Exercises:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const WorkoutExerciseItem(
                      name: 'Plank',
                      sets: 5,
                      reps: 0,
                      activeTime: '00:20',
                      restTime: '02:00',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WorkoutExerciseItem extends StatelessWidget {
  final String name;
  final int sets;
  final int reps;
  final String activeTime;
  final String restTime;

  const WorkoutExerciseItem({
    super.key,
    required this.name,
    required this.sets,
    required this.reps,
    required this.activeTime,
    required this.restTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Row(
          children: [
            Text(
              'Sets $sets | Reps $reps',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Text(
          'Active Time $activeTime | Rest Time $restTime',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}