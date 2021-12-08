import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendme/presentation/bloc/phone_auth/phone_auth_cubit.dart';

import 'package:sendme/presentation/widgets/theme/style.dart';

class SetInitialProfileWidget extends StatefulWidget {
  final String phoneNumber;
  const SetInitialProfileWidget({Key key, this.phoneNumber}) : super(key: key);

  @override
  _SetInitialProfileWidgetState createState() => _SetInitialProfileWidgetState();
}

class _SetInitialProfileWidgetState extends State<SetInitialProfileWidget> {
  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
            children: <Widget>[
              const Text("Profile Info",
                style: TextStyle(
                    fontSize: 18,
                    color: greenColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 25,),
              const Text(
                "Please provide your name and an optional Profile photo",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 35,),

              _rowWidget(),

              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        color: greenColor,
                        onPressed: _submitProfileInfo,
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                  )
              )
            ]
        ),
      ),
    );
  }



  Widget _rowWidget() {
    // var _nameController;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: textIconColorGray,
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(width: 8,),
          Expanded(
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                ),
              )
          ),
          const SizedBox(width: 8.0,),
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
                color: textIconColorGray,
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: const Icon(Icons.insert_emoticon),
          ),
        ],
      ),
    );
  }

void _submitProfileInfo() {
  if (_nameController.text.isNotEmpty) {
    BlocProvider.of<PhoneAuthCubit>(context).submitProfileInfo(
        profileUrl: "",
        phoneNumber: _phoneNumber,
        name: _nameController.text);
  }
}
}


