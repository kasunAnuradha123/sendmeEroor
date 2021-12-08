import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendme/data/model/user_model.dart';
import 'package:sendme/presentation/bloc/auth/auth_cubit.dart';
import 'package:sendme/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:sendme/presentation/bloc/user/user_cubit.dart';
import 'package:sendme/presentation/pages/phone_verification_page.dart';
import 'package:sendme/presentation/pages/set_initial_profile_page.dart';
import 'package:sendme/presentation/screens/home_screen.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';



class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();

}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static Country _selectedFilteredDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode("94");
  String _countryCode=_selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber="";

  TextEditingController _phoneAuthController=TextEditingController();


  @override
  void dispose() {
   _phoneAuthController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocConsumer<PhoneAuthCubit,PhoneAuthState>(
        listener: (context,PhoneAuthState){
          if(PhoneAuthState is PhoneAuthSuccess){
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if(PhoneAuthState is PhoneAuthFailure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Something is wrong"),
                      Icon(Icons.error_outline),
                    ]
                ),
              )
            ),
            );
          }
        },
        builder: (context,PhoneAuthState){
          if(PhoneAuthState is PhoneAuthSmsCodeReceived){
            return PhoneVerificationPage(
              phoneNumber: _phoneNumber,
            );
          }
          if(PhoneAuthState is PhoneAuthProfileInfo){
            return SetInitialProfileWidget(
              phoneNumber: _phoneNumber,
            );
          }
          if(PhoneAuthState is PhoneAuthLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(PhoneAuthState is PhoneAuthSuccess){
            return BlocBuilder<AuthCubit,AuthState>(
              builder:(context,authState){
                if(authState is Authenticated){
                  return BlocBuilder<UserCubit, UserState>(
                    // ignore: missing_return
                      builder: (context, userState) {
                        if (userState is UserLoaded) {
                          final currentUserInfo = userState.users.firstWhere(
                                  (user) => user.uid == authState.uid,
                              orElse: () => UserModel());
                          return HomeScreen(
                            userInfo: currentUserInfo,
                          );
                        }
                      }
                  );
                }
                return Container();

              },

            );
          }
          return _bodyWidget();
        },
      ),
    );
  }



  Widget _bodyWidget(){
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
                      fontSize: 22,
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
              "sendMe will send SMS message (carrier charges may apply) to verify your phone number.Enter your country code and phone number",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: _openFilteredCountryPickerDialog,
              title: _buildDialogItem(_selectedFilteredDialogCountry), //SizedBoxSelectCountry
            ),

            //SecondSizeBoxPhoneNumber

            Row(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.50,color: greenColor))
                    ) ,
                    width: 80,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(_selectedFilteredDialogCountry.phoneCode),
                  ),
                  const SizedBox(width: 8.0,),
    // Expanded(
    //
    // child: Container(
    //
    // height: 40,
    //
    // child: TextField(
    //
    // controller: _phoneAuthController,
    //
    // decoration: InputDecoration(hintText: "Phone Number"),
                  Expanded(
                      child:Container(
                        height: 40,
                        child: TextField(
                          autofocus: true,
                          cursorColor: Colors.black,
                          controller: _phoneAuthController,
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                          ),
                        ),
                      )
                  ),
                ]
            ),
            Expanded(
                child:Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: greenColor,
                      onPressed: _submitVerifyPhoneNumber,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 18 ,
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

//CountryDialogBox

  void _openFilteredCountryPickerDialog() {
    showDialog(
          context: context,
        builder: (_) => Theme(
          data: Theme.of(context).copyWith(
            primaryColor: primaryColor,
          ),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.black,
            searchInputDecoration: const InputDecoration(
              icon: Icon(Icons.phone,color: Colors.blue,),
              hintText: "Search",
            ),
            isSearchable: true,
            title: const Text("Select your phone code"),
            onValuePicked: (Country country) {
              setState(() {
                _selectedFilteredDialogCountry = country;
              });
            },
            itemBuilder: _buildDialogItem,
          ),
        ));
  }

  //DialogDoxDecoration

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: greenColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            height: 8.0,
            width: 4.0,
          ),
          Text("+${country.phoneCode}"),
          const SizedBox(
            height: 8.0,
            width: 4.0,
          ),
          Text("${country.name}"),
          const Spacer(),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
void _submitVerifyPhoneNumber(){
    if (_phoneAuthController.text.isNotEmpty){
      _phoneNumber="+$_countryCode${_phoneAuthController.text}";
      BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(
        phoneNumber: _phoneNumber,
      );
    }
  }
}

