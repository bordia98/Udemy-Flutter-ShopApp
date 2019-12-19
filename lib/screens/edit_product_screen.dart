import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {


  final _pricefocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _urlfocus = FocusNode();
  final _imagecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var _tempproduct = Product(
    id: null,
    description: "",
    imageUrl: "",
    price: 0.0,
    title: ""
    );

  @override
  void initState() {
    _urlfocus.addListener(_updateimage);
    super.initState();
  }

  void _updateimage(){
    if(!_urlfocus.hasFocus){
      setState(() {
      });
    }
  }



  @override
  void dispose() {
    _urlfocus.removeListener(_updateimage);
    _pricefocus.dispose();
    _descriptionfocus.dispose();
    _urlfocus.dispose();
    _imagecontroller.dispose();
    super.dispose();
  }

  void _saveproduct(){
    var valid = _formkey.currentState.validate();
    if(!valid){
      return;
    }
    _formkey.currentState.save();
    final productData = Provider.of<ProductProvider>(context,listen: false);
    productData.addProduct(_tempproduct);
    Navigator.of(context).pushNamedAndRemoveUntil("/userproduct", ModalRoute.withName("/"));
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context,listen: false);
    final String  id = ModalRoute.of(context).settings.arguments as String;
    print("*************");
    print(id);
    print("**************");
    bool newadd = false;
    Product check;
    if(id.length > 0){
      check = product.listofproducts.firstWhere((pro)=> pro.id == id );
      _imagecontroller.text = check.imageUrl;
      _tempproduct= Product(
        id: check.id,
        title: check.title,
        price: check.price,
        description: check.description,
        imageUrl: check.imageUrl
      );
    }else{
      newadd = true;
    }
      
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                       decoration: InputDecoration(
                         labelText: "Title",
                         ),
                        //  initialValue: check.title,
                       initialValue: newadd ? "" : check.title,
                       textInputAction: TextInputAction.next,
                       validator: (value){
                         if(value.isEmpty){
                           return "Title can't be empty";
                         }
                         return null;
                       },
                       onFieldSubmitted: (_){
                         FocusScope.of(context).requestFocus(_pricefocus);
                       },
                       onSaved: (value){
                         _tempproduct = Product(
                            id: _tempproduct.id,
                            description: _tempproduct.description,
                            price: _tempproduct.price,
                            title: value,
                            imageUrl: _tempproduct.imageUrl
                         );
                       },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _pricefocus,
                    initialValue: newadd ? "" : check.price.toString(),
                    validator: (value){
                      if(value.isEmpty){
                        return "Price can't be empty";
                      }
                      if(double.parse(value)== null){
                        return "Enter a valid number";
                      }
                      if(double.parse(value)<=0){
                        return "Price value should be greater than 0";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_descriptionfocus);
                    },
                    onSaved: (value){
                        _tempproduct = Product(
                          id: _tempproduct.id,
                          description: _tempproduct.description,
                          price: double.parse(value),
                          title: _tempproduct.title,
                          imageUrl: _tempproduct.imageUrl
                        );
                      },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                     decoration: InputDecoration(labelText: "Description"),
                     maxLines: 3,
                     keyboardType: TextInputType.multiline,
                     focusNode: _descriptionfocus,
                     initialValue: newadd ? "" : check.description,
                     validator: (value){
                       if(value.isEmpty){
                         return "This can't be empty";
                       }
                       if(value.length <= 10){
                         return "Description length must be greater than 10 characters";
                       }
                       return null;
                     },
                     onSaved: (value){
                        _tempproduct = Product(
                          id: _tempproduct.id,
                          description: value,
                          price: _tempproduct.price,
                          title: _tempproduct.title,
                          imageUrl: _tempproduct.imageUrl
                        );
                      },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                     decoration: InputDecoration(labelText: "Image Url"),
                     keyboardType: TextInputType.url,
                     controller: _imagecontroller,
                     focusNode: _urlfocus,
                     initialValue: null,
                     validator: (value){
                       if(value.isEmpty){
                         return "Image url can't be empty";
                       }
                       if(!value.startsWith("http") && !value.startsWith("https")){
                         return "Enter a valid url";
                       }

                      //  if(!value.endsWith("jpg") && !value.endsWith("png") && !value.endsWith("jpeg")){
                      //    return "We expect jpg,png,jpeg format only";
                      //  }
                                    
                       return null;
                     },
                     onSaved: (value){
                        _tempproduct = Product(
                          id: _tempproduct.id,
                          description: _tempproduct.description,
                          price: _tempproduct.price,
                          title: _tempproduct.title,
                          imageUrl: value
                        );
                      },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  height: 200,
                  width: 250,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: 
                      Center(
                        child: _imagecontroller.text.isEmpty 
                          ? Text(
                            "Enter a Url",
                            textAlign: TextAlign.center,
                          ) 
                          : FittedBox ( 
                            child: Image.network(_imagecontroller.text),
                            fit: BoxFit.cover
                          ),
                      ),
                  )
               ),
               Container(
                 margin: EdgeInsets.all(30),
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                
                        borderRadius: BorderRadius.circular(30),
                        child: Icon(
                          Icons.save,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 50,
                        ),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _saveproduct,
                 ),
               )
            ],
          ),
        ),
      ),
    );
  }
}