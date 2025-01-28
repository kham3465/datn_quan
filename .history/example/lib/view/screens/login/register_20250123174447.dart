import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app/app_routes.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/screens/base_screen/base_screen.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_button.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_input.dart';

class RegisterScreen extends BaseScreen {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BaseState<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController numberCarController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedRole;
  String? imagePath;

  @override
  void dispose() {
    userNameController.dispose();
    numberCarController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<void> _submitRegistration() async {
    if (_formKey.currentState!.validate()) {
      String name = userNameController.text.trim();
      String numberCar = numberCarController.text.trim();
      String password = passwordController.text;
      final res = await ApiRequest.userRegister(
        name,
        numberCar,
        password
      );
      if (res.code == "200") {
        _showSuccessDialog();
      } else {

      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đăng ký thành công"),
          content: Text("Bạn đã đăng ký thành công tài khoản."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đăng ký thất bại"),
          content: Text("Đăng ký tài khoản thất bại. Lỗi: $errorMessage"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Tạo tài khoản",
                          style: AppFonts.quicksand700(24, AppColors.grey500),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Tên đăng nhập *",
                        controller: userNameController,
                        hintText: "Nhập tên đăng nhập",
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Biển số xe *",
                        controller: numberCarController,
                        hintText: "Nhập biển số xe",
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        isPassword: true,
                        titleInput: "Mật khẩu *",
                        controller: passwordController,
                        hintText: "Nhập mật khẩu",
                        obscureText: true, // Ẩn mật khẩu
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SimpleButton(
                          titleButton: "Đăng ký",
                          colorButton: const Color(0xff1F1F39),
                          onPressed: () => _submitRegistration(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
               const SizedBox(height: 18),
TextButton(
  onPressed: () {
    Navigator.pushNamed(context, AppRoutes.loginScreen); // Điều hướng tới màn hình đăng ký
  },
  child: Text(
    "Đăng nhập",
    style: TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1), // Màu sắc của chữ
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}
