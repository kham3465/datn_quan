import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_dimens.dart';
import 'package:flutter_background_geolocation_example/view/provider/loading_provider.dart';
import 'package:flutter_background_geolocation_example/view/utils/fonts/app_font.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/dialog_midmaps.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/nomarl_dialog.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/touch_able_widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' as IO;


class AppFunction {
  static showLoading(BuildContext context) async {
    context.read<LoadingProvider>().showLoading();
  }

  static hideLoading(BuildContext context) async {
    context.read<LoadingProvider>().hideLoading();
  }

  static void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String getA(String html) {
    // Tìm vị trí của ký tự "<h2>A"
    int start = html.indexOf("<h2>A");

    // Nếu không tìm thấy ký tự "<h2>A", trả về chuỗi rỗng
    if (start == -1) return "";

    // Tìm vị trí của ký tự "</h2>"
    int end = html.indexOf("</h2>", start);

    // Nếu không tìm thấy ký tự "</h2>", trả về chuỗi rỗng
    if (end == -1) return "";

    // Trích xuất đoạn văn A từ chuỗi HTML
    String optionA = html.substring(start + 5, end);

    // Xóa khoảng trắng và ký tự "&nbsp;" cuối chuỗi
    optionA = optionA.trim().replaceAll("&nbsp;", "");

    return optionA;
  }

  static String getB(String html) {
    // Tìm vị trí của ký tự "<h2>B"
    int start = html.indexOf("<h2>B");

    // Nếu không tìm thấy ký tự "<h2>B", trả về chuỗi rỗng
    if (start == -1) return "";

    // Tìm vị trí của ký tự "</h2>"
    int end = html.indexOf("</h2>", start);

    // Nếu không tìm thấy ký tự "</h2>", trả về chuỗi rỗng
    if (end == -1) return "";

    // Trích xuất đoạn văn B từ chuỗi HTML
    String optionB = html.substring(start + 5, end);

    // Xóa khoảng trắng và ký tự "&nbsp;" cuối chuỗi
    optionB = optionB.trim().replaceAll("&nbsp;", "");

    return optionB;
  }

  static String getC(String html) {
    // Tìm vị trí của ký tự "<h2>A"
    int start = html.indexOf("<h2>C");

    // Nếu không tìm thấy ký tự "<h2>A", trả về chuỗi rỗng
    if (start == -1) return "";

    // Tìm vị trí của ký tự "</h2>"
    int end = html.indexOf("</h2>", start);

    // Nếu không tìm thấy ký tự "</h2>", trả về chuỗi rỗng
    if (end == -1) return "";

    // Trích xuất đoạn văn A từ chuỗi HTML
    String optionA = html.substring(start + 5, end);

    // Xóa khoảng trắng và ký tự "&nbsp;" cuối chuỗi
    optionA = optionA.trim().replaceAll("&nbsp;", "");

    return optionA;
  }

  static bool checkNullAndFalse(bool? check) {
    if (check == null) {
      return false;
    } else if (check == false) {
      return false;
    }

    return true;
  }

  //Pick Time
  static Future<DateTime> pickTime(BuildContext context, DateTime dateTimeText) async {
    DateTime? pickedTime = await picker.DatePicker.showTimePicker(context,
        locale: picker.LocaleType.vi,
        showSecondsColumn: false,
        theme: const picker.DatePickerTheme(
            cancelStyle: TextStyle(fontSize: AppDimens.textSizeMedium, fontWeight: FontWeight.bold),
            doneStyle: TextStyle(fontSize: AppDimens.textSizeMedium, fontWeight: FontWeight.bold)));
    if (pickedTime != null) {
      return pickedTime;
    } else {
      return dateTimeText;
    }
  }

