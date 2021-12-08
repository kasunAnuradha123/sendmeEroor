import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendme/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:sendme/presentation/pages/set_initial_profile_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';

class PhoneVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerificationPage({Key key,  this.phoneNumber}) : super(key: key);



  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {

  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(""),
                Text(
                  "Verify your phone number",
                  style: TextStyle(
                      fontSize: 18,
                      color: greenColor,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "waiting to automatically detect an SMS sent",
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            _pinCodewidget(),

            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: greenColor,
                      onPressed: _submitSmsCode,
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
          ],
        ),
      ),
    );
  }

//otp


  Widget _pinCodewidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child:Column(
        children:<Widget>[
         PinCodeTextField(
          controller: _pinCodeController,
          length: 6,
          autoFocus: true,
          backgroundColor: Colors.transparent,
          obscureText: true,
          onChanged: (pinCode) {
            print(pinCode);
          },
          appContext: context,

          ),
          const Text("Enter Your 6 digit code")
        ],
      )
    );
  }

  void _submitSmsCode(){
    if(_pinCodeController.text.isNotEmpty){
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitSmsCode(smsCode: _pinCodeController.text);
    }
  }
}