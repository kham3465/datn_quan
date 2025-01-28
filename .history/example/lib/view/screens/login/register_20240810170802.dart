import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/screens/base_screen/base_screen.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_button.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends BaseScreen {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BaseState<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController avaController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final FocusNode _field2FocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedRole;
  String? imagePath;

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    companyController.dispose();
    levelController.dispose();
    nickNameController.dispose();
    avaController.dispose();
    dobController.dispose();
    _field2FocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _uploadImage(); // Gọi hàm upload ảnh sau khi chọn ảnh
    }
  }

  Future<void> _uploadImage() async {
    if (imagePath != null && imagePath!.isNotEmpty) {
      try {
        final res =
            await ApiRequest.uploadImages(imagePaths: XFile(imagePath!));
        if (res.code == "200") {
          if (res.data.isNotEmpty) {
            String imageUrl = res.data[0]['url'];
            print('Uploaded image URL: $imageUrl');
            setState(() {
              avaController.text = imageUrl; // Gán URL vào text controller
            });
          } else {
            print('No data received from the server.');
          }
        } else {
          print('Failed to upload image: ${res.message}');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image selected.');
    }
  }

  Future<void> _submitRegistration() async {
    if (_formKey.currentState!.validate()) {
      // Validate succeeded, proceed with registration
      String name = userNameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text;
      DateTime? dob;
      if (dobController.text.isNotEmpty) {
        dob = DateTime.tryParse(dobController.text);
      }
      String address = addressController.text.trim();
      String company = companyController.text.trim();
      String role = selectedRole ?? "";
      int hasShip = 0; // Cập nhật theo logic của bạn cho hasShip
      String level = levelController.text.trim();
      String nickName = nickNameController.text.trim();
      String ava = avaController.text.trim();

      final res = await ApiRequest.userRegister(
        name,
        phone,
        password,
        email,
        dob ?? DateTime.now(), // Cung cấp một giá trị mặc định nếu dob là null
        address,
        company,
        role,
        hasShip,
        level,
        nickName,
        ava,
      );

      if (res.code == "200") {
        // Đăng ký thành công, hiển thị dialog thông báo thành công
        _showSuccessDialog();
      } else {}
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
                // Thực hiện điều hướng đến màn hình tiếp theo (nếu cần)
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
                // Có thể thêm thao tác khác sau khi đóng dialog
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
          image: AssetImage(AppImages.backgroundLogin),
          fit: BoxFit.cover,
        ),
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
                        titleInput: "Số điện thoại *",
                        controller: phoneController,
                        hintText: "Nhập số điện thoại",
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Email *",
                        controller: emailController,
                        hintText: "Nhập email",
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Địa chỉ *",
                        controller: addressController,
                        hintText: "Nhập địa chỉ",
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Công ty *",
                        controller: companyController,
                        hintText: "Nhập tên công ty",
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Loại tài khoản *",
                          hintText: "Chọn loại tài khoản",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        value: selectedRole,
                        items: ["SAILOR", "SERVICE"]
                            .map((role) => DropdownMenuItem<String>(
                                  value: role,
                                  child: Text(role),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Hãy chọn loại tài khoản' : null,
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Mức độ *",
                        controller: levelController,
                        hintText: "Nhập mức độ",
                      ),
                      const SizedBox(height: 20),
                      SimpleInput(
                        titleInput: "Biệt danh *",
                        controller: nickNameController,
                        hintText: "Nhập biệt danh",
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _pickImage(),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Ảnh đại diện *',
                                  prefixIcon: Icon(Icons.image),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child:
                                    Text(imagePath ?? 'Chọn ảnh từ thư viện'),
                              ),
                            ),
                          ),
                        ],
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
          ],
        ),
      ),
    );
  }
}
