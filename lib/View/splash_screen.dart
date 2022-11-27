import 'dart:async';

import 'package:covid_19_api/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: Duration(seconds: 5), vsync: this)
    ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      Duration(seconds: 5),(
        ()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>WorldStatessScreen()), (route) => false)
    )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  height: 300,
                  width: 300,
                  child:CircleAvatar(
                    backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwW0p2TNWQ8b3vT3Fl2PxXcNIFWx1lS5AOnzSe5LICpr4rXMhqoCSGW_t1nHWZ00fXPno&usqp=CAU"),
                  )
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Covid -19 \n Tracker App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
