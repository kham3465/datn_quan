
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app/app_routes.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_button.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_input.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.only(left: 24),
            alignment: Alignment.centerLeft,
            child: Text(
              "Quên mật khẩu?",
              style: AppFonts.ultraBold(32, AppColors.grey500).copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: const Text(
              "Vui lòng nhập số điện thoại để lấy lại mật khẩu. Mã OTP xác thực sẽ được gửi về số điện thoại",
              maxLines: 4,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.only(top: 32, right: 24, left: 24),
              child: Column(
                children: [
                  SimpleInput(
                    titleInput: "Nhập SĐT đăng nhập",
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: SimpleButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.otpScreen,
                  arguments: false,
                );
              },
              titleButton: "Lấy mã xác nhận",
            ),
          ),
        ],
      ),
    );
  }
}
