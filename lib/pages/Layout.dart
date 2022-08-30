import 'package:flutter/material.dart';

import 'Category.dart';


class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Container(margin: EdgeInsets.fromLTRB( 10, 100, 0, 0),
              child: Column(
                children: [
                  Image.asset('assets/images/MainImage.png', width: 250, height: 250,),
                  Center(
                    child: Container(margin: EdgeInsets.fromLTRB( 0, 10, 10, 0),
                      child: Text('스마트 인벤토리',
                        style: TextStyle( color: Color.fromRGBO(147, 189, 222, 1), fontSize: 45),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(margin:EdgeInsets.fromLTRB( 0, 100, 10, 0),
                      child: TextButton(onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Category()));
                      } ,
                        child: Text('카테고리'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(147, 189, 222, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        )
    );
  }
}
