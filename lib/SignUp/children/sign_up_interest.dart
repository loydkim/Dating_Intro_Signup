

import 'package:flutter/material.dart';

class SignUpInterest extends StatefulWidget {
  @override _SignUpInterestState createState() => _SignUpInterestState();
}

class _SignUpInterestState extends State<SignUpInterest> with AutomaticKeepAliveClientMixin<SignUpInterest>{
  @override
  bool get wantKeepAlive => true;

  List<String> _selectedIndexList = [];
  List<String> _options = [
    'Sports', 'Music', 'Travel','Party','Dancing','Language','Movie','Economy','Netflix','Game','Sleep','Shop'
  ];

  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndexList.contains(_options[i]),//_selectedIndex == i,
        label: Text(_options[i], style: TextStyle(color: Colors.white)),
        avatar: _selectedIndexList.contains(_options[i]) ? Icon(Icons.check,color: Colors.white,) : null,
        elevation: 4,
        pressElevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.grey[800],
        selectedColor: Colors.blue[700],
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              // _selectedIndex = i;
              if(!_selectedIndexList.contains(_options[i])){
                _selectedIndexList.add(_options[i]);
              }
            }else{
              if(_selectedIndexList.contains(_options[i])){
                _selectedIndexList.remove(_options[i]);
              }
            }
          });
        },
      );

      chips.add(
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: choiceChip
          ));
    }

    return Wrap(
      spacing: 5.0,
      runSpacing: 3.0,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Introduce yourself.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:14.0,top:16.0,bottom: 14.0),
              child: Container(
                  width: 380,
                  height: 180,
                  child: Card(
                      child:Padding(
                        padding: const EdgeInsets.only(left:6.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type about you'
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: null,
                          ),
                        ),
                      )
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select your interesting fields.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _buildChips(),
            ),
          ],
        ),
      ),
    );
  }
}
