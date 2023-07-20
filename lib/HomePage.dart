import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
    const HomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  children: [Text(
                    'Hello, ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    'Siraj 👋',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  ]
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(top: 24),
                    children: [
                      InkWell(
                        child: Container(
                          height: 132,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                        'First Note',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text('lorem ipsum dolor sit amet',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: const Icon(Icons.add, size: 30),
        ),
      );
    }
}