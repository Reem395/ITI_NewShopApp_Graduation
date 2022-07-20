import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:shop_app/Views/UserScreens/LoginScreen.dart';
import '../../Service/firebase_auth_methods.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/Local/CacheHelper.dart';
import '../../ViewModels/constants.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';
import '../LayoutScreen/shopLayout.dart';
import 'phone_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool passwordVisible = true;
  IconData suffixIcon = Icons.remove_red_eye;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                          "Sign Up Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
                            prefix: Icons.person,
                            label: "Name",
                            controller: nameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Name is Required";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
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
                            prefix: Icons.phone,
                            label: "Phone",
                            controller: phoneController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Phone is Required";
                              }
                              return null;
                            }),
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
                        ConditionalBuilder(
                            condition: state is! ShopSignUpLoadingScreen,
                            builder: (context) => MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  height: 40,
                                  onPressed: () {
                                    ShopCubit.get(context).SignUp(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                            fallback: (context) =>
                                const CircularProgressIndicator()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ?",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateAndReplace(
                                      context, const LoginScreen());
                                },
                                child: Text(
                                  "Log In",
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
                                });
                              },
                              shape: Border.all(color: defaultColor, width: 1),
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
                                });
                              },
                              shape: Border.all(color: defaultColor, width: 1),
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
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is ShopSuccessSignUpScreen) {
          if (state.userSignData.status) {
            CacheHelper.setData(
                    key: "token", value: state.userSignData.data?.token)
                .then((value) {
              token = state.userSignData.data?.token;
              navigateAndReplace(context, ShopLayout());
              buildShopToast(
                  message: state.userSignData.message,
                  state: LoginState.success);
            });
          } else {
            buildShopToast(
                message: state.userSignData.message, state: LoginState.fail);
          }
        }
      },
    );
  }
}
