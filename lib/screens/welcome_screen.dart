import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/Component/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation logoAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, //welcomeScreenState act as ticker
      //mndtry prop

      // upperBound: 100, // cant have >1 if we use curve
    );

    logoAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    // controller.reverse(from: 1.0) // can use reverse the values

    controller.addListener(() {
      setState(() {}); // change
    });

    // animation.addStatusListener((status) {
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from:1.0);
    //   }
    //   else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });
  }

  //not let controller use memory after screen dispose
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logoAnimation.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Toda Chat',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      colors: [
                        Colors.grey,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                buttonColor: Colors.lightBlueAccent,
                buttonPressed: () {
                  //Go to Login screen.
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                buttonTxt: "Log in"),
            RoundedButton(
                buttonColor: Colors.blueAccent,
                buttonPressed: () {
                  //Go to registration screen.
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                buttonTxt: "Register")
          ],
        ),
      ),
    );
  }
}
