
import 'package:datingappintro/SignUp/children/sign_up_images.dart';
import 'package:datingappintro/dating_main.dart';
import 'package:flutter/material.dart';

import 'children/sign_up_form.dart';
import 'children/sign_up_interest.dart';

class SignUpMain extends StatefulWidget {
  @override _SignUpMainState createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  PageController _pageController = PageController();
  double _currentPageViewIndex = 0;
  Color _nextColor = Colors.indigo[800];
  String _nextButtonString = 'Next';

  void changeNextButtonTextAndColor(int page) {
    // _currentPageViewIndex = page.toDouble();
    switch (page) {
      case 2:_nextButtonString = 'Start App!'; _nextColor = Colors.green[900]; break;
      default: _nextButtonString = 'Next';_nextColor = Colors.indigo[800]; break;
    }
  }

  void cancelButtonEvent(context) => _currentPageViewIndex > 0 ? _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn) :Navigator.pop(context);

  void _moveToNextPage() => _pageController.animateToPage(_pageController.page.toInt() + 1,duration: Duration(milliseconds: 200),curve: Curves.easeIn);

  void nextButtonEvent(context) {
    switch (_pageController.page.toInt()) {
      case 0: case 1: _moveToNextPage();break;
      case 2: {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DatingMain()));
      }break;
    }
  }

  Widget _pageViewIndicator(int location){
    return Expanded(
      child: Divider(
        height: 1,
        thickness: 3,
        color: location - 1 <= _currentPageViewIndex && _currentPageViewIndex < location ? Colors.grey[700] : Colors.grey[300],
        indent: 6.0,
      ),
    );
  }

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPageViewIndex = _pageController.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://i.pinimg.com/564x/40/97/a9/4097a9be2792b98cd3c1ed69088ec42f.jpg'),
              fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                child: Row(
                  children: [
                    _pageViewIndicator(1),
                    _pageViewIndicator(2),
                    _pageViewIndicator(3)
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) => setState(() => changeNextButtonTextAndColor(page)),
                  children: [
                    SignUpForm(),
                    SignUpImages(),
                    SignUpInterest()
                  ],
                )
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        onPressed: ()=> cancelButtonEvent(context),
                        child: Center(child: Text('Cancel',style: TextStyle(fontSize: 20),)),
                        textColor: Colors.black,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        onPressed: ()=> nextButtonEvent(context),
                        child: Center(child: Text(_nextButtonString,style: TextStyle(fontSize: 20),)),
                        textColor: Colors.white,
                        color: _nextColor,
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }
}
