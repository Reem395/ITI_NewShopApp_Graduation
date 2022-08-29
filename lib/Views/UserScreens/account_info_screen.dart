import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ViewModels/Widgets/profile_show_form.dart';
import 'package:shop_app/ViewModels/Widgets/profile_update_form.dart';
import 'LoginScreen.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';
import 'ResetPassword.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool readonly=true;
  String btnTitle ="Edit Info";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          nameController.text = ShopCubit.get(context).user!.name?? "";
          emailController.text = ShopCubit.get(context).user!.email?? "";
          phoneController.text = ShopCubit.get(context).user!.phone?? "";
          passwordController.text = ShopCubit.get(context).user!.password?? "";

          return ConditionalBuilder(
              condition: state is! ShopLoadingProfileScreen,
              builder: (context) {
                return Scaffold(
                  backgroundColor: Color.fromARGB(255, 237, 237, 237),
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(backgroundColor: defaultColor,
                  title: const Text("Account Info"),
                  ),
                  body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is ShopUpdateUserLoadingScreen)
                           LinearProgressIndicator(color: defaultColor,),
                        if(readonly==false)
                        UpdateForm(nameController, phoneController, passwordController),
                        if(readonly==true)
                          ShowProfileData(nameController, phoneController, emailController, passwordController),
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height /14,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(defaultColor)),
                            onPressed: () {
                              if(!readonly){
                                ShopCubit.get(context).upDateUser(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                                setState(() {
                                    btnTitle="Edit Info";                              
                                    readonly=true;
                                });
                              }
                              else{
                                  setState(() {
                                    btnTitle="Update";
                                    readonly=false;
                                  });
                              }
                            },
                            child: Text(btnTitle),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 2,
                        //   child: ElevatedButton(
                        //     style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all(defaultColor)),
                        //     onPressed: () {
                        //       Navigator.push(context, MaterialPageRoute(
                        //       builder: (BuildContext context) => const RestPasswordScreen(), ),);
                        //     },
                        //     child: const Text("Reset Password"),
                        //   ),
                        // ),
                  
                  
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        //  SizedBox(
                        //   width: MediaQuery.of(context).size.width / 2,
                        //   child: ElevatedButton(
                        //     style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all(defaultColor)),
                        //     onPressed: () {
                        //       ShopCubit.get(context).LogOut();
                        //       // navigateAndReplace(context, LoginScreen());
                        //       // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => LoginScreen()));
                        //     // Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => LoginScreen()), (r) => true);
                        //     Navigator.of(context, rootNavigator: true).push(
                        //        CupertinoPageRoute<bool>(
                        //         fullscreenDialog: true,
                        //         builder: (BuildContext context) => LoginScreen(),
                        //       ),
                        //     );
                        //     },
                        //     child: const Text("LogOut"),
                        //   ),
                        // ),
                                  
                        // const SizedBox(
                        //   height: 20,
                        // ),
                         
                      ],
                    ),
                  ),
                                ),
                );
              },
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) =>
            {if (state is ShopUpdateUserSuccessScreen) {
              showMessage("Data updated Successfully")
            }});
  }
}
