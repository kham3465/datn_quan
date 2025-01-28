
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/app.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';
import 'package:flutter_background_geolocation_example/view/screens/attendance/attendance_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/attendance/information_attendance.dart';
import 'package:flutter_background_geolocation_example/view/screens/home/home_page.dart';
import 'package:flutter_background_geolocation_example/view/screens/home/home_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/forgot_password_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/login_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/otp_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/reset_password_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/notification/create_notification.dart';
import 'package:flutter_background_geolocation_example/view/screens/notification/select_audience.dart';
import 'package:flutter_background_geolocation_example/view/screens/ship/ship_list.dart';
import 'package:flutter_background_geolocation_example/view/screens/time_table/session_information_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/time_table/time_table_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/change_pass_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/work_board_screen.dart';

class AppRoutes {
  //login
  static const String splashScreen = '/splash';
  static const String loginScreen = '/';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String otpScreen = '/otpScreen';
  static const String resetPassword = '/resetPassword';
  //home


  static const String timeTableScreen = '/timeTableScreen';
  static const String sessionInformationScreen = '/sessionInformationScreen';
  static const String attendanceScreen = '/attendanceScreen';

  static const String studyDiaryScreen = '/studyDiaryScreen';

  static const String informationAttendanceScreen =
      '/informationAttendanceScreen';
  //ranking_work
  static const String rankingDetailScreen = '/rankingDetailScreen';
  //home_work
  static const String homeWorkScreen = '/homeWorkScreen';
  static const String listHomeWorkScreen = '/listHomeWorkScreen';
  static const String detailHomeWork = '/detailHomeWork';
  static const String createHomeWork = '/createHomeWork';
  //report
  static const String reportHomeWorkScreen = '/reportHomeWorkScreen';
  static const String reportInformation = '/reportInformation';
  static const String detailReportInformation = '/detailReportInformation';

// study_diary
  static const String diaryScreen = "/diaryScreen";
  static const String sendDiaryScreen = "/sendDiaryScreen";
  static const String listDiaryScreen = "/listDiaryScreen";
  static const String detailPostScreen = "/detailPostScreen";
  static const String imagesScreen = "/imagesScreen";
//
  static const String createReportPeridodic = '/createReportPeridodic';
  static const String createReportSenior = '/createReportSenior';
  static const String sendReport = '/sendReport';
  //user profile;
  static const String workBoardScreen = '/workBoardScreen';

  // static const String sendReport = '/sendReport';

  // static const String sendReport = '/sendReport';

  // Study Plan
  static const String createManualStudyPlan = '/createManualStudyPlan';
  static const String studyPlan = '/studyPlan';
  static const String listStudyPlan = '/listStudyPlan';
  static const String createStudyPlan = '/createStudyPlan';

  static const String changePassScreen = '/changePassScreen';

  //notification
  static const String createNotification = '/createNotification';
  static const String selectAudienceScreen = '/selectAudienceScreen';
    static const String shipList = '/shiplist';
// schedule_teacher_admin
  static const String attendedTeacher = '/attendedTeacher';
  static const String createScheduleSuperAdmin = '/createScheduleSuperAdmin';
  static const String calendarSuperAdmin = '/calendarSuperAdmin';
    static const String homeLocation = '/homeLocation';
  static const String createScheduleTeacherBySuperAdmin =
      '/createScheduleTeacherBySuperAdmin';
        static const String home = '/home';
  static final routes = <String, WidgetBuilder>{
    //login
    loginScreen: (BuildContext context) => const LoginScreen(),
      homeLocation: (BuildContext context) => AdvancedApp(),
        shipList: (BuildContext context) => const ListShip(),
    forgotPasswordScreen: (BuildContext context) =>
        const ForgotPasswordScreen(),
    otpScreen: (BuildContext context) => const OtpScreen(),
    resetPassword: (BuildContext context) => const ResetPasswordScreen(),
   home: (BuildContext context) => const HomePage(),

    //home
    timeTableScreen: (BuildContext context) => const TimeTableScreen(),
    sessionInformationScreen: (BuildContext context) =>
        const SessionInformationScreen(),



    attendanceScreen: (BuildContext context) => const AttendanceScreen(),
    informationAttendanceScreen: (BuildContext context) =>
        const InformationAttendance(),
   
    workBoardScreen: (BuildContext context) => const WorkBoardScreen(),
    // Study Plan
   
    changePassScreen: (BuildContext context) => const ChangePassScreen(),
    createNotification: (BuildContext context) => const CreateNotification(),
    selectAudienceScreen: (BuildContext context) =>
        const SelectAudienceScreen(),
  
  
  };

}