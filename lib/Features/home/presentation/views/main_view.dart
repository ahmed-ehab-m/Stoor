import 'package:bookly_app/Features/gemini/presentation/views/gemini_view.dart';
import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/home_view.dart';
import 'package:bookly_app/Features/settings/presentation/views/settings_view.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _currentIndex = 0;
  List<Widget> screens = [
    // Add your screen widgets here
    HomeView(),
    HomeView(),
    GeminiView(),
    SettingsView()
    // LikesView(),
    // SearchView(),
    // SettingsView(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? iconColor = BlocProvider.of<ChangeThemeCubit>(context).iconColor;
    Color? backgroundColor =
        BlocProvider.of<ChangeThemeCubit>(context).backgroundColor;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent, // شفاف عشان ياخد لون الـ Container
          elevation: 0, // إزالة الـ elevation الافتراضي
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  HugeIcons.strokeRoundedHome07,
                  color: _currentIndex == 0 ? iconColor : Colors.grey,
                  size: 30,
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.bookmark,
                  color: _currentIndex == 1 ? Colors.amber : Colors.grey,
                ),
                onPressed: () => _onItemTapped(1),
              ),
              IconButton(
                // icon: Image.asset(
                //   'assets/images/google-gemini-icon.png',
                //   scale: 20,
                // ),

                icon: Icon(
                  HugeIcons.strokeRoundedGoogleGemini,
                  color: _currentIndex == 2
                      ? const Color.fromARGB(255, 39, 1, 255)
                      : Colors.grey,
                  size: 35,
                ),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.gear,
                  color: _currentIndex == 3 ? kPrimaryColor : Colors.grey,
                ),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
