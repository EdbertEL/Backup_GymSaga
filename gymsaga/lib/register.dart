import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gymsaga/homepage.dart';
import 'login.dart'; // Import the login.dart file
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'completeyourprofile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// GOOGLE SIGN-IN
  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print('Google sign-in aborted');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('Google Sign-Up successful: ${user.email}');

        // Kirim data ke backend Django
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/register/'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': user.email,
            'username': user.displayName,
            'google_uid': user.uid,
            'method': 'google_login', // ⬅️ tambah method di sini
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CompleteYourProfile()),
          );
        } else {
          final responseData = jsonDecode(response.body);

          if (responseData['error'] == 'Email is already in use') {
            // Kalau user udah pernah login dengan Google → langsung ke Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // ganti dengan halaman home kamu
            );
          } else {
            print("Gagal menyimpan ke backend: ${response.body}");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to register via Google")),
            );
          }
        }
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-In Failed")),
      );
    }
  }

// EMAIL + PASSWORD
  Future<void> registerUser() async {
    try {
      // Daftar ke Firebase Authentication dulu
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = userCredential.user;

      if (user != null) {
        print('Firebase email/password signup berhasil: ${user.email}, UID: ${user.uid}');

        // Kirim data ke backend Django
        const String apiUrl = 'http://10.0.2.2:8000/api/register/';
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'username': _emailController.text.trim(),
            'email': _emailController.text.trim(),
            'password': _passwordController.text.trim(),
            'email_uid': user.uid,
            'method': 'email_login',
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print("Berhasil daftar dan simpan ke Django: $data");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteYourProfile(),
            ),
          );
        } else {
          final data = jsonDecode(response.body);
          print("Gagal simpan ke backend: $data");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['error'] ?? 'Registration failed')),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth error: ${e.message}');
      String errorMsg = 'Registration failed';
      if (e.code == 'email-already-in-use') {
        errorMsg = 'Email is already in use';
      } else if (e.code == 'weak-password') {
        errorMsg = 'Password is too weak';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    } catch (e) {
      print('Error saat registrasi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration error')),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Welcome Text with updated styling
                const Text(
                  'Welcome !',
                  style: TextStyle(
                    fontFamily: 'Jersey25',
                    fontSize: 42,
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
                const SizedBox(height: 8),
                // Please enter your details with Inter font and smaller size
                const Text(
                  'Please enter your details',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: Color(0xFF555555),
                  ),
                ),
                const SizedBox(
                    height: 50), // Increased spacing here from 20 to 40

                // White Form Container - Made size smaller
                Container(
                  width: 400, // Added width constraint
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 239, 220),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email Label
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14, // Reduced font size
                          color: Color.fromRGBO(26, 21, 21, 1),
                        ),
                      ),
                      const SizedBox(height: 2), // Reduced spacing
                      // Email TextField with smaller size
                      SizedBox(
                        height: 35, // Explicitly set height to make it smaller
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(fontSize: 13), // Smaller text
                          decoration: InputDecoration(
                            isDense: true, // Makes the text field more compact
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 6, // Reduced vertical padding
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12), // Reduced spacing

                      // Password Label
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14, // Reduced font size
                          color: Color.fromRGBO(26, 21, 21, 1),
                        ),
                      ),
                      const SizedBox(height: 2), // Reduced spacing
                      // Password TextField with smaller size
                      SizedBox(
                        height: 35, // Explicitly set height to make it smaller
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(fontSize: 13), // Smaller text
                          decoration: InputDecoration(
                            isDense: true, // Makes the text field more compact
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 6, // Reduced vertical padding
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            suffixIcon: const Icon(
                              Icons.visibility_off,
                              size: 18, // Smaller icon
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12), // Reduced spacing

                      // Remember me only (forgot password removed)
                      Row(
                        children: [
                          // Remember me checkbox - made smaller
                          SizedBox(
                            height: 18, // Reduced size
                            width: 18, // Reduced size
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (bool? value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 6), // Reduced spacing
                          const Text(
                            'Remember for 30 days',
                            style: TextStyle(
                              fontSize: 12, // Reduced font size
                              color: Color.fromARGB(255, 220, 220, 220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 70), // Increased from 32 to 50

                // Sign Up Button (Pixelated) - Adjusted position of text
                Center(
                  child: InkWell(
                    onTap: () {
                      registerUser();
                    },
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
                        offset: const Offset(
                            0, -8), // Changed from -4 to -8 to move text higher
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10), // Increased from 16 to 20

                // Sign Up with Google Button (Pixelated) - Adjusted position of text and logo
                Center(
                  child: InkWell(
                      onTap: signUpWithGoogle,
                    child: Container(
                      height: 50,
                      width: 240,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/widgets/buttons/silver_button.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: const Offset(0,
                            -8), // Changed from -4 to -8 to move content higher
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/widgets/images/google_logo.png',
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Sign Up with Google',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30), // Increased from 16 to 30

                // Do you have an account? Login - with blue, clickable login button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you have an account? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF555555),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the Login page when the button is pressed
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Dumbbell Image
                Image.asset(
                  'assets/widgets/images/dumbell_image.png',
                  height: 300,
                  width: 300,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
