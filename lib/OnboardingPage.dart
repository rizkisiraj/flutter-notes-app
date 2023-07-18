import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                image: AssetImage('assets/images/icon3d.png'),
                scale: 1.4,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.42,
                width: MediaQuery.of(context).size.width,
              ),
              Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(48), topRight: Radius.circular(48))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Expanded(
                    flex: 2,
                    child: Column(
                      children: [Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                            'Notes App',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Notes app let you creates notes and summarize your task powered by Open AI.',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                    Flexible(child:
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Get Started',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12)
                          ),
                          onPressed: () {}
                        )
                      )
                    )
                  ]
                ),
              ),
            )],
          )
        ],
      ),
    );
  }
}