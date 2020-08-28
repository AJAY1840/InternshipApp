import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isloading = false;
  final formKey= GlobalKey<FormState>();
  AuthMethods authMethods= new AuthMethods();

  TextEditingController emailTextEditingController = new TextEditingController();

  TextEditingController passwordTextEditingController = new TextEditingController();

  TextEditingController usernameTextEditingController = new TextEditingController();

  signMeUp()
  {
    if(formKey.currentState.validate())
      {
        setState(() {
          isloading=true;
        });
        authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
            passwordTextEditingController.text).then((val) {
          print("$val");
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:  isloading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ):
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val)
                        {
                          return val.isEmpty || val.length<2 ? "Please provide a correct Username" : null;
                        },
                        controller: usernameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Username"),
                      ),
                      TextFormField(
                        validator: (val)
                        {
                          return  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").
                          hasMatch(val) ? null : "Enter a valid email-id";
                        },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("email"),
                      ),
                      TextFormField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        validator: (val) {
                          return val.length > 6
                              ? null
                              : "Enter Password 6+ characters";
                        },
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          "Forgot Password?",
                          style: simpleTextStyle(),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    signMeUp();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ],
                        )),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Sign Up",
                      style: biggerTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Sign Up with Google",
                    style:
                    TextStyle(fontSize: 17, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account? ",
                      style: simpleTextStyle(),
                    ),
                    Text(
                      "Sign In now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
