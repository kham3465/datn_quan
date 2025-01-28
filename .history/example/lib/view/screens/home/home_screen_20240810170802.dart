
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_geolocation_example/view/screens/base_screen/base_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/base_screen/base_screen_mixin.dart';
import 'package:flutter_background_geolocation_example/view/screens/home/home_page.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/persenal.dart';
import 'package:flutter_background_geolocation_example/view/utils/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_button_widget.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseState<HomeScreen> with BaseScreenMixin {
  @override
  Widget buildHeader() {
    // TODO: implement buildHeaderExtend
    return const SizedBox.shrink();
  }

  int currentIndex = 0;
  final screens = [HomePage(), HomePage(), UserProfileScreen()];

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Column(
                children: [
                  const Text(
                    "Thông báo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontFamily: AppFonts.sfProMedium,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Bạn có muốn thoát khỏi ứng dụng?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontFamily: AppFonts.sfProMedium,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: AppButton(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        title: "Không",
                        isYellow: true,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: AppButton(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        title: "Có",
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: SizedBox(
          height: 88,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xffFFFFFF),
          
            selectedLabelStyle: const TextStyle(
              color: AppColors.primary,
              fontSize: 10,
              // fontFamily: AppFonts.sfProMedium
            ),
            unselectedLabelStyle: const TextStyle(
              color: AppColors.textHint,
              fontSize: 10,
              // fontFamily: AppFonts.sfProMedium
            ),
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AppImages.iconHomeSelected,
                  width: 20,
                ),
                icon: Image.asset(
                  AppImages.iconHomeUnselect,
                  width: 20,
                ),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.iconCommunitySelected,
                    width: 20,
                  ),
                  icon: Image.asset(
                    AppImages.iconCommunityUnselect,
                    width: 20,
                  ),
                  label: "Cộng đồng"),
              BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.iconProfileSelected,
                    width: 20,
                  ),
                  icon: Image.asset(
                    AppImages.iconProfileUnselect,
                    width: 20,
                  ),
                  label: "Tôi"),
            ],
          ),
        ),
      ),
    );
  }
}
