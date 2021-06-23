import 'package:buy_it_flutter_app/admin/edit_product_screen.dart';
import 'package:buy_it_flutter_app/admin/order_details.dart';
import 'package:buy_it_flutter_app/admin/order_screen.dart';
import 'package:buy_it_flutter_app/provider/cart_item.dart';
import 'package:buy_it_flutter_app/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import "./screens/signup_screen.dart";
import "package:firebase_core/firebase_core.dart";
import 'constants.dart';
import 'user/home_page.dart';
import "provider/admin_mode.dart";
import "package:buy_it_flutter_app/admin/admin_home_screen.dart";
import "admin/add_productScreen.dart";
import "admin/manageProduct.dart";
import "user/product_info.dart";
import "user/cart_screen.dart";
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  bool isUserLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(home:Scaffold(body: Center(child: Text("Is Looding...."),),));
        }else{
          isUserLoggedIn=snapshot.data.get(kKeepMeLoggedIn)?? false;
          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (context)=>ModelHud()),
            ChangeNotifierProvider(create:(context)=>AdminMode()),
            ChangeNotifierProvider.value(value: CartItem()),
          ],
            child: MaterialApp(
                initialRoute:isUserLoggedIn?HomePage.ROUTEHOMEPAGE: LoginScreen.ROUTELOGINSCREEN,
                routes: {
                  LoginScreen.ROUTELOGINSCREEN: (context) => LoginScreen(),
                  SignUpScreen.ROUTESIGNUPSCREEN:(context)=>SignUpScreen(),
                  HomePage.ROUTEHOMEPAGE:(context)=>HomePage(),
                  AdminHome.ROUTEADMINHOMW:(context)=>AdminHome(),
                  AddProductScreen.routeAddProductScreen:(context)=>AddProductScreen(),
                  ManageProduct.RouteEditProduct:(context)=>ManageProduct(),
                  EditProductScreen.routeEditProductScreen:(context)=>EditProductScreen(),
                  ProductInfo.routeProductInfo:(context)=>ProductInfo(),
                  CartScreen.routeCartScreen:(context)=>CartScreen(),
                  OrderScreen.routOrderSceen:(context)=>OrderScreen(),
                  OrderDetails.routeOrderDetails:(context)=>OrderDetails(),
                }
            ),
          );
        }
      },
    );
  }
}