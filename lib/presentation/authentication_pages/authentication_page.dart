import 'package:cas_finance_management/presentation/authentication_pages/signup_form.dart';
import 'package:cas_finance_management/providers/provider_notifier_models.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configuration.dart';
import '../widgets/widgets.dart';
import 'login_form.dart';

class AuthenticationPage extends StatefulWidget {
  static const routeName = '/login-signup';
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Responsive? _responsive;
  Widget _logo() {
    return SizedBox(
        height: _responsive!.height! * 0.15,
        width: _responsive!.width! * 0.30,
        child: const Image(
          image: AssetImage('assets/images/casLogo.png'),
          fit: BoxFit.cover,
        ));
  }

  // _logo()
  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
          color: ColorSchema.grey, borderRadius: BorderRadius.circular(50)),
      height: _responsive!.height! * 0.07,
      width: _responsive!.width! * 0.90,
      child: TabBar(
        indicator: const BoxDecoration(
            color: ColorSchema.blue,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        controller: _tabController,
        tabs: <Widget>[
          Tab(
              child: Text(
            'Login ',
            style: GoogleFonts.poppins(),
          )),
          Tab(
              child: Text(
            'SignUp',
            style: GoogleFonts.poppins(),
          )),
        ],
      ),
    );
  }

  // _tabBar()
  Widget _tabBarView() {
    return SizedBox(
      height: _responsive!.height! * 0.72,
      child: TabBarView(
          controller: _tabController,
          children: const <Widget>[LoginForm(), SignupForm()]),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _responsive = Responsive(
        aspectRatio: _size.aspectRatio,
        width: _size.width,
        height: _size.height,
        size: _size);

    return ChangeNotifierProvider(
      create: (context) => PasswordVisibilityNotifier(),
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -_responsive!.height! * .2,
                  left: _responsive!.width! * .4,
                  child: const BezierContainer()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: _responsive!.height! * 0.1),
                    _logo(),
                    _tabBar(),
                    _tabBarView()
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