  static void log(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static bool isNullEmpty(Object o) => "" == o;

  //Pick Date
  static Future<DateTime> pickDate(BuildContext context, DateTime dateTimeText) async {
    DateTime? pickedTime = await picker.DatePicker.showDatePicker(context,
        locale: picker.LocaleType.vi,
        theme: const picker.DatePickerTheme(
            cancelStyle: TextStyle(fontSize: AppDimens.textSizeMedium, fontWeight: FontWeight.bold),
            doneStyle: TextStyle(fontSize: AppDimens.textSizeMedium, fontWeight: FontWeight.bold)));
    if (pickedTime != null) {
      return pickedTime;
    } else {
      return dateTimeText;
    }
  }

  static void customBottomSheet(
      {required BuildContext context, //bắt buộc phải có để show
      required Widget body, //phần thân
      Color? bodyColors, //màu của bottomsheeet
      String? title, //phần tittle k truyền vào sẽ k có nút close và devider
      bool? showButtonClose, // có show nút close k
      Color? backgroundColors, // màu đằng sau của mà hình khi có bottom sheeet
      bool? closeWhenTouch, //khi bấm ra màn hình sẽ close bottom sheet
      bool? isScroll, // bottom sheet có thể scroll hay k
      bool isPadding = true,
      Color? colorDivider,
      double? height}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: isScroll ?? true,
        isDismissible: closeWhenTouch ?? false,
        barrierColor: backgroundColors ?? AppColors.textBlack.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: height ?? MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: bodyColors ?? Colors.white,
                ),
                child: Column(
                  children: [
                    (title != null && title != "")
                        ? Container(
                            //   margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
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
                                        style: const TextStyle(
                                          color: AppColors.textBlack,
                                          fontFamily: AppFonts.sfProBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: (showButtonClose != null && showButtonClose)
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
                            color: colorDivider ?? AppColors.backgroundLight,
                            width: MediaQuery.of(context).size.width,
                          )
                        : const SizedBox.shrink(),
                    Expanded(
                        child: Padding(
                      padding: isPadding
                          ? const EdgeInsets.only(
                              left: 24,
                              right: 24,
                            )
                          : EdgeInsets.zero,
                      child: Center(child: body),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  //showDialog Error
  static void showDialogError(
    BuildContext context,
    String errText, {
    String? title,
    Function()? onPressButton,
    String? image,
    TextAlign? descriptionTextAlign,
    String? textButton,
    bool? dialogDismiss,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NormalDialog(
            image: image,
            onPress1stButton: onPressButton,
            title: title ?? "Lỗi",
            description: errText,
            descriptionTextAlign: descriptionTextAlign,
            text1stButton: textButton ?? "Vào đăng nhập",
            dialogDismiss: dialogDismiss,
          );
        });
  }

  // dialog notìication
  static void showDialogNoti(BuildContext context, String errText,
      {String? title, bool? hidebtn, TextAlign? descriptionTextAlign, bool? dialogDismiss,  bool? isNoti}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NormalDialog(
            isNoti: isNoti,
            hideBtnBottom: hidebtn,
            title: title ?? "Ai đó vừa đăng bài viết",
            description: errText,
            descriptionTextAlign: descriptionTextAlign,
            dialogDismiss: dialogDismiss,
          );
        });
  }

  //show dialog
  static void showDialogAlert(
    BuildContext context, {
    String? title,
    String? description,
    String? text1stButton,
    String? text2ndButton,
    final Function()? onPress1stButton,
    final Function()? onPress2ndButton,
    bool? isTwoButton,
    Widget? widgetDescription,
    String? image,
    Widget? customImage,
    bool? showBtnClose,
    bool? hideBtnBottom,
    bool? showBtnCloseCircle,
    bool? leftTitle,
    bool? titleBold,
    bool? dialogDismiss,
    bool? canScroll,
    Color? titleColor,
    bool noTitle = false,
    Color? colorDescription,
    bool? isButton1White,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NormalDialog(
            canScroll: canScroll,
            dialogDismiss: dialogDismiss,
            showBtnCloseCircle: showBtnCloseCircle,
            titleBold: titleBold,
            title: title,
            description: description,
            text1stButton: text1stButton,
            text2ndButton: text2ndButton,
            onPress1stButton: onPress1stButton ??
                () {
                  Navigator.of(context).pop();
                },
            onPress2ndButton: onPress2ndButton ??
                () {
                  Navigator.of(context).pop();
                },
            isTwoButton: isTwoButton,
            widgetDescription: widgetDescription,
            image: image,
            showBtnClose: showBtnClose,
            hideBtnBottom: hideBtnBottom,
            leftTitle: leftTitle,
            customImage: customImage,
            titleColor: titleColor,
            noTitle: noTitle,
            colorDescription: colorDescription,
            isButton1White: isButton1White ?? false,
          );
        });
  }

  // static Widget checkStringContains(String word, String text) {
  //   if (text.contains(word)) {
  //     int startIndex = text.indexOf(word);
  //     int endIndex = startIndex + word.length;
  //     return Text.rich(
  //       TextSpan(
  //         children: [
  //           TextSpan(
  //               text: text.substring(0, startIndex),
  //               style: const TextStyle(
  //                   color: AppColors.textTitleBlueColor,
  //                   fontFamily: AppFonts.sfProMedium,
  //                   fontSize: AppDimens.textSizeSmall)),
  //           TextSpan(
  //             text: text.substring(startIndex, endIndex),
  //             style: const TextStyle(
  //                 color: AppColors.textTitleBrown, fontFamily: AppFonts.sfProMedium, fontSize: AppDimens.textSizeSmall),
  //           ),
  //           TextSpan(
  //               text: text.substring(endIndex),
  //               style: const TextStyle(
  //                   color: AppColors.textTitleBlueColor,
  //                   fontFamily: AppFonts.sfProMedium,
  //                   fontSize: AppDimens.textSizeSmall)),
  //           const TextSpan(
  //               text: '。',
  //               style: TextStyle(
  //                   color: AppColors.titleTextColor,
  //                   fontFamily: AppFonts.sfProMedium,
  //                   fontSize: AppDimens.textSizeSmall)),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return Text(
  //       text,
  //       style: const TextStyle(
  //           color: AppColors.textTitleBlueColor, fontFamily: AppFonts.sfProMedium, fontSize: AppDimens.textSizeSmall),
  //     );
  //   }
  // }

  // static String removeDots(String text) {
  //   if (text.endsWith('。')) {
  //     return text.substring(0, text.length - 1);
  //   } else {
  //     return text;
  //   }
  // }

  // static List<String> convertStringToList(String inputString) {
  //   List<String> wordList = inputString.split(';');
  //   List<String> trimmedList = [];
  //
  //   for (String word in wordList) {
  //     String trimmedWord = word.trim();
  //     if (trimmedWord.isNotEmpty) {
  //       trimmedList.add(trimmedWord);
  //     }
  //   }
  //   return trimmedList;
  // }

  // static String sentenceBetweenWords(String inputString, String selectedWord) {
  //   RegExp sentenceSeparator = RegExp(r'[\.\、\;\(\)]');
  //
  //   List<String> sentences = inputString.split(sentenceSeparator);
  //   List<String> selectedSentences = [];
  //
  //   for (String sentence in sentences) {
  //     if (sentence.toLowerCase().contains(selectedWord.toLowerCase())) {
  //       selectedSentences.add(sentence.trim()); // Thêm câu vào danh sách
  //     }
  //   }
  //   String value = selectedSentences[selectedSentences.length -1];
  //   return value;
  // }

  static List<String> listChineseCharacters(String input) {
    Set<String> word = {};
    const int start = 0x4E00;
    const int end = 0x9FFF;
    for (int i = 0; i < input.length; i++) {
      int codeUnit = input.codeUnitAt(i);
      // Kiểm tra xem ký tự có thuộc chữ tiếng Trung hay không
      if (codeUnit >= start && codeUnit <= end) {
        word.add(input[i]);
      }
    }
    return word.toList();
  }

  //pick image

  static Future<List<XFile>?> pickImages() async {
    final picker = ImagePicker();

    // Hiển thị hộp thoại chọn ảnh
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFiles.isNotEmpty) {
      // Trả về danh sách File của các ảnh đã chọn
      return pickedFiles;
    } else {
      // Người dùng không chọn ảnh
      return null;
    }
  }

  static List<String> convertStringToList(String input) {
    // Loại bỏ các ký tự "[", "]", và các dấu \ trong chuỗi đầu vào
    String cleanedString = input.replaceAll('[', '').replaceAll(']', '').replaceAll('\\', '');

    // Chuyển đổi chuỗi thành danh sách List<String> bằng cách parse chuỗi JSON
    List<dynamic> jsonList = json.decode('[$cleanedString]');
    List<String> resultList = List<String>.from(jsonList);

    return resultList;
  }

  static List<String> extractStrokes(String jsonString) {
    try {
      Map<String, dynamic> jsonData = json.decode(jsonString);
      if (jsonData.containsKey('strokes')) {
        List<dynamic> strokesList = jsonData['strokes'];
        List<String> strokes = List<String>.from(strokesList);
        return strokes;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // format ngày tháng năm API trả về
  static formatTimeFromAPI(String? dateString, {bool? isDate}) {
    if (dateString == null) {
      return dateString;
    } else {
      if (isDate == null) {
        DateTime dateTime = DateTime.parse(dateString);
        String formattedDate = DateFormat('dd/MM/yyyy  hh:mm').format(dateTime);
        return formattedDate;
      }
      if (isDate == true) {
        DateTime dateTime = DateTime.parse(dateString);
        String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
        return formattedDate;
      }
      if (isDate == false) {
        DateTime dateTime = DateTime.parse(dateString);
        String formattedDate = DateFormat('hh:mm').format(dateTime);
        return formattedDate;
      }
    }
  }

  // Translate Text
  // static Future<String> translateText(String value, {String to = 'zh-cn', String from = 'vi'}) async {
  //   final translator = GoogleTranslator();
  //   String translatedTextValue = '';
  //   try {
  //     final translation = await translator.translate(value, from: from, to: to);
  //     translatedTextValue = translation.toString();
  //   } catch (e) {
  //     translatedTextValue = '';
  //   }
  //   return translatedTextValue;
  // }

  static List<String> splitChineseSentences(String input) {
    List<String> sentences = [];
    String cleanedInput = input.trim().replaceAll(RegExp('^[,;，]+|[,;，]+\$'), '');
    sentences = cleanedInput.split(RegExp('[,;，]'));
    sentences = sentences.map((sentence) => sentence.trim()).toList();
    return sentences;
  }

  // static final player = AudioPlayer();

  // static Future speakUrl({String? url, Function? onCompletion}) async {
  //   if (url != null && url != "") {
  //     await player.play(UrlSource(url));
  //     player.onPlayerComplete.listen((event) {
  //       onCompletion?.call();
  //     });
  //   }
  // }

  static String? concatenateStrings(List<String>? strings) {
    String result = '';
    if (strings != null && strings.isNotEmpty) {
      for (String str in strings) {
        result += " $str";
      }
      return result;
    } else {
      return null;
    }
  }

  // static final translator = GoogleTranslator();

  // static Future<String> translateChineseString(String value) async {
  //   String translatedTextValue = '';
  //   try {
  //     final translation = await translator.translate(value, from: 'zh-cn', to: 'vi');
  //     translatedTextValue = translation.toString();
  //   } catch (e) {
  //     translatedTextValue = '';
  //   }
  //   return translatedTextValue;
  // }

  //validate-phone
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

  // first upcase
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static String? formatNumberInteract(int? number) {
    if (number != null) {
      if (number >= 1000000000) {
        return '${(number / 1000000000).toStringAsFixed(1)}B';
      } else if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      } else if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}K';
      } else {
        return number.toString();
      }
    } else {
      return null;
    }
  }

  static String formatTypeWord(String type) {
    switch (type) {
      case "v.":
        return "Động từ";
      case "ph.":
        return "Động từ";
      case "n.":
        return "Danh từ";
      case "adj.":
        return "Tính từ";
      case "adv.":
        return "Trạng từ";
      case "n./v.":
        return "Danh từ / Động từ";
      case "num.":
        return "Số từ";
    }
    return type;
  }


  static getRouteNavigate(String? name) {
    switch (name) {
      case 'Từ điển':
        return '/dictionaryMainScreen';
      case 'Chinh phục HSK 1-4':
        return '/conquerHSKMainScreen';
      case 'Truyện tranh chinh phục':
        return '/comicsPage';
      case 'Sơ đồ tư duy':
        return "/mindmapScreen";
      case 'Thi thử':
        return "/categoryExamScreen";
      case 'Từ vựng':
        return "/vocabularyScreen";
      case 'Luyện đọc':
        return '/mainPraticeReadingScreen';
      case 'Lớp học Online':
        return '/coursePage';
      case 'Tư vấn việc làm':
        return '/jobCounselingPage';
      case 'Tư vấn du học':
        return '/studyAbroadPage';
      case 'Tin tức':
        return '/WebviewPageBlog';
      case 'Về chúng tôi H&C':
        return "/webviewPage";
    }
  }

  static getUrlWebView(String? url) {
    switch (url) {
      case 'Lớp học Online':
        return 'https://tiengtrungtoancauhc.vn/category/khoa-hoc/';
      case 'Tin tức':
        return 'https://tiengtrungtoancauhc.vn/category/blog/';
      case 'Về chúng tôi H&C':
        return "https://tiengtrungtoancauhc.vn/";
    }
  }

  // static showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Stack(
  //         children: [
  //           Container(
  //             height: MediaQuery.of(context).size.height * 0.6,
  //             width: MediaQuery.of(context).size.width,
  //             padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
  //             margin: const EdgeInsets.only(bottom: 80),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Container(
  //                     width: 33,
  //                     height: 4,
  //                     decoration: BoxDecoration(
  //                         color: const Color(0xff171A1D).withOpacity(0.15), borderRadius: BorderRadius.circular(2)),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   const Text(
  //                     'Thẻ trả lời đề thi',
  //                     style: TextStyle(color: Color(0xff000000), fontSize: 17, fontFamily: AppFonts.sfProRegular),
  //                   ),
  //                   Container(
  //                     padding: const EdgeInsets.symmetric(vertical: 24),
  //                     child: Wrap(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               AppImages.icHeadPhone,
  //                               height: 24,
  //                               width: 24,
  //                             ),
  //                             const SizedBox(
  //                               width: 12,
  //                             ),
  //                             const Text(
  //                               "nghe",
  //                               style: TextStyle(
  //                                   color: AppColors.textBlack, fontSize: 16, fontFamily: AppFonts.sfProRegular),
  //                             )
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 16,
  //                         ),
  //                         RowQuestion(
  //                           text: "第一部分",
  //                           number1: "1",
  //                           number2: "2",
  //                           number3: "3",
  //                           number4: "4",
  //                           number5: "5",
  //                           isDone1: true,
  //                           isDone2: true,
  //                           isDone3: true,
  //                           isDone4: true,
  //                           isDone5: true,
  //                         ),
  //                         const SizedBox(
  //                           height: 16,
  //                         ),
  //                         RowQuestion(
  //                           text: "第二部分",
  //                           number1: "6",
  //                           number2: "7",
  //                           number3: "8",
  //                           number4: "9",
  //                           number5: "10",
  //                         ),
  //                         const SizedBox(
  //                           height: 16,
  //                         ),
  //                         RowQuestion(
  //                           text: "第一部分",
  //                           number1: "11",
  //                           number2: "12",
  //                           number3: "13",
  //                           number4: "14",
  //                           number5: "15",
  //                         ),
  //                         const SizedBox(
  //                           height: 16,
  //                         ),
  //                         RowQuestion(
  //                           text: "第一部分",
  //                           number1: "16",
  //                           number2: "17",
  //                           number3: "18",
  //                           number4: "19",
  //                           number5: "20",
  //                         ),
  //                         Container(
  //                           margin: const EdgeInsets.only(top: 16),
  //                           child: Row(
  //                             children: [
  //                               Image.asset(
  //                                 AppImages.icBookOpen,
  //                                 height: 24,
  //                                 width: 24,
  //                               ),
  //                               const SizedBox(
  //                                 width: 12,
  //                               ),
  //                               const Text(
  //                                 "Đọc",
  //                                 style: TextStyle(
  //                                     color: AppColors.textBlack, fontSize: 16, fontFamily: AppFonts.sfProRegular),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 16,
  //                         ),
  //                         RowQuestion(
  //                           text: "第二部分",
  //                           number1: "1",
  //                           number2: "2",
  //                           number3: "3",
  //                           number4: "4",
  //                           number5: "5",
  //                         ),
  //                         RowQuestion(
  //                           text: "第二部分",
  //                           number1: "6",
  //                           number2: "7",
  //                           number3: "8",
  //                           number4: "9",
  //                           number5: "10",
  //                         ),
  //                         RowQuestion(
  //                           text: "第二部分",
  //                           number1: "11",
  //                           number2: "12",
  //                           number3: "13",
  //                           number4: "14",
  //                           number5: "15",
  //                         ),
  //                         RowQuestion(
  //                           text: "第二部分",
  //                           number1: "16",
  //                           number2: "17",
  //                           number3: "18",
  //                           number4: "19",
  //                           number5: "20",
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 15,
  //             left: MediaQuery.of(context).size.width * 0.05,
  //             right: MediaQuery.of(context).size.width * 0.05,
  //             child: InkWell(
  //               child: Align(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                   width: MediaQuery.of(context).size.width * 0.9,
  //                   height: 48,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(16),
  //                       color: AppColors.primary,
  //                       boxShadow: const [
  //                         BoxShadow(
  //                           color: Color(0xff1489F1),
  //                           offset: Offset(0, 4),
  //                         )
  //                       ]),
  //                   child: const Text(
  //                     "Nộp",
  //                     style: TextStyle(color: AppColors.white, fontSize: 18, fontFamily: AppFonts.sfProMedium),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  // static Future<int?> getAudioDuration(String url) async {
  //   AudioPlayer audioPlayer = AudioPlayer();
  //   Duration? audioDuration;
  //   await audioPlayer.setSourceUrl(url);
  //   audioDuration = await audioPlayer.getDuration();
  //   audioPlayer.dispose();
  //   return audioDuration?.inSeconds;
  // }

  //time-ago
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes phút';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours giờ';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ngày';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  static String convertDateTimeFormat(String inputDateTime) {
    try {
      DateTime parsedDateTime = DateTime.parse(inputDateTime);
      return DateFormat('dd-MM-yyyy').format(parsedDateTime);
    } catch (error) {
      return "Invalid Date";
    }
  }

