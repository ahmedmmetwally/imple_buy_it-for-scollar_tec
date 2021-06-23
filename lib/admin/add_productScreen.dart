import"package:flutter/material.dart";
import "../widgets/custom_textView.dart";
import "../provider/model_hud.dart";
import "package:modal_progress_hud/modal_progress_hud.dart";
import "package:provider/provider.dart";
import "../models/product.dart";
import "../services/store.dart";
class AddProductScreen extends StatelessWidget {
  static const routeAddProductScreen="/AddProductScreen";
  final GlobalKey<FormState> _globalKeyAddProduct=GlobalKey<FormState>();
  String name,price,description,category,imageLocatoin;
  final _store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKeyAddProduct,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomeTextField(onClick: (value){name=value;}, hintText: "Product Name", iconText: Icons.star),
              SizedBox(height: 10,),
              CustomeTextField(onClick: (value){price=value;}, hintText: "Product Price", iconText: Icons.star),
              SizedBox(height:10),
              CustomeTextField(onClick: (value){description=value;}, hintText: "Product Description", iconText: Icons.star),
              SizedBox(height:10),
              CustomeTextField(onClick: (value){category=value;}, hintText: "Product Category", iconText: Icons.star),
              SizedBox(height:10),
              CustomeTextField(onClick: (value){imageLocatoin=value;}, hintText: "Product Location", iconText: Icons.star),
              SizedBox(height:30),
              ElevatedButton(onPressed: (){
                ModelHud modelHud=Provider.of<ModelHud>(context,listen: false);
                modelHud.isChanging(true);
                if(_globalKeyAddProduct.currentState.validate()){
                  _globalKeyAddProduct.currentState.save();
                  _store.addProduct(Product(
                      pName:name, pPrice:price, pLocation:imageLocatoin,
                      pDescription:description, pCategory:category,));
                  modelHud.isChanging(false);
                }else{ modelHud.isChanging(false);

                }
              }, child: Text("Save Product")),
            ],),
        ),
      ),
    );
  }
}
