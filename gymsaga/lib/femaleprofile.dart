import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weightgoal.dart';

class FemaleProfile extends StatelessWidget {
  Future<void> submitGoalType(String goalType, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken();

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/profile/goal/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'goal_type': goalType,
      }),
    );

    if (response.statusCode == 200) {
      print('Goal type updated');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeightGoal()),
      );
    } else {
      print('Failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9DEAF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'What\'s your goal?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/widgets/images/female_lose_weight.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                _buildButton('LOSE WEIGHT', context),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/widgets/images/female_build_muscle.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                _buildButton('BUILD MUSCLE', context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, BuildContext context) {
    return InkWell(
      onTap: () => submitGoalType(text, context),
      child: Container(
        height: 50,
        width: 240,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/widgets/buttons/golden_button.png'),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.center,
        child: Transform.translate(
          offset: const Offset(0, -8),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
