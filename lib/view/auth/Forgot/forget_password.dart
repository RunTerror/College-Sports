
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/resources/Components/auth_button.dart';
import 'package:sports_application/resources/Components/profile_textfield.dart';
import 'package:sports_application/utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller=TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: h,width: w,),
          Container(height: h/3,width: w,color: ExternalColors.darkblue,),
          Positioned(
            left: 20,
            top: h/3-80,
            child:const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Forgot Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 30),),
              Text("Enter your email account to reset password",style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),)
            ],
            ),
          ),
          Positioned(top: h/3+20,left: (w-w/1.1)/2,child: ProfileField(namecontroller: emailcontroller, hintText: "Email", iconData: Icons.email)),
          Positioned(
            top: h/3+100,
            left: (w-w/1.1)/2,
            child: AuthButton(loading: loading,function: ()async{
              if(emailcontroller.text.isEmpty){
                Utils.flushbarErrorMessage("Enter email", context);
              }
              else{
                try {
                  setState(() {
                    loading=true;
                  });
                   await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim()).then((value) {
                    Utils.toastMessage("Check your email");
                    setState(() {
                      loading=false;
                    });
                   });
                  
                }on FirebaseAuthException catch (e) {
                  Utils.snackBar(e.message!, context);
                  
                }
              }
             
            }, text: "Send"),
          )
        ],
      ),
    );
  }
}