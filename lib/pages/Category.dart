import 'package:flutter/material.dart';
import 'package:last/pages/home_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';


class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(114, 166, 211, 1),
            title: Text('카테고리'),
            centerTitle: true,
          ),
          backgroundColor: Color.fromRGBO(185, 209, 233, 1),
          body: Center(
            child: Container(margin: EdgeInsets.fromLTRB( 0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: FormHelper.submitButton("옷장", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }, borderRadius: 10, btnColor: Colors.lightBlue),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FormHelper.submitButton("냉장고", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }, borderRadius: 10, btnColor: Colors.lightBlue),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FormHelper.submitButton("물품", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }, borderRadius: 10, btnColor: Colors.lightBlue),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FormHelper.submitButton("+ 만들기", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }, borderRadius: 10, btnColor: Colors.lightBlue),
                  ),
                ],
              ),
            ),

          ),

        )
    );
  }
}
