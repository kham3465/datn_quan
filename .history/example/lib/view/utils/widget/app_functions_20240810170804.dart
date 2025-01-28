
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/model/image_model.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/provider/loading_provider.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/touch_able_widgets.dart';
import 'package:flutter_background_geolocation_example/view/widgets/normal_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppFunctions {
  //Kiên thêm
  static double heightAccording(BuildContext context, double heightAccording) {
    double screenHeight = MediaQuery.of(context).size.height;
    return (heightAccording * screenHeight) / 812.0;
  }

//
  static showLoading(BuildContext context) {
    context.read<LoadingProvider>().showLoading();
  }

  static hideLoading(BuildContext context) {
    context.read<LoadingProvider>().hideLoading();
  }

  static void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static bool checkNullAndFalse(bool? check) {
    if (check == null) {
      return false;
    } else if (check == false) {
      return false;
    }
    return true;
  }

  static bool isNullEmpty(Object o) => "" == o;

  static checkValidPhone(String phone) {
    // String phoneNumber = AppUtils.convertPhoneToOrigin(phone);
    bool isValid = false;
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (phone.length == 10) {
      String firstNumber = phone.substring(0, 2);
      isValid = (firstNumber == '09' ||
          firstNumber == '08' ||
          firstNumber == '07' ||
          firstNumber == '03' ||
          firstNumber == '05');
    }
    if (!regExp.hasMatch(phone)) {
      isValid = false;
    }
    return isValid;
  }

  static String formatDate(DateTime input) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(input);
    return formatted;
  }

  static String formatDateString(String? input, {bool? haveTime}) {
    if (input != null) {
      final date = DateTime.parse(input);
      if (haveTime == true) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');
        final String formatted = formatter.format(date);
        return formatted;
      } else {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String formatted = formatter.format(date);
        return formatted;
      }
    } else {
      return "";
    }
  }

  static void log(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static final imagePicker = ImagePicker();

  static Future<ImageModel?> pickImage({ImageSource? source}) async {
    XFile? image = await imagePicker.pickImage(
      maxHeight: 480,
      maxWidth: 640,
      source: source ?? ImageSource.gallery,
    );
    if (image != null) {
      var res = await ApiRequest.uploadImages(imagePaths: image);
      if (res.result == true) {
        ImageModel imageModel = ImageModel.fromJson(res.data);
        return imageModel;
      }
    }
    return null;
  }

  static Future<ImageModel?> pickCamera({ImageSource? source}) async {
    XFile? image = await imagePicker.pickImage(
      maxHeight: 480,
      maxWidth: 640,
      source: source ?? ImageSource.camera,
    );
    if (image != null) {
      var res = await ApiRequest.uploadImages(imagePaths: image);
      if (res.result == true) {
        ImageModel imageModel = ImageModel.fromJson(res.data);
        return imageModel;
      }
    }
    return null;
  }

  static void customBottomSheet({
    required BuildContext context, //bắt buộc phải có để show
    required Widget body, //phần thân
    Color? bodyColors, //màu của bottomsheeet
    String? title, //phần tittle k truyền vào sẽ k có nút close và devider
    bool? showButtonClose, // có show nút close k
    Color? backgroundColors, // màu đằng sau của mà hình khi có bottom sheeet
    bool? closeWhenTouch, //khi bấm ra màn hình sẽ close bottom sheet
    bool? isScroll, // bottom sheet có thể scroll hay k
    double? height,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScroll ?? true,
      isDismissible: closeWhenTouch ?? false,
      barrierColor: backgroundColors ?? AppThemes.black.withOpacity(0.3),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: height ?? MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: bodyColors ?? Colors.white,
          ),
          child: Column(
            children: [
              (title != null && title != "")
                  ? Container(
                      //   margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 12),
                        child: Row(
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  title,
                                  style: AppFonts.bold(),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                                  (showButtonClose != null && showButtonClose)
                                      ? TouchableWidget(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 25,
                                            weight: 10,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                    )
                  : const Padding(padding: EdgeInsets.only(top: 30)),
              (title != null && title != "")
                  ? Container(
                      height: 1,
                      color: AppThemes.light1,
                      width: MediaQuery.of(context).size.width,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                ),
                child: Center(child: body),
              ))
            ],
          ),
        );
      },
    );
  }

  static void showCustomSnackbarSuccess(BuildContext context,
      {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          // Đặt bán kính cho Snackbar
          borderRadius: BorderRadius.circular(12), // Thiết lập bán kính ở đây
        ),
        backgroundColor: const Color(0xFF00C7A3),
        content: Row(
          children: [
            Image.asset(
              AppImages.iconSuccess,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              message ?? "Gửi thông báo thành công",
              style: AppFonts.quicksandSemi600(
                16,
                Colors.white,
              ),
            )
          ],
        ),

        duration: const Duration(seconds: 3), // Thời gian hiển thị Snackbar
        behavior:
            SnackBarBehavior.floating, // Đặt hiệu ứng hiển thị cho Snackbar
        // action: SnackBarAction(
        //   label: 'Close',
        //   onPressed: () {
        //     ScaffoldMessenger.of(context)
        //         .hideCurrentSnackBar(); // Đóng Snackbar khi nhấn nút Close
        //   },
        // ),
      ),
    );
  }

  static void showCustomSnackbarError(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          // Đặt bán kính cho Snackbar
          borderRadius: BorderRadius.circular(12), // Thiết lập bán kính ở đây
        ),
        backgroundColor: const Color(0xFFFF644D),
        content: Row(
          children: [
            Image.asset(
              AppImages.iconError,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              message ?? "Gửi thông báo thành công",
              style: AppFonts.quicksandSemi600(
                16,
                Colors.white,
              ),
            )
          ],
        ),

        duration: const Duration(seconds: 3), // Thời gian hiển thị Snackbar
        behavior:
            SnackBarBehavior.floating, // Đặt hiệu ứng hiển thị cho Snackbar
        // action: SnackBarAction(
        //   label: 'Close',
        //   onPressed: () {
        //     ScaffoldMessenger.of(context)
        //         .hideCurrentSnackBar(); // Đóng Snackbar khi nhấn nút Close
        //   },
        // ),
      ),
    );
  }

  static calculateFontSize(BuildContext context, int i) {}

  static void showDialogAlert(
    BuildContext context, {
    String? title,
    String? description,
    String? text1stButton,
    String? text2ndButton,
    Function()? onPress1stButton,
    Function()? onPress2ndButton,
    Function()? onPressedClose,
    bool? isTwoButton,
    Widget? widgetDescription,
    String? image,
    Widget? customImage,
    bool? hideBtnBottom,
    TextStyle? styleTitle,
    TextStyle? styleDescription,
    String? imageClose,
    Color? color1,
    Color? color2,
    Color? colorText1,
    Color? colorText2,
    bool? noDivider,
    bool? dismiss,
    bool? showBtnClose,
    Function(void Function())? setStateCallback,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return NormalDialog(
              dismiss: dismiss,
              onPressedClose: onPressedClose,
              title: title,
              styleTitle: styleTitle,
              description: description,
              text1stButton: text1stButton,
              text2ndButton: text2ndButton,
              onPress1stButton: onPress1stButton,
              onPress2ndButton: onPress2ndButton,
              isTwoButton: isTwoButton,
              widgetDescription: widgetDescription,
              image: image,
              showBtnClose: showBtnClose,
              customImage: customImage,
              hideBtnBottom: hideBtnBottom,
              noDivider: noDivider,
              styleDescription: styleDescription,
              imageClose: imageClose,
              color1: color1,
              color2: color2,
              colorText1: colorText1,
              colorText2: colorText2,
              setStateCallback: setStateCallback,
            );
          });
        });
  }

  static void showDialogAlertInformation(
    BuildContext context, {
    String? title,
    String? content,
  }) {
    showDialogAlert(context,
        widgetDescription: Column(
          children: [
            Image.asset(
              AppImages.iconDone,
              width: 55,
              height: 55,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Lưu thành công",
              style: AppFonts.quicksand700(
                18,
                AppColors.grey500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Kết quả có mặt ',
                    style: AppFonts.quicksandMedium500(
                      16,
                      AppColors.grey500,
                    ),
                  ),
                  TextSpan(
                    text: '19/20',
                    style: AppFonts.quicksandMedium500(
                      16,
                      AppColors.primary600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
        text1stButton: "Đóng");
  }

  static void showDialogAlertWarning(
    BuildContext context, {
    String? title,
    String? content,
  }) {
    showDialogAlert(
      context,
      isTwoButton: true,
      colorText1: AppColors.grey500,
      widgetDescription: Column(
        children: [
          Image.asset(
            AppImages.iconWarning,
            width: 55,
            height: 55,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Thông báo",
            style: AppFonts.quicksand700(
              18,
              AppColors.grey500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Bạn chưa điểm danh học sinh nào.\n',
                  style: AppFonts.quicksandMedium500(
                    16,
                    AppColors.grey400,
                  ),
                ),
                TextSpan(
                  text: 'Bạn có chắc chắn lưu kết quả không?',
                  style: AppFonts.quicksandMedium500(
                    16,
                    AppColors.grey400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
      text1stButton: "Không",
      // onPress1stButton: () {
      //   Navigator.of(context).pop();
      // },
      text2ndButton: "Có",
      onPress2ndButton: () {},
    );
  }
}
