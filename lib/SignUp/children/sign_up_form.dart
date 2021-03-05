import 'package:flutter/material.dart';

enum GenderEnum{ man, woman}

class SignUpForm extends StatefulWidget {
  @override _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with AutomaticKeepAliveClientMixin<SignUpForm>{
  @override
  bool get wantKeepAlive => true;

  GenderEnum _userGender = GenderEnum.man;
  String _birthdayString = 'Select your birthday';
  bool _isAgreeTerm = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Type your information.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.account_circle,),
                labelText: 'Type Your name',
                hintText: 'Name is required'
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: Row(
              children: [
                Icon(Icons.wc,color: Colors.grey,),
                _genderRadioWithText(GenderEnum.man),
                SizedBox(width: 20,),
                _genderRadioWithText(GenderEnum.woman),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:14.0),
                  child: Icon(Icons.cake,color: Colors.grey,),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () => _selectBirthday(),
                    child: Text(_birthdayString),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Row(
            children: [
              Checkbox(
                value: _isAgreeTerm,
                onChanged: (value){
                  setState(() {
                    _isAgreeTerm = value;
                  });
                }
              ),
              GestureDetector(
                onTap: (){ setState(() {
                  _isAgreeTerm = !_isAgreeTerm;
                });},
                child: Text('I agree to ',style: TextStyle(fontSize: 16),)
              ),
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('Term of Service'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {  },
                            child: Container(
                              height:360,
                              child: SingleChildScrollView(
                                child: Text('Term of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of Service Term of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of Service Term of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of Service Term of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of Service Term of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of ServiceTerm of Service')
                              )
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
                child: Text('Term of Service',style: TextStyle(fontSize: 16,color: Colors.blue,fontWeight: FontWeight.bold))
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _genderRadioWithText(GenderEnum value){
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _userGender,
          onChanged: (value) => _updateGenderState(value),
        ),
        GestureDetector(
          onTap: () => _updateGenderState(value),
          child: Text(value == GenderEnum.man ? 'Man' : 'Woman')
        )
      ],
    );
  }

  void _updateGenderState(GenderEnum value){
    setState(() {
      _userGender = value;
    });
  }

  Future<void> _selectBirthday() async {
    final DateTime _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year-22,DateTime.now().month),
        firstDate: DateTime(DateTime.now().year-60,DateTime.now().month),
        lastDate: DateTime(DateTime.now().year-18,DateTime.now().month));
    if(_pickedDate != null){
      setState(() {
        _birthdayString = '${_pickedDate.toLocal()}'.split(' ')[0];
      });
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
