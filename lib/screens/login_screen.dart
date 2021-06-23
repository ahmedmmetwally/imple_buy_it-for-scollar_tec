import 'package:firebase_auth/firebase_auth.dart';
import"package:flutter/material.dart";
import '../constants.dart';
import "../widgets/custom_textView.dart";
import 'signup_screen.dart';
import "../services/auth.dart";
import "../user/home_page.dart";
import 'package:modal_progress_hud/modal_progress_hud.dart';
import "../provider/model_hud.dart";
import "package:provider/provider.dart";
import "../provider/admin_mode.dart";
import "package:buy_it_flutter_app/admin/admin_home_screen.dart";
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const ROUTELOGINSCREEN="/loginScreenroute";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginGlobalKey=GlobalKey<FormState>();

  Auth _auth=Auth();

  String email;

  String password;

  String adminPassword="admin1234";

  bool keepMeLoggedIn=false;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    final AdminMode adminMode=Provider.of<AdminMode>(context);
    return Scaffold(
      backgroundColor: KMainColor,
    body: ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Form(
        key: _loginGlobalKey,
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
          CustomeTextField(onClick:(value)=>email=value,hintText: "enter your email",iconText: Icons.email,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(children:<Widget>[
              Theme(
                data:ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(activeColor: KMainColor,
                  value: keepMeLoggedIn,
                  onChanged: (value){setState((){keepMeLoggedIn=value;});}
                  ),
              ),
              Text("Remember me",style: TextStyle(color: Colors.white),)
            ]),
          ),
          CustomeTextField(onClick:(value)=>password=value,hintText: "enter your password",iconText: Icons.lock,),
          SizedBox(height: height*.08,),
          Padding(padding:const EdgeInsets.symmetric(horizontal:140),
              child: FlatButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),color:Colors.black,
                  onPressed: ()async{
                    if(keepMeLoggedIn==true){
                      keepUserLoggedInFunction();
                    }
                      _validateMethod(context);
                  },
                  child: Text("Login",style: TextStyle(color:Colors.white),))),
          SizedBox(height: height*.03,),
          Row(mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[
            Text("don\'t have an account ? ",style:TextStyle(fontSize: 18,color: Colors.white)),
            GestureDetector(onTap:()=>Navigator.pushNamed(context, SignUpScreen.ROUTESIGNUPSCREEN),child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 18),))
        ],),
          SizedBox(height: height*.03,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[
            adminMode.isAdmin?GestureDetector(onTap: ()=>Provider.of<AdminMode>(context,listen: false).changingAdmin(false),child: Text("i\'m an user",style:TextStyle(fontSize: 18)))
                  : GestureDetector(onTap: ()=>Provider.of<AdminMode>(context,listen:false).changingAdmin(true),child: Text("i\'m an admin",style:TextStyle(fontSize: 18))),
            ]),
          )
        ],
        ),
      ),
    ));
  }

  void _validateMethod(BuildContext context) async{
//    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text()));
      final ModelHud modelHud=Provider.of<ModelHud>(context,listen:false);
      modelHud.isChanging(true);
       if( _loginGlobalKey.currentState.validate()){
         _loginGlobalKey.currentState.save();
         if(Provider.of<AdminMode>(context,listen: false).isAdmin){
           if(password==adminPassword){
             try{
            await _auth.signIn(email.trim(), password.trim());
             modelHud.isChanging(false);
             Navigator.pushNamed(context,AdminHome.ROUTEADMINHOMW );
             }catch(e){
               modelHud.isChanging(false);
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
             }
           }else{
             modelHud.isChanging(false);
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("thome thing is wrong")));
           }

         }else{
           try{
           await _auth.signIn(email, password);
           modelHud.isChanging(false);
           Navigator.pushNamed(context, HomePage.ROUTEHOMEPAGE);
           }catch(e){
             modelHud.isChanging(false);
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
           }
         }

   }
       modelHud.isChanging(false);

  }

  Future<void> keepUserLoggedInFunction() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}

