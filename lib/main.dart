import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

import 'SignUp/sign_up_main.dart';

void main() {
  runApp(MyApp());
}

class SignUpData{
  final IconData icon;
  final String signUpType;
  final Color buttonColor;

  SignUpData(this.icon, this.signUpType, this.buttonColor);
}

class UserData{
  final String userName;
  final int userAge;
  final String userIntro;
  final String userImageUrl;
  final List<String> userInterestingList;

  UserData(this.userName, this.userAge, this.userIntro,this.userImageUrl, this.userInterestingList);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<UserData> _dummyUserDataList = [
    UserData("Olivia",23,"Nice to meet you","https://cdn.pixabay.com/photo/2017/03/30/18/17/girl-2189247_1280.jpg",['Shop','Sleep','Netflix','Travel','Movie']),
    UserData("Lucy",21,"I wanna meet someone","https://cdn.pixabay.com/photo/2016/03/27/21/52/cold-1284411_1280.jpg",['Economy','Animal','Movie']),
    UserData("Jessica",24,"Where is my soul?","https://cdn.pixabay.com/photo/2020/02/24/02/49/female-4875046_1280.jpg",['Travel','Sleep','Economy']),
    UserData("Amanda",22,"I need a boy friend","https://cdn.pixabay.com/photo/2016/11/29/12/34/beautiful-1869532_1280.jpg",['Sleep','Game','Travel','Eat']),
    UserData("Helen",26,"Busy everyday","https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",['School','Music','Shop','Sports']),
    UserData("Tang",21,"I love to travel","https://cdn.pixabay.com/photo/2016/10/15/05/23/girl-1741941_1280.jpg",['Travel','Animal','Adventure','Game'])
  ];

  final SwiperController _swiperController = SwiperController();
  Timer _timer;

  @override
  void initState() {
    if(mounted){ _startTimer(); }
    super.initState();
  }

  void _startTimer(){
    _timer = new Timer.periodic(const Duration(milliseconds: 3400), (timer) {
      _swiperController.next();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // bottom: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://i.pinimg.com/564x/40/97/a9/4097a9be2792b98cd3c1ed69088ec42f.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child:
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                    child: new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpMain())),
                          child: Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.77,
                                child: ClipRRect(
                                  child:
                                  CachedNetworkImage(
                                    imageUrl: _dummyUserDataList[index].userImageUrl,
                                    placeholder: (context, url) => Container(
                                      transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                                      child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context).size.height*0.77,
                                          child: Center(child: new CircularProgressIndicator())),
                                    ),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height*0.77,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset:Offset(2,2),
                                    ),
                                  ]
                                ),
                              ),
                              Positioned(
                                left:10,
                                bottom: 14,
                                child: Column(
                                  children: [
                                    Row( // User Name & Age
                                      children: [
                                        Text(_dummyUserDataList[index].userName,
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                                offset: Offset(0.6,0.6)
                                              )
                                            ]
                                          ),
                                        ),
                                        Text(' ${_dummyUserDataList[index].userAge}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 1.0,
                                                    color: Colors.black,
                                                    offset: Offset(0.6,0.6)
                                                )
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    // User Intro
                                    Text(_dummyUserDataList[index].userIntro,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                                offset: Offset(0.6,0.6)
                                            )
                                          ]
                                      ),
                                    ),
                                    // User Interesting List
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Wrap(
                                        children: _dummyUserDataList[index].userInterestingList.map((interestingText) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right:8.0,bottom: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.grey[700]
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                                child: Container(
                                                    child: Text(interestingText,style: TextStyle(color: Colors.white),)
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: _dummyUserDataList.length,
                      viewportFraction: 0.8,
                      scale: 0.92,
                      controller: _swiperController,
                    ),
                  )
                ),
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 2,color: Colors.grey[200],endIndent: 8,indent: 16.0,)),
                    Text(' Start App ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[200]
                      ),),
                    Expanded(child: Divider(thickness: 2,color: Colors.grey[200],endIndent: 16,indent: 8.0,)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _signUpDataList.map(_bottomSignUpButton).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SignUpData> _signUpDataList = [
    SignUpData(FontAwesomeIcons.solidEnvelope, 'Email', Colors.amber[900]),
    SignUpData(FontAwesomeIcons.facebookF, 'Facebook', Colors.blue[900]),
    SignUpData(FontAwesomeIcons.google, 'Google', Colors.red[700]),
    SignUpData(FontAwesomeIcons.apple, 'Apple', Colors.black),
  ];

  Widget _bottomSignUpButton(SignUpData signUpData){
    return Padding(
      padding: const EdgeInsets.only(top:4.0,bottom: 4.0),
      child: Column(
        children: [
          RawMaterialButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpMain())),
            child: Icon(signUpData.icon,color: Colors.white,size:30),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: signUpData.buttonColor,
            padding: EdgeInsets.all(16.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top:4.0),
            child: Text(signUpData.signUpType,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10
              ),
            ),
          )
        ],
      ),
    );
  }
}
