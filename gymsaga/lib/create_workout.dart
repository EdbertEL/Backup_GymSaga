import 'package:flutter/material.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({Key? key}) : super(key: key);

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutNameController = TextEditingController();
  final List<String> _exercises = [];
  final TextEditingController _exerciseController = TextEditingController();

  @override
  void dispose() {
    _workoutNameController.dispose();
    _exerciseController.dispose();
    super.dispose();
  }

  void _addExercise() {
    if (_exerciseController.text.isNotEmpty) {
      setState(() {
        _exercises.add(_exerciseController.text);
        _exerciseController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEDFB6),
      appBar: AppBar(
        title: Stack(
          children: [
            // Text outline
            Text(
              'CREATE WORKOUT',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Jersey25',
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.black,
              ),
            ),
            // Text fill with shadow
            Text(
              'CREATE WORKOUT',
              style: TextStyle(
                fontSize: 24,
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
        centerTitle: true,
        backgroundColor: const Color(0xFF5C9CE0), // Blue header background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Red dots pattern overlay under header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/widgets/background/decor_atas.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Workout Name Section
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/widgets/background/frame.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Workout Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jersey25',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _workoutNameController,
                          decoration: InputDecoration(
                            hintText: "Enter workout name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name for your workout';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Exercises Section
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/widgets/background/frame.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Exercises",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jersey25',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _exerciseController,
                                decoration: InputDecoration(
                                  hintText: "Add exercise",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: _addExercise,
                              child: Image.asset(
                                'assets/widgets/buttons/add_button.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        // List of exercises
                        if (_exercises.isNotEmpty) ...[
                          const Text(
                            "Exercise List:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jersey25',
                            ),
                          ),
                          const SizedBox(height: 5),
                          ...List.generate(_exercises.length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${index + 1}. ${_exercises[index]}",
                                    style: const TextStyle(
                                      fontFamily: 'Jersey25',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _exercises.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // XP Points Section
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/widgets/background/frame.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "XP Points",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jersey25',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Example XP slider
                        Slider(
                          value: 120,
                          min: 0,
                          max: 200,
                          divisions: 20,
                          label: "120 XP",
                          activeColor: const Color(0xFF00BFFF),
                          onChanged: (value) {
                            // In a real app, you would update a state variable here
                          },
                        ),
                        const Center(
                          child: Text(
                            "120 XP",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00BFFF),
                              fontFamily: 'Jersey25',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Save Button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate() && _exercises.isNotEmpty) {
                          // In a real app, you would save the workout here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Workout created successfully!')),
                          );
                          Navigator.pop(context);
                        } else if (_exercises.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please add at least one exercise')),
                          );
                        }
                      },
                      child: Image.asset(
                        'assets/widgets/buttons/save_button.png',
                        width: 150,
                        height: 50,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}