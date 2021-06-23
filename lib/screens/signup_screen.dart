import 'package:buy_it_flutter_app/provider/model_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../constants.dart";
import "../widgets/custom_textView.dart";
import "login_screen.dart";
import "../services/auth.dart";
import '../user/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatelessWidget {
  static const ROUTESIGNUPSCREEN="/signUpScreen";
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  String name;
  String password;
  String email;
 // bool isSave=false;
  Auth _auth =Auth();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: KMainColor,
        body: ModalProgressHUD(
          inAsyncCall:Provider.of<ModelHud>(context,listen:false).isLoading,
          child: Form(
            key: _formKey,
            child: ListView(children:<Widget> [
              Padding(
                padding: EdgeInsets.only(top: 44),
                child: Container(height: MediaQuery.of(context).size.height*.2,
                  child: Stack(alignment: Alignment.center,children:<Widget> [
                    Image(image:AssetImage("images/icons/icons8-buy-100.png",)),
                    Positioned(bottom:0,child: Text("Buy it",style:TextStyle(fontSize: 25,fontFamily: "Pacifico")))
                  ],),
                ),
              ),
              SizedBox(height: height*.1,),
              CustomeTextField(onClick: (value)=>name=value,hintText: "enter your name",iconText: Icons.email,),
              SizedBox(height: height*.02,),
              CustomeTextField(onClick: (value)=>email=value,hintText: "enter your email",iconText: Icons.email,),
              SizedBox(height: height*.02,),
              CustomeTextField(onClick:(value)=>password=value,hintText: "enter your password",iconText: Icons.lock,),
              SizedBox(height: height*.08,),
              Padding(padding:const EdgeInsets.symmetric(horizontal:140),
                  child: FlatButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),color:Colors.black,
                      onPressed: ()async{
                    final ModelHud modelHud=Provider.of<ModelHud>(context,listen:false);
                    modelHud.isChanging(true);
                    if(_formKey.currentState.validate()){
                      try{
                      _formKey.currentState.save();
                     final UserCredential result=await _auth.signUp(email.trim(), password.trim());
                    // Navigator.of(context).pushNamed(HomePage.ROUTEHOMEPAGE);
                      modelHud.isChanging(false);
                      Navigator.pushNamed(context, HomePage.ROUTEHOMEPAGE);
                     print (result.user.uid);
                      }catch(e){
                        print (e.toString());
                        modelHud.isChanging(false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                      }
                    }
                    modelHud.isChanging(false);
                      },
                      child: Text("signUp",style: TextStyle(color:Colors.white),))),
              SizedBox(height: height*.03,),
              Row(mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[
                Text("do have an account ? ",style:TextStyle(fontSize: 18,color: Colors.white)),
                GestureDetector(onTap:()=>Navigator.pushNamed(context,LoginScreen.ROUTELOGINSCREEN),child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 18),))
              ],)
            ],
            ),
          ),
        ));
  }
}
