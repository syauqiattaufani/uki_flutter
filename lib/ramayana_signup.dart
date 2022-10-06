import 'package:dio/dio.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uki_flutter/ramayana_home.dart';
import 'package:uki_flutter/ramayana_login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uki_flutter/service/SP_service/SP_service.dart';
import 'package:uki_flutter/service/API_service/API_service.dart';

class RamayanaSignup extends StatefulWidget {
  @override
  _RamayanaSignup createState() => _RamayanaSignup();
}

class _RamayanaSignup extends State<RamayanaSignup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller_nama_user = TextEditingController();
  final controller_password = TextEditingController();
  final controller_subdivisi = TextEditingController();
  var dio = Dio();

  late Size ukuranlayar;
  var akses = 'usr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 1200,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 168, 3, 3),
            ),
          ),

          ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
                height: 200,
                width: 400,
                // decoration: BoxDecoration(
                //   // color: Color.fromARGB(255, 230, 230, 230),
                //   borderRadius: BorderRadius.circular(10),
                // //),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/ram.png",
                      height: 200,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),

              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: RequiredValidator(errorText: "Wajib Diisi!"),
                      controller: controller_nama_user,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 10),

                    TextFormField(
                      validator: RequiredValidator(errorText: "Wajib Diisi!"),
                      controller: controller_password,
                      obscureText: true,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 10),

                    TextFormField(
                      validator: RequiredValidator(errorText: "Wajib Diisi!"),
                      controller: controller_subdivisi,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: Icon(
                          Icons.account_circle_sharp,
                          color: Colors.white,
                        ),
                        labelText: 'Divisi',
                      ),
                    ),
                    SizedBox(height: 10),

                    MaterialButton(
                      padding: EdgeInsets.symmetric(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      color: Colors.red,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                'Pendaftaran Berhasil!',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                        DateTime now = new DateTime.now();
                        //var _image;
                        var formData = FormData.fromMap({
                          'nama_user': controller_nama_user.text,
                          'password': controller_password.text,
                          'subdivisi': controller_subdivisi.text,

                        });
                        var response = await dio.post(
                            'http://ramayana.joeloecs.com/mobileapi/tambah_user.php',
                            data: formData
                        );
                        print('Berhasil, ${controller_nama_user.text}, ${controller_password.text}, ${controller_subdivisi.text}');

                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5),
              Container(
                  margin: EdgeInsets.only(left: 130),
                  child:
                  Row(
                    children: [
                      Text('Sudah Punya Akun?',
                          style:
                          TextStyle(fontSize: 18)),
                      TextButton(
                          child: Text('Masuk',
                            style: TextStyle(
                              //color: Colors.blue
                                fontSize: 18
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return RamayanaLogin();
                                    } ));
                          }
                      )
                    ],
                  )
              )
            ],
          ),

        ],
      ),
    );
  }
}
