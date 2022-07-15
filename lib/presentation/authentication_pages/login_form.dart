import 'package:cas_finance_management/configuration.dart';

import 'package:cas_finance_management/presentation/screens/course/course_page.dart';

import 'package:cas_finance_management/presentation/screens/home_page.dart';
import 'package:cas_finance_management/presentation/widgets/form_validator.dart';
import 'package:cas_finance_management/presentation/widgets/internet_connectivity.dart';
import 'package:cas_finance_management/providers/provider_notifier_models.dart';
import 'package:cas_finance_management/repository/firebase/firebase_auth/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

UserAuthentication userAuth = UserAuthentication();

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Responsive? _responsive;

  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  Widget _emailPasswordLoginWidget() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          InputFormField(
            controller: _emailEditingController,
            validator: (value) => FormValidator.emailFieldValidator(value),
            labelText: 'Email ID',
            hintText: 'UserName@Gmail.com',
            keyboardType: TextInputType.emailAddress,
            inputFormatters: InputFormat.emailInputFormat,
            icon: const Icon(
              Icons.mail_outline,
              color: ColorSchema.blue,
            ),
            textInputAction: TextInputAction.next,
          ),
          Consumer<PasswordVisibilityNotifier>(
            builder: (context, value, child) => InputFormField(
              controller: _passwordEditingController,
              inputFormatters: InputFormat.passwordInputFormat,
              keyboardType: TextInputType.text,
              validator: (value) => FormValidator.passwordFieldValidator(value),
              labelText: 'Password',
              hintText: 'password',
              obscureText: value.passwordVisibility,
              icon: const Icon(
                Icons.lock_outline_rounded,
                color: ColorSchema.blue,
              ),
              suffixWidget: IconButton(
                onPressed: () {
                  Provider.of<PasswordVisibilityNotifier>(context,
                          listen: false)
                      .password();
                },
                icon: Icon(
                  value.passwordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logInButton() {
    return InkWell(
      onTap: () async {
        if (_loginFormKey.currentState!.validate()) {
          await userAuth
              .userSignInWithEmailAndPassword(
                  email: _emailEditingController.text,
                  password: _passwordEditingController.text)
              .then((value) {
            if (value!.emailVerified) {
              Navigator.pushNamed(context, CoursePage.routeName);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email no verified')));
            }
          }).onError((error, stackTrace) {
            if (userAuth.isUserNotFound) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email Not Found')));
            } else if (userAuth.isWrongPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wrong Password')));
            }
          });
        }
      },
      child: Container(
        width: _responsive!.width! * 0.75,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: ColorSchema.blue),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: const Text('Forgot Password ?',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _googleButton() {
    return InkWell(
      onTap: () async {
        ConnectivityChangeNotifier _change = ConnectivityChangeNotifier();
        await _change.initialState();

        if (_change.isNoInternet) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('No Internet')));
        } else {
          await userAuth.userGoogleSignIn().then(
              (value) => {Navigator.pushNamed(context, HomePage.routeName)});
        }
      },
      child: Container(
        height: _responsive!.height! * 0.06,
        width: _responsive!.width! * 0.80,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  width: double.infinity,
                  height: double.infinity,
                  child: const Image(
                    image: AssetImage('assets/images/google.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('Continue with Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _responsive = Responsive(
        aspectRatio: _size.aspectRatio,
        width: _size.width,
        height: _size.height,
        size: _size);
    return Column(
      children: <Widget>[
        SizedBox(height: _responsive!.height! * 0.02),
        _emailPasswordLoginWidget(),
        SizedBox(height: _responsive!.height! * 0.02),
        _logInButton(),
        _forgotPasswordButton(),
        _divider(),
        _googleButton(),
      ],
    );
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}

// End Login Form

