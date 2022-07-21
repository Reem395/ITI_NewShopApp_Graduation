import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Service/firebase_auth_methods.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';
import '../../ViewModels/Local/CacheHelper.dart';
import '../../utils/showSnackbar.dart';
import '../LayoutScreen/shopLayout.dart';
import 'SignupScreen.dart';
import '../../ViewModels/constants.dart';
import '../../ViewModels/Components.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'phone_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formState = GlobalKey<FormState>();
  bool passwordVisible = true;
  IconData suffixIcon = Icons.remove_red_eye;
  late String message;
 // bool admin= false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {
        if (state is ShopLLoginSuccessState) {
          CacheHelper.setData(key: "uId", value: uId);
            navigateAndReplace(context, ShopLayout());
          } else if(state is ShopLLoginErrorState) {
            message= "Your Data isn't Valid";
            buildShopToast(
                message: message,
                state: LoginState.fail,
                toastLength: Toast.LENGTH_LONG);
        }
      },
      builder: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: formState,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://play-lh.googleusercontent.com/-xe9J1jkAtSeFYUys7auPZ8iPFSykPPuUOeBQMvu8-I2PX4sLNnKyCMc-8sEWQ-C=w240-h480-rw',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: const [
                          Text(
                            "Log In Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please login to continue using our app",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Column(
                        children: [
                          defaultTextFormField(
                              controller: emailController,
                              label: "Email",
                              validate: (input) {
                                if (input!.isEmpty) {
                                  return "Email Field is Required";
                                }
                                return null;
                              },
                              prefix: Icons.email_outlined),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextFormField(
                            password: passwordVisible,
                            changePassword: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            controller: passwordController,
                            label: "Password",
                            validate: (input) {
                              if (input!.isEmpty) {
                                return "Password Field is Required";
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            suffix: !passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                         /* Row(
                            children: [
                              Text("User"),
                              Checkbox(value: value, onChanged: onChanged)
                            ],
                          ),*/
                          state is! ShopLLoginLoadingState
                              ? MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  height: 40,
                                  onPressed: () {
                                    if (formState.currentState!.validate()) {
                                      cubit.signIn(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                )
                              : const CircularProgressIndicator(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateAndReplace(
                                        context, const SignupScreen());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ))
                            ],
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "--------------------Or--------------------",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                              width: 230,
                              child: SignInButton(
                                Buttons.Google,
                                text: "Sign up with Google",
                                onPressed: () {
                                  FirebaseAuthMethods(FirebaseAuth.instance)
                                      .signInWithGoogle(context)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShopLayout()),
                                    );
                                  }).catchError((onError) {
                                    print("Error: ${onError.message!}");
                                    showSnackBar(context, onError.message!);
                                  });
                                },
                                shape:
                                    Border.all(color: defaultColor, width: 1),
                              )),
                          SizedBox(
                              width: 230,
                              child: SignInButton(
                                Buttons.Facebook,
                                text: "Sign up with Facebook",
                                onPressed: () {
                                  FirebaseAuthMethods(FirebaseAuth.instance)
                                      .signInWithFacebook(context)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShopLayout()),
                                    );
                                  }).catchError((onError) {
                                    print("Error: ${onError.message!}");
                                    showSnackBar(context, onError.message!);
                                  });
                                },
                                shape:
                                    Border.all(color: defaultColor, width: 1),
                              )),
                          SizedBox(
                            width: 230,
                            child: ElevatedButton.icon(
                                label: const Text("Sign in with Phone number"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PhoneScreen()),
                                  );
                                },
                                icon: const Icon(Icons.phone),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            side: BorderSide(
                                                color: defaultColor))))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
