import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/Local/CacheHelper.dart';
import '../../ViewModels/constants.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';
import '../LayoutScreen/shopLayout.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Please enter your data to continue",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    labelField("Username"),
                    const SizedBox(height: 10,),
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
                    const SizedBox(height: 20,),
                    labelField("Email"),
                    const SizedBox(height: 10,),
                    defaultTextFormField(
                        prefix: Icons.email,
                        label: "Email",
                        controller: emailController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Email is Required";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20,),
                    labelField("Phone"),
                    const SizedBox(height: 10,),
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
                    const SizedBox(height: 20,),
                    labelField("Password"),
                    const SizedBox(height: 10,),
                    defaultTextFormField(
                        prefix: Icons.lock,
                        label: "Password",
                        controller: passwordController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Password is Required";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20,),
                    ConditionalBuilder(
                        condition: state is !ShopSignUpLoadingScreen,
                        builder: (context)=> ElevatedButton(onPressed: () {
                          ShopCubit.get(context).SignUp(name: nameController.text,
                              phone: phoneController.text, email: emailController.text, password: passwordController.text);
                        }, child: const Text("SignUp")),
                        fallback: (context)=> const CircularProgressIndicator())
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is ShopSuccessSignUpScreen)
          {
            if(state.userSignData.status)
              {
                CacheHelper.setData(key: "token", value: state.userSignData.data?.token)
                    .then((value) {
                  token= state.userSignData.data?.token;
                  navigateAndReplace(context, ShopLayout());
                        buildShopToast(message: state.userSignData.message, state: LoginState.success);
                });
              }
            else
              {
                buildShopToast(message: state.userSignData.message, state: LoginState.fail);
              }
          }
      },
    );
  }
}