  //checkChinese
  static bool isChineseString(String input) {
    // Kiểm tra xem chuỗi có chứa ký tự tiếng Trung hay không
    bool hasChineseCharacters = input.runes.any((rune) =>
            (rune >= 0x4E00 && rune <= 0x9FFF) || // Tiếng Trung (CJK Unified Ideographs)
            (rune >= 0x3400 && rune <= 0x4DBF) || // Tiếng Trung phổ thông mở rộng A
            (rune >= 0x20000 && rune <= 0x2A6DF) || // Tiếng Trung phổ thông mở rộng B
            (rune >= 0x2A700 && rune <= 0x2B73F) || // Tiếng Trung phổ thông mở rộng C
            (rune >= 0x2B740 && rune <= 0x2B81F) || // Tiếng Trung phổ thông mở rộng D
            (rune >= 0x2B820 && rune <= 0x2CEAF) || // Tiếng Trung phổ thông mở rộng E
            (rune >= 0xF900 && rune <= 0xFAFF) || // Tiếng Trung phồn thể
            (rune >= 0x2F800 && rune <= 0x2FA1F) // Phông chữ CJK - Symbols and Punctuation
        );

    // Kiểm tra xem chuỗi có chứa ký tự tiếng Việt hay không
    bool hasVietnameseCharacters = input.runes.any((rune) =>
            (rune >= 0x00C0 && rune <= 0x1EF9) || // Tiếng Việt có dấu
            (rune == 0x0110 ||
                rune == 0x0111 ||
                rune == 0x1EB0 ||
                rune == 0x1EB1 ||
                rune == 0x1EB2 ||
                rune == 0x1EB3 ||
                rune == 0x1EB4 ||
                rune == 0x1EB5 ||
                rune == 0x1EB6 ||
                rune == 0x1EB7) // Tiếng Việt có dấu thanh
        );

    // Trả về true nếu chuỗi chứa ít nhất một ký tự tiếng Trung hoặc tiếng Việt
    return hasChineseCharacters;
  }

