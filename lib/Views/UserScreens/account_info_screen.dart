import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  bool readonly=true;
  String btnTitle ="Edit Info";

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getProfileData();
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          nameController.text = ShopCubit.get(context).getProfile!.data!.name;
          emailController.text = ShopCubit.get(context).getProfile!.data!.email;
          phoneController.text = ShopCubit.get(context).getProfile!.data!.phone;

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
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is ShopLoadingUpdateScreen)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      // defaultTextFormField(
                      //     label: 'Name',
                      //     controller: nameController,
                      //     readOnly: readonly,
                      //     validate: (String? value) {
                      //       if (value!.isEmpty) {
                      //         return "Name is Required";
                      //       }
                      //       return null;
                      //     },
                      //     prefix: Icons.person),

                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 12,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ] ,
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(children: [
                                Text("Name: ",style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: defaultColor),),
                                const SizedBox(width:10),
                                Text(nameController.text,style: TextStyle(fontSize: 18,)),
                              ],),
                            ),
                          ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ] ,
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                                Text("Email: ",style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: defaultColor),),
                                const SizedBox(width:10),
                                Text(emailController.text,style: TextStyle(fontSize: 18,)),
                              ],),
                        ),
                      ),

                      // defaultTextFormField(
                      //     label: 'Email',
                      //     readOnly: readonly,
                      //     controller: emailController,
                      //     validate: (String? value) {
                      //       if (value!.isEmpty) {
                      //         return "Email is Required";
                      //       }
                      //       return null;
                      //     },
                      //     prefix: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ] ,
                          ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                                Text("Phone: ",style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: defaultColor),),
                                const SizedBox(width:10),
                                Text(phoneController.text,style: TextStyle(fontSize: 18,)),
                              ],),
                        ),
                      ),



                      // defaultTextFormField(
                      //     label: 'Phone',
                      //     readOnly: readonly,
                      //     controller: phoneController,
                      //     validate: (String? value) {
                      //       if (value!.isEmpty) {
                      //         return "Phone is Required";
                      //       }
                      //       return null;
                      //     },
                      //     prefix: Icons.phone),

                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height /14,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(defaultColor)),
                          onPressed: () {
                                
                            if(!readonly){
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
                                
                            ShopCubit.get(context).UpdateUser(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
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
                );
              },
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) =>
            {if (state is ShopSuccessLogoutScreen) {}});
  }
}
