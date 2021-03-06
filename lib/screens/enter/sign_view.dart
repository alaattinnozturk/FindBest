import 'package:barber_app/constants.dart';
import 'package:barber_app/models/basicUser.dart';
import 'package:barber_app/screens/customer/cus_home_view.dart';
import 'package:barber_app/screens/employer/emp_home_view.dart';
import 'package:barber_app/screens/enter/sign_up_view.dart';
import 'package:barber_app/services/auth_shared_pref.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/basicUserInfo.dart';
import '../../services/server_handler.dart';

enum SignCondition { signIn, signUp }

class SignView extends StatefulWidget {
  const SignView({Key? key}) : super(key: key);

  @override
  _SignViewState createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  SignCondition signCondition = SignCondition.signIn;

  GlobalKey<FormState> textFieldKey = GlobalKey<FormState>();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController passwordAgainCtr = TextEditingController();

  bool isCustomer = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: textFieldKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/logo/find_best_logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Divider(
                  height: 16,
                  color: Colors.black,
                  thickness: 1.5,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                signCondition == SignCondition.signIn ? 'Sign In' : 'Sign Up',
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              textFormField(
                emailCtr,
                Icon(
                  Icons.email,
                  color: kTurquoise,
                ),
                'Email',
              ),
              textFormField(
                passwordCtr,
                Icon(
                  Icons.lock,
                  color: kTurquoise,
                ),
                'Password',
              ),
              signCondition == SignCondition.signIn
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Your Password',
                            style: TextStyle(
                              color: kTurquoise,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              signCondition == SignCondition.signUp
                  ? textFormField(
                      passwordAgainCtr,
                      Icon(
                        Icons.lock,
                        color: kTurquoise,
                      ),
                      'Password Again')
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    signCondition == SignCondition.signUp
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              checkbox('Customer'),
                              checkbox('Employer'),
                            ],
                          )
                        : Container(),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if (textFieldKey.currentState!.validate()) {
                          if (signCondition == SignCondition.signIn) {
                            print('King');
                            Map<dynamic, dynamic>? resultMapLoginUser =
                                await ServerHandler()
                                    .loginUser(emailCtr.text, passwordCtr.text);
                            print('Yes, King');
                            if (resultMapLoginUser!['success'] == 0) {
                              await _showMyDialog(
                                  'Error', resultMapLoginUser['message']);
                            } else {
                              BasicUser currentUser = BasicUser.fromMapForLogin(
                                  resultMapLoginUser['user']);
                              await AuthSharedPref()
                                  .saveAuthData(currentUser.email);
                              Provider.of<BasicUserInfo>(context, listen: false)
                                  .updateAllUserInfo(currentUser);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      currentUser.shopId == null
                                          ? CusHomeView()
                                          : EmpHomeView(),
                                ),
                              );
                            }
                          } else {
                            print('Hello1');
                            Provider.of<BasicUserInfo>(context, listen: false)
                                .updateEmailAndPassword(
                                    emailCtr.text, passwordCtr.text);
                            print('Hello2');
                            Provider.of<BasicUserInfo>(context, listen: false)
                                .updateType(
                                    isCustomer ? 'Customer' : 'Employer');
                            print('Hello3');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: signCondition == SignCondition.signIn
                            ? size.width - 32
                            : size.width / 2 - 16,
                        height: 60,
                        decoration: BoxDecoration(
                          color: kTurquoise,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            signCondition == SignCondition.signIn
                                ? 'Sign In'
                                : 'Sign Up',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    signCondition == SignCondition.signIn
                        ? 'Don\'t have account?'
                        : 'Do have account?',
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        signCondition == SignCondition.signIn
                            ? signCondition = SignCondition.signUp
                            : signCondition = SignCondition.signIn;
                        emailCtr.text = '';
                        passwordCtr.text = '';
                        passwordAgainCtr.text = '';
                      });
                    },
                    child: Text(
                      signCondition == SignCondition.signIn
                          ? 'Sign Up'
                          : 'Sign In',
                      style: TextStyle(color: kTurquoise),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row checkbox(String userType) {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: userType == 'Customer' ? isCustomer : !isCustomer,
            onChanged: (bool) {
              setState(() {
                userType == 'Customer' ? isCustomer = true : isCustomer = false;
              });
            }),
        Text(
          userType,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return kTurquoise;
    }
    return kTurquoise;
  }

  Padding textFormField(
    TextEditingController ctr,
    Icon icon,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return 'Don\'t leave blank';
          } else if (hintText != 'Email' &&
              signCondition == SignCondition.signUp &&
              passwordCtr.text != passwordAgainCtr.text) {
            return 'Please enter same password';
          } else if (hintText == 'Email') {
            if (!EmailValidator.validate(val)) {
              return 'Please enter valid email format';
            }
          }
        },
        controller: ctr,
        obscureText: hintText != 'Email' ? true : false,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String title, String detail) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(detail),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: kTurquoise,
              ),
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