  static String extractTitle(String input) {
    String cleanedInput = input.replaceAll("{{", "").replaceAll("}}", "");
    List<String> parts = cleanedInput.split("|");

    if (parts.length == 2) {
      return parts[1]; // Trả về phần tử thứ hai là title
    } else {
      return "";
    }
  }

  static String extractSubtitle(String input) {
    String cleanedInput = input.replaceAll("{{", "").replaceAll("}}", "");
    List<String> parts = cleanedInput.split("|");
    if (parts.length == 1) {
      return parts[0];
    }
    if (parts.length == 2) {
      return parts[0]; // Trả về phần tử thứ nhất là subtitle
    } else {
      return "";
    }
  }

  static String extractImagePathA(String jsonString) {
    List<Map<String, dynamic>> imageList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    String imagePath = imageList[0]['image'];
    imagePath = imagePath.replaceAll('\\/', '/');
    return "https://data.hanzii.net$imagePath";
  }

  static String extractImagePathB(String jsonString) {
    List<Map<String, dynamic>> imageList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    String imagePath = imageList[1]['image'];
    imagePath = imagePath.replaceAll('\\/', '/');
    return "https://data.hanzii.net$imagePath";
  }

  static String extractImagePathC(String jsonString) {
    List<Map<String, dynamic>> imageList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    String imagePath = imageList[2]['image'];
    imagePath = imagePath.replaceAll('\\/', '/');
    return "https://data.hanzii.net$imagePath";
  }

