import 'package:flutter/material.dart';

import '../constants.dart';
import "../widgets/custom_textView.dart";
import "../provider/model_hud.dart";
import "package:modal_progress_hud/modal_progress_hud.dart";
import "package:provider/provider.dart";
import "../models/product.dart";
import "../services/store.dart";

class EditProductScreen extends StatelessWidget {
  static const routeEditProductScreen="/EditProductScreen";
  final GlobalKey<FormState> _globalKeyAddProduct=GlobalKey<FormState>();
  String name,price,description,category,imageLocatoin;
  final _store=Store();
  @override
  Widget build(BuildContext context) {
   final Map<String, String> data=ModalRoute.of(context).settings.arguments as Map<String ,String>;
    return Scaffold(
      body:  ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKeyAddProduct,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 130,),
                CustomeTextField(initValue:data[kProductName],onClick: (value){name=value;}, hintText: "Product Name", iconText: Icons.star),
                SizedBox(height: 10,),
                CustomeTextField(initValue:data[kProductPrice],onClick: (value){price=value;}, hintText: "Product Price", iconText: Icons.star),
                SizedBox(height:10),
                CustomeTextField(initValue:data[kProductDescription],onClick: (value){description=value;}, hintText: "Product Description", iconText: Icons.star),
                SizedBox(height:10),
                CustomeTextField(initValue:data[kProductCategory],onClick: (value){category=value;}, hintText: "Product Category", iconText: Icons.star),
                SizedBox(height:10),
                CustomeTextField(initValue:data[kProductLocation],onClick: (value){imageLocatoin=value;}, hintText: "Product Location", iconText: Icons.star),
                SizedBox(height:30),
                ElevatedButton(onPressed: (){
                  ModelHud modelHud=Provider.of<ModelHud>(context,listen: false);
                  modelHud.isChanging(true);
                  if(_globalKeyAddProduct.currentState.validate()){
                    _globalKeyAddProduct.currentState.save();
                    _store.updateProduct(Product(pName:name, pPrice:price, pLocation:imageLocatoin,
                        pDescription:description, pCategory:category), data[kDocumentId]);

                    modelHud.isChanging(false);
                  }else{ modelHud.isChanging(false);

                  }
                }, child: Text("Save Product")),
              ],),
          ),
        ),
      ),
    );
  }
}
