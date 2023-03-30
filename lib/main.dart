import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My E-Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isButtonEnabled = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Splash Screen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            if (_isButtonEnabled)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RootTab()),
                  );
                },
                child: Text('Dismiss'),
              ),
          ],
        ),
      ),
    );
  }
}
class RootTab extends StatefulWidget {
  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    Dashboard(),
    Courses(),
    Tests(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 56.0,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined, size: 24),
              activeIcon: Icon(
                Icons.dashboard,
                size: 30,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.book_outlined,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.book,
                size: 30,
              ),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_outlined,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.assignment,
                size: 30,
              ),
              label: 'Tests',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Browse our courses!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class Tests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Take a test!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class Account extends StatelessWidget {
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        // User signed in with Google, you can handle the sign-in flow here
        // e.g. send user data to your backend or navigate to a new screen
      }
    } catch (error) {
      // Handle sign-in errors here, e.g. display an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error signing in with Google: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View your account!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Register with Google'),
              onPressed: () => _handleGoogleSignIn(context),
            ),
          ],
        ),
      ),
    );
  }
}