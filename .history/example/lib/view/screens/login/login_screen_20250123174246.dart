import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_background_geolocation_example/view/app/app_routes.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/provider/user_provider.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/screens/base_screen/base_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/base_screen/base_screen_mixin.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_button.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends BaseScreen {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseState<LoginScreen> with BaseScreenMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _field2FocusNode = FocusNode();
  bool isCheck = false;

  // @override
  // void dispose() {
  //   phoneController.dispose();
  //   passwordController.dispose();
  //   _field2FocusNode.dispose();
  //   super.dispose();
  // }

  final _formKey = GlobalKey<FormState>();
  Color colorIcon = const Color(0xff1F1F39);

  @override
  Widget buildHeader() => const SizedBox.shrink();

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://img4.thuthuatphanmem.vn/uploads/2020/07/30/background-khai-giang-cuc-dep_024036461.jpg'),
              fit: BoxFit.cover)
              ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: Container(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Đăng nhập",
                          style: AppFonts.quicksand700(
                            24,
                            AppColors.grey500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SimpleInput(
                        titleInput: "Tên người dùng",
                        controller: nameController,
                        hintText: "Nhập vào tên người dùng",
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SimpleInput(
                        titleInput: "Mật khẩu",
                        hintText: "Nhập mật khẩu",
                        isPassword: true,
                        colorIcon: colorIcon,
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SimpleButton(
                        onPressed: () async {
                          login(nameController.text, passwordController.text);
                        },
                        titleButton: "Đăng nhập",
                      ),
                      const SizedBox(height: 18),
TextButton(
  onPressed: () {
    Navigator.pushNamed(context, AppRoutes.register); // Điều hướng tới màn hình đăng ký
  },
  child: Text(
    "Đăng ký",
    style: TextStyle(
      color: Color.fromRGBO(0, g, b, opacity) // Màu sắc của chữ
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> login(BuildContext context) async {

  //   AppFunctions.hideKeyboard(context);
  //
  //     showLoading();
  //     setState(() {
  //       colorIcon = const Color(0xff1F1F39);
  //     });
  //  print(res);
  //     if (res.code == "200" && context.mounted) {
  //      print(res);
  //       Navigator.pushNamed(
  //                           context,
  //                           AppRoutes.homeMainScreen,
  //                         );
  //     } else {

  //     }

  // }
  Future<void> login(String name, String pass) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final res = await ApiRequest.userLogin(name, pass);
    if (res.code == "200" && context.mounted) {
      userProvider.setUser(UserModel.fromJson(res.data['user']));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('idUser', res.data['user']['id']);
      print(res.data['user']['id'].toString() +
          " check xem ở chỗ này có đúng ko");
   Navigator.pushNamedAndRemoveUntil(
  context,
  AppRoutes.home, // Route của trang đích
  (route) => false, // Điều kiện để xóa các route cũ, `false` nghĩa là xóa hết
);
      void showSuccessDialog(BuildContext context) {
        showDialog(
          context: context,
          barrierDismissible:true, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Thành công'),
              content: Text('Đăng nhập thành công!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                ),
              ],
            );
          },
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thất bại'),
            content: Text('Tên tài khoản hoặc mật khẩu không đúng.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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
}