  static String extractImagePathD(String jsonString) {
    List<Map<String, dynamic>> imageList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    String imagePath = imageList[3]['image'];
    imagePath = imagePath.replaceAll('\\/', '/');
    return "https://data.hanzii.net$imagePath";
  }

  static String extractImagePathE(String jsonString) {
    List<Map<String, dynamic>> imageList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    String imagePath = imageList[4]['image'];
    imagePath = imagePath.replaceAll('\\/', '/');
    return "https://data.hanzii.net$imagePath";
  }

  static String extractSubstring(String html, String target) {
    String result = extractTextFromHtml(html);
    int startIndex = result.indexOf(target);
    if (startIndex == -1) {
      return '';
    }
    int endIndex;
    if (target == 'E') {
      endIndex = result.length;
    } else {
      int nextIndex = result.indexOf(String.fromCharCode(target.codeUnitAt(0) + 1));
      if (nextIndex == -1) {
        return "";
      }
      endIndex = nextIndex;
    }
    return result.substring(startIndex, endIndex).replaceAll('$target.', '');
  }

  static String extractSubstring2(String html, String target) {
    String result = extractTextFromHtml(html);
    int startIndex = result.indexOf(target);
    if (startIndex == -1) {
      return '';
    }
    int endIndex;
    if (target == 'E') {
      endIndex = result.length;
    } else {
      int nextIndex = result.indexOf(String.fromCharCode(target.codeUnitAt(0) + 1));
      if (nextIndex == -1) {
        return "";
      }
      endIndex = nextIndex;
    }
    return result.substring(startIndex, endIndex);
  }

