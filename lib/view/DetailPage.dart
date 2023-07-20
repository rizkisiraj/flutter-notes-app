import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/3dwork.png'), scale: 1.2)
              )
            ),
            Expanded(
              child: Material(
                type: MaterialType.transparency,
                child: Hero(
                  tag: 'note',
                  child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: ClipRRect(
                            child: Column(
                                children: [
                                  const Material(
                                    type: MaterialType.transparency,
                                    child: const TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Write your title...'
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: TextField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Write your notes here....",
                                        border: InputBorder.none
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          ),
                        ),
                      )
                ),
              ),
            // )
          ],
        ),
    );
  }
  
}