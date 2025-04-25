import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'femaleprofile.dart';
import 'maleprofile.dart';

class CompleteYourProfile extends StatefulWidget {
  const CompleteYourProfile({super.key});

  @override
  CompleteYourProfileState createState() => CompleteYourProfileState();
}

class CompleteYourProfileState extends State<CompleteYourProfile> {

  String _selectedGender = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  Future<void> _submitProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken();
    final double? weight = double.tryParse(_weightController.text);
    final String genderLower = _selectedGender.toLowerCase();

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/profile/complete/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "name": _nameController.text,
        "gender": _selectedGender.toLowerCase(),
        "date_of_birth": _dobController.text, // format yyyy-MM-dd
        "weight": double.parse(_weightController.text),
        "height": double.parse(_heightController.text),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Profile saved successfully');
    } else {
      print('Failed to save profile: ${response.body}');
    }
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  bool _areAllFieldsFilled() {
    return _nameController.text.isNotEmpty &&
        _selectedGender.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty;
  }

  void _navigateToProfile() async {
    await _submitProfileData();

    if (_selectedGender.toLowerCase() == 'male') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MaleProfile()),
      );
    } else if (_selectedGender.toLowerCase() == 'female') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FemaleProfile()),
      );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () {
                      // Handle back navigation
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: _selectedGender == 'Male'
                      ? Image.asset(
                          'assets/widgets/images/male_profile.png',
                          width: 120,
                          height: 120,
                        )
                      : _selectedGender == 'Female'
                          ? Image.asset(
                              'assets/widgets/images/female_profile_bulet.png',
                              width: 120,
                              height: 120,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 60,
                              child: Icon(
                                Icons.person_outline,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: 'Your Name',
                  hintText: 'Your Name',
                  icon: Icons.person_outline,
                  controller: _nameController,
                ),
                const SizedBox(height: 15),
                _buildGenderSelector(),
                const SizedBox(height: 15),
                _buildInputField(
                  label: 'Date of Birth',
                  hintText: 'Date of Birth',
                  icon: Icons.calendar_today,
                  controller: _dobController,
                ),
                const SizedBox(height: 15),
                _buildMeasurementField(
                  label: 'Your Weight',
                  hintText: 'Your Weight',
                  unit: 'KG',
                  icon: Icons.monitor_weight_outlined,
                  controller: _weightController,
                ),
                const SizedBox(height: 15),
                _buildMeasurementField(
                  label: 'Your Height',
                  hintText: 'Your Height',
                  unit: 'CM',
                  icon: Icons.height,
                  controller: _heightController,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Let\'s complete your profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3.0,
                              color: Color.fromARGB(125, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'It will help us to know more about you!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2.0,
                              color: Color.fromARGB(125, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: InkWell(
                    onTap: _areAllFieldsFilled() ? _navigateToProfile : null,
                    child: Opacity(
                      opacity: _areAllFieldsFilled() ? 1.0 : 0.5,
                      child: Container(
                        height: 50,
                        width: 240,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/widgets/buttons/golden_button.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: const Offset(0, -8),
                          child: const Text(
                            'Next >',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Male'),
                  onTap: () {
                    _selectGender('male');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Female'),
                  onTap: () {
                    _selectGender('female');
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Icon(Icons.people_outline, color: Colors.grey),
              SizedBox(width: 10),
              Text(
                _selectedGender.isEmpty ? 'Choose Gender' : _selectedGender,
                style: TextStyle(
                  color: _selectedGender.isEmpty
                      ? Colors.grey.shade400
                      : Colors.black,
                ),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementField({
    required String label,
    required String hintText,
    required String unit,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(icon, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: unit == 'KG'
                ? const Color(0xFFFF9800)
                : const Color(0xFFFF9800),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          child: Center(
            child: Text(
              unit,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}