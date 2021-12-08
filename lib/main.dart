import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendme/data/model/user_model.dart';
import 'package:sendme/presentation/bloc/auth/auth_cubit.dart';
import 'package:sendme/presentation/bloc/communication/communication_cubit.dart';
import 'package:sendme/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:sendme/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:sendme/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:sendme/presentation/screens/home_screen.dart';
import 'package:sendme/presentation/screens/splash_screen.dart';
import 'package:sendme/presentation/screens/welcome_screen.dart';

// import 'package:device_preview/device_preview.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:sendme/presentation/bloc/user/user_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => MyApp(), // Wrap your app
// ),


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
            di.sl<AuthCubit>()
              ..appStarted(),
          ),
          BlocProvider(
            create: (_) => di.sl<PhoneAuthCubit>(),
          ),
          BlocProvider<UserCubit>(
            create: (_) =>
            di.sl<UserCubit>()
              ..getAllUsers(),
          ),
          BlocProvider<GetDeviceNumbersCubit>(
            create: (_) => di.sl<GetDeviceNumbersCubit>(),
          ),
          BlocProvider<CommunicationCubit>
            (create: (_)=> di.sl<CommunicationCubit>(),
          ),
          BlocProvider<MyChatCubit>(
            create: (_) =>di.sl<MyChatCubit>(),
          ),
        ],

        child: MaterialApp(
          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'sendMe',
          theme: ThemeData(
              primaryColor: greenColor
            // brightness: Brightness.dark,
            // primarySwatch: Colors.,
          ),
          // initialRoute: "/",
          routes: {
            "/": (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
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
                  if (authState is UnAuthenticated) {
                    return WelcomeScreen();
                  }
                  return Container();
                },
              );
            }
          },
          // routes: {
          //   "/":(context){
          //     return BlocBuilder<AuthCubit, AuthState>(
          //         // ignore: missing_return
          //         builder: (context,authState){
          //           if(authState is AuthState)
          //             return HomeScreen(uid: authState.uid,);
          //
          //           if(authState is UnAuthenticated){
          //             return WelcomeScreen();
          //             // ignore: dead_code
          //             return Container();
          //           }
          //         },
          //     );
          //   }
          // },
          // home: SplashScreen(),
        )
    );
  }
}