  static String getOptionA(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'A\.(.*?)(?=B|\sB|$)');
    return regex.stringMatch(parsedString.replaceAll(RegExp(r'\s+'), ''))?.trim() ?? '';
  }

  static String extractTextFromHtml(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    return parsedString.trim();
  }

  static String extractTextAtIndex(String input, int n) {
    String newInput = extractTextFromHtml(input);
    List<String> parts = newInput.split("？");
    if (n >= 0 && n < parts.length - 1) {
      return parts[n].trim();
    } else {
      return ""; // Trả về chuỗi rỗng nếu không tìm thấy hoặc n không hợp lệ.
    }
  }

  static String getOptionB(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'B\.(.*?)(?=C|\sC|$)');
    return regex.stringMatch(parsedString.replaceAll(RegExp(r'\s+'), ''))?.trim() ?? '';
  }

  static String getOptionC(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'C\.(.*?)(?=D|\sD|$)');
    return regex.stringMatch(parsedString.replaceAll(RegExp(r'\s+'), ''))?.trim() ?? '';
  }

  static String getOptionD(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'D\.(.*?)(?=E|\sE|$)');
    return regex.stringMatch(parsedString.replaceAll(RegExp(r'\s+'), ''))?.trim() ?? '';
  }

  static String getOptionE(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text.replaceAll(' ', '');
    RegExp regex = RegExp(r'E\.[^\s]+');
    return regex.stringMatch(parsedString.replaceAll(RegExp(r'\s+'), ''))?.trim() ?? '';
  }

  static String getOptionALeng(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'A\s+([^B]+)');
    return regex.firstMatch(parsedString)?.group(1)?.trim() ?? '';
  }

  static String getOptionBLeng(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'B\s+([^C]+)');
    return regex.firstMatch(parsedString)?.group(1)?.trim() ?? '';
  }

  static String getOptionCLeng(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'C\s+([^D]+)');
    return regex.firstMatch(parsedString)?.group(1)?.trim() ?? '';
  }

  static String getOptionDLeng(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'D\s+([^E]+)');
    return regex.firstMatch(parsedString)?.group(1)?.trim() ?? '';
  }

  static String getOptionELeng(String html) {
    var doc = parse(html);
    String parsedString = doc.documentElement!.text;
    RegExp regex = RegExp(r'E\s+([^]+)$');
    return regex.firstMatch(parsedString)?.group(1)?.trim() ?? '';
  }

  static double countNumberExamTrue(List<bool> list) {
    int count = 0;
    for (var i in list) {
      if (i == true) {
        count++;
      }
    }
    return count.ceilToDouble();
  }

  static int countNumberExamTrue2(List<bool> list) {
    int count = 0;
    for (var i in list) {
      if (i == true) {
        count++;
      }
    }
    return count;
  }

  static int countNumberListeningExamTrue(List<bool> list, int numberCount) {
    int count = 0;
    for (int i = 0; i < numberCount; i++) {
      if (list[i] == true) {
        count++;
      }
    }
    return count;
  }

  static String findMissingElement(List<String> inputList, String text) {
    // Tạo một danh sách chứa các phần tử 'A', 'B', 'C'
    List<String> requiredElements = ['A', 'B', 'C'];

    // Duyệt qua danh sách đầu vào và loại bỏ các phần tử đã xuất hiện
    for (var element in inputList) {
      if (requiredElements.contains(element)) {
        requiredElements.remove(element);
      }
    }
    // Trả về phần tử còn lại (nếu có)
    if (requiredElements.isNotEmpty) {
      return text;
    } else {
      return ''; // Trường hợp không còn phần tử nào
    }
  }

  static int findEmptyElementIndex(List<String> inputList) {
    for (int i = 0; i < inputList.length; i++) {
      if (inputList[i].isEmpty) {
        return i; // Trả về chỉ mục của phần tử rỗng đầu tiên
      }
    }
    return -1; // Trường hợp không tìm thấy phần tử rỗng
  }

  static int countNumberListeningExamTrueHSK2(List<bool> list) {
    int count = 0;
    for (int i = 0; i < 35; i++) {
      if (list[i] == true) {
        count++;
      }
    }
    return count;
  }

  static int countNumberListeningExamTrueHSK3(List<bool> list) {
    int count = 0;
    for (int i = 0; i < 40; i++) {
      if (list[i] == true) {
        count++;
      }
    }
    return count;
  }

  static int countNumberReadingExamTrueHSK3(List<bool> list) {
    int count = 0;
    for (int i = 35; i < 40; i++) {
      if (list[i] == true) {
        count++;
      }
    }
    return count;
  }

  static int countNumberReadingExamTrue(List<bool> list, int numberSCount, int numberECount) {
    int count = 0;
    for (int i = numberSCount; i < numberECount; i++) {
      if (list[i] == true) {
        count++;
      }
    }
    return count;
  }

  static int countNumberReadingExamTrueHSK2(List<bool> list) {
    int count = 0;
    for (int i = 35; i < 60; i++) {
      if (list[i] == true) {
        count++;
      }
    }
    return count;
  }

  static List<String> tachVanBan(String vanBan) {
    // Sử dụng biểu thức chính quy để tách văn bản thành danh sách các từ
    final regex = RegExp(r'\s+|[,;.!?\t]+');
    return vanBan.split(regex);
  }

  static double calculateAccuracy(String str1, String str2) {
    int minLength = str1.length < str2.length ? str1.length : str2.length;
    int matchingCount = 0;

    for (int i = 0; i < minLength; i++) {
      if (str1[i] == str2[i]) {
        matchingCount++;
      }
    }

    return matchingCount.toDouble() / str1.length;
  }

  static double round2Number(double myNumber) {
    return double.parse(myNumber.toStringAsFixed(2));
  }

  static double getPointHSK2(List<bool> answer) {
    double sum = 0;
    for (int i = 0; i <= 29; i++) {
      if (answer[i] == true) {
        sum += 3;
      }
    }
    for (int i = 30; i <= 34; i++) {
      if (answer[i] == true) {
        sum += 2;
      }
    }
    for (int i = 35; i <= 59; i++) {
      if (answer[i] == true) {
        sum += 4;
      }
    }
    return sum;
  }

  static double getPointHSK3(List<bool> answer) {
    double sum = 0;
    for (int i = 0; i <= 39; i++) {
      if (answer[i] == true) {
        sum += 2.5;
      }
    }
    for (int i = 40; i <= 59; i++) {
      if (answer[i] == true) {
        sum += 3.5;
      }
    }
    for (int i = 60; i <= 69; i++) {
      if (answer[i] == true) {
        sum += 3;
      }
    }
    for (int i = 70; i <= 74; i++) {
      if (answer[i] == true) {
        sum += 10;
      }
    }
    for (int i = 75; i <= 79; i++) {
      if (answer[i] == true) {
        sum += 10;
      }
    }
    return sum;
  }

  static double getPointHSK4(List<bool> answer) {
    double sum = 0;
    for (int i = 0; i <= 24; i++) {
      if (answer[i] == true) {
        sum += 2;
      }
    }
    for (int i = 25; i <= 44; i++) {
      if (answer[i] == true) {
        sum += 2.5;
      }
    }
    for (int i = 45; i <= 84; i++) {
      if (answer[i] == true) {
        sum += 2.5;
      }
    }
    for (int i = 85; i <= 94; i++) {
      if (answer[i] == true) {
        sum += 5;
      }
    }
    for (int i = 95; i <= 99; i++) {
      if (answer[i] == true) {
        sum += 10;
      }
    }
    return sum;
  }

  static String addPrefixToUrlImage(String input) {
    if (input.startsWith("/")) {
      return "https://data.hanzii.net/$input";
    } else {
      return "https://$input";
    }
  }

  static String removeTagsAndLineBreaks(String input) {
    return input.replaceAll(RegExp(r'<\/?p[^>]*>'), '').replaceAll('\n', '').replaceAll('\r', '');
  }

  static String removeLineBreaks(String input) {
    return input.replaceAll(RegExp(r'[\n\r]'), '');
  }

  static String formatDouble(double input) {
    double roundedNumber = double.parse((input + 0.005).toStringAsFixed(2));
    if (input == input.toInt().toDouble()) {
      return input.toInt().toString(); // Nếu có phần thập phân là 0, hiển thị như số nguyên
    } else {
      return roundedNumber.toString(); // Nếu có phần thập phân khác 0, hiển thị với một chữ số thập phân
    }
  }

  static String formatSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static int countResultsTrueJson(List<dynamic> jsonDataList) {
    int count = 0;

    for (var item in jsonDataList) {
      if (item['result'] == true) {
        count++;
      }
    }

    return count;
  }

  static bool isJsonString(String input) {
    try {
      jsonDecode(input);
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool areAllTrueListAnswered(List<bool> boolList, int startIndex, int endIndex) {
    for (int i = startIndex; i <= endIndex; i++) {
      if (!boolList[i]) {
        return false;
      }
    }
    return true;
  }

  static String processHtmlContent(String content, int questionNumber) {
    return content.replaceAllMapped(RegExp(r'{{CAU_HOI}}'), (match) {
      return '[${questionNumber++}]';
    });
  }

  static bool areAllIntListAnswered(List<int> intList, int startIndex, int endIndex) {
    for (int i = startIndex; i <= endIndex; i++) {
      if (intList[i] == 0) {
        return false;
      }
    }
    return true;
  }

  static double getHeightOfItem(int index, List<GlobalKey> itemKeys) {
    final RenderBox? renderBox = itemKeys[index].currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0.0;
  }

  // static double percentCompleteExam(List<Histories>? history, int totals) {
  //   int max = history![0].score!.abs();
  //   for (int i = 0; i < history.length; i++) {
  //     if (history[i].score! > max) {
  //       max = history[i].score!;
  //     }
  //   }
  //   return max * 100 / totals;
  // }

  // static Future<String?> convertAudioToText(String filePath) async {
  //   final config = speech.RecognitionConfig(
  //     encoding: speech.AudioEncoding.LINEAR16,
  //     sampleRateHertz: 16000,
  //     languageCode: 'zh-CN', // Ngôn ngữ của âm thanh
  //   );
  //
  //   final recognizer = speech.SpeechToText(config);
  //
  //   final audioFile = File([], filePath);
  //   final audioFileBytes = await audioFile.readAsBytes();
  //
  //   try {
  //     final results = await recognizer.recognize(
  //       audioFileBytes,
  //       onProgress: (text) => print('Đã nhận dạng: $text'),
  //     );
  //
  //     if (results.isNotEmpty) {
  //       return results.first.recognizedWords;
  //     }
  //   } catch (e) {
  //     print('Lỗi khi nhận dạng giọng nói: $e');
  //   } finally {
  //     recognizer.close();
  //   }
  //   return null;
  // }

  static launchMessenger() async {
    String facebookId = "100083557892628";
    String url() {
      if (IO.Platform.isAndroid) {
        String uri = 'fb-messenger://user/$facebookId';
        return uri;
      } else if (IO.Platform.isIOS) {
        // iOS
        String uri = 'https://m.me/$facebookId';
        return uri;
      } else {
        return 'error';
      }
    }

    if (await canLaunchUrl(Uri.parse(url()))) {
      await launchUrl(Uri.parse(url()));
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  static launchZalo() async {
    String zaloId = "0986314008";
    String url() {
      if (IO.Platform.isAndroid) {
        String uri = 'https://chat.zalo.me/$zaloId';
        return uri;
      } else if (IO.Platform.isIOS) {
        // iOS
        String uri = 'https://chat.zalo.me/$zaloId';
        return uri;
      } else {
        return 'error';
      }
    }

    if (await canLaunchUrl(Uri.parse(url()))) {
      await launchUrl(Uri.parse(url()));
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  static void showCustomDialog(
      BuildContext context, final Function() ontap, String? image, String? pinyin, String? word, String? mean) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogMindMap(
          ontap: ontap,
          image: image,
          pinyin: pinyin,
          word: word,
          mean: mean,
        );
      },
    );
  }

  static bool isSublistPresent(List<List<int>> listOfLists, int row, int column) {
    bool isCheck = false;
    for (var e in listOfLists) {
      if (row == e.first && column == e.last) {
        isCheck = true;
        break;
      }
    }
    return isCheck;
  }

  static checkListListStringNotNull(List<List<String>> listOfLists) {
    bool isCheck = true;

    for (var list in listOfLists) {
      if (list.contains("...") || list.contains("....")) {
        isCheck = false;
        break; // Nếu có chuỗi rỗng, ngưng kiểm tra ngay lập tức
      }
    }

    return isCheck;
  }

  static void sortByIndices(List<List<int>> list) {
    // Sắp xếp theo chỉ số đầu tiên từ bé đến lớn
    list.sort((a, b) => a[0].compareTo(b[0]));

    // Nếu có các chỉ số đầu bằng nhau, sắp xếp chỉ số thứ hai từ bé đến lớn
    list.sort((a, b) {
      if (a[0] == b[0]) {
        return a[1].compareTo(b[1]);
      }
      return 0;
    });
  }

  static int findPosition(List<List<int>> list, List<int> target) {
    for (int i = 0; i < list.length; i++) {
      if (target.first == list[i].first && target.last == list[i].last) {
        return i;
      }
    }
    return -1; // Trả về -1 nếu không tìm thấy
  }

  // static String getVideoID(String url) {
  //   return YoutubePlayer.convertUrlToId(url) ?? "";
  // }

  static int parseDuration(String durationString) {
    List<String> parts = durationString.split(':');

    // Phân tích giờ, phút và giây
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    double seconds = double.parse(parts[2]);

    // Tổng số giây, chuyển đổi về int
    return (hours * 3600 + minutes * 60 + seconds).toInt();
  }

  static List<List<int>> removeDuplicates(List<List<int>> inputList) {
    List<List<int>> result = [];

    for (var element in inputList) {
      if (!result.contains(element)) {
        result.add(element);
      }
    }

    return result;
  }

  static bool checkAllNotNull(List<TextEditingController> listController) {
    bool check = true;
    for (var e in listController) {
      if (e.text == "") {
        check = false;
        break;
      }
    }
    return check;
  }

  static scrollToItem(int index, List<int> indices, ScrollController controller, List<GlobalKey> itemKeys) {
    if (index >= 0 && index < indices.length) {
      int targetIndex = indices[index];
      int totalHeight = List.generate(targetIndex, (index) => AppFunction.getHeightOfItem(index, itemKeys))
          .fold<int>(0, (previous, current) => (previous + current).toInt());

      controller.animateTo(
        totalHeight.toDouble(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
