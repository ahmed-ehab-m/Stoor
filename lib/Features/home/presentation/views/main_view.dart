import 'package:bookly_app/Features/book%20marks/presentation/views/book_marks_view.dart';
import 'package:bookly_app/Features/gemini/presentation/views/gemini_view.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/home_view.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/views/settings_view.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _currentIndex = 0;
  late ScrollController scrollController;

  List<BookModel> books = [];
  List<Widget> screens = [
    HomeView(),
    BookMarksView(),
    GeminiView(),
    SettingsView()
  ];
  /////////////////////////
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  ///////////////////////////////////

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

////////////////////////////////////////
  Future<bool> _onPopInvoked() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false; //Prevent the back button press from closing the app
    }
    return true; //Allow the back button press to close the app
  }

////////////////////////////////
  @override
  Widget build(BuildContext context) {
    books = BlocProvider.of<FeaturedBooksCubit>(context).featuredBooks;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final shouldPop = await _onPopInvoked();
        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar:
            BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
          builder: (context, state) {
            Color? iconColor =
                BlocProvider.of<ChangeSettingsCubit>(context).iconColor;
            Color? backgroundColor =
                BlocProvider.of<ChangeSettingsCubit>(context).backgroundColor;
            // print('rebuild');
            return ScrollToHide(
              scrollController: scrollController,
              hideDirection: Axis.horizontal,
              // height: 50,
              child: Container(
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
                          HugeIcons.strokeRoundedBookmark02,
                          color:
                              _currentIndex == 1 ? Colors.amber : Colors.grey,
                          size: 30,
                        ),
                        onPressed: () => _onItemTapped(1),
                      ),
                      IconButton(
                        icon: _currentIndex == 2
                            ? CustomShaderMask(
                                child: Icon(
                                  HugeIcons.strokeRoundedRobot01,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )
                            : Icon(
                                HugeIcons.strokeRoundedRobot01,
                                color: Colors.grey,
                                size: 35,
                              ),
                        onPressed: () => _onItemTapped(2),
                      ),
                      IconButton(
                        icon: Icon(
                          HugeIcons.strokeRoundedSettings02,
                          size: 30,
                          color:
                              _currentIndex == 3 ? kPrimaryColor : Colors.grey,
                        ),
                        onPressed: () => _onItemTapped(3),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
