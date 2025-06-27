import 'package:bookly_app/Features/book%20marks/presentation/views/book_marks_view.dart';
import 'package:bookly_app/Features/gemini/presentation/views/gemini_view.dart';
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

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _currentIndex = 0;
  late ScrollController scrollController;
  bool isVisible = true;
  bool _heightCalculated = false; // متغير جديد
  List<Widget> screens = [
    const HomeView(),
    const BookMarksView(),
    const GeminiView(),
    const SettingsView()
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final shouldPop = await _onPopInvoked();
        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        // extendBody: true,
        //NotificationListener => a widget listen to any notification that child send
        //ScrollNotification => to discover or listen  when the user scroll
        //ScrolLNotification => send a notification when the user scroll
        //ScrolLUpdateNotification => it send a notification when the user scroll
        body: NotificationListener<ScrollNotification>(
          ///onNotification => it's a callback that will be called when the user scroll
          onNotification: (scrollNotification) {
            if (_currentIndex == 2) return true;
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.axis == Axis.vertical) {
                // if the scroll delta(number of pixels) is greater than 5
                // to avoid much rendering
                if (scrollNotification.scrollDelta!.abs() > 20) {
                  //Scroll Down
                  //Scroll delta => the distance between the current position and the previous position
                  if (scrollNotification.scrollDelta! > 0) {
                    setState(() {
                      isVisible = false;
                    });
                  } else if (scrollNotification.scrollDelta! < 0) {
                    // Scroll up
                    setState(() {
                      isVisible = true;
                    });
                  }
                }
              }
            } else if (scrollNotification is ScrollEndNotification) {
              Future.delayed(const Duration(seconds: 3), () {
                if (mounted) {
                  setState(() {
                    isVisible = true;
                  });
                }
              });
            }
            return true;
          },
          child: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
          builder: (context, state) {
            Color? iconColor =
                BlocProvider.of<ChangeSettingsCubit>(context).iconColor;
            Color? backgroundColor =
                BlocProvider.of<ChangeSettingsCubit>(context).backgroundColor;
            //to calculate the height of the bottom app bar after widget build
            ////allow to calculate the height of the bottom app bar depending on the parent widget
            ///constraints => give me information about the parent widget like max width and height
            return LayoutBuilder(
              builder: (context, constraints) {
                //default value cuz Animatedcontainer wanna a value to make animation
                double barHeight = 0;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isVisible ? (barHeight == 0 ? null : barHeight) : 0,
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1 : 0,
                    duration: const Duration(
                        milliseconds: 300), // مدة أنيميشن الـ Opacity
                    child: IntrinsicHeight(
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 16, right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: BottomAppBar(
                          color: Colors
                              .transparent, // شفاف عشان ياخد لون الـ Container
                          elevation: 0, // إزالة الـ elevation الافتراضي
                          //builder make a subtree and give us BottomAppBar's context
                          child: Builder(builder: (context) {
                            //to calculate the height of the bottom app bar after widget build
                            // this function allow us to add a code to run after the widget build or paint
                            // to get the size of the BottomAppBar
                            if (!_heightCalculated) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                //renderBox => to get the size of the BottomAppBar after  paint on screen
                                final RenderBox? renderBox =
                                    context.findRenderObject() as RenderBox?;
                                if (renderBox != null) {
                                  setState(() {
                                    barHeight = renderBox
                                        .size.height; // تحديث الـ Height
                                    _heightCalculated =
                                        true; // علامة إن الـ Height اتحسب
                                  });
                                }
                              });
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    HugeIcons.strokeRoundedHome07,
                                    color: _currentIndex == 0
                                        ? iconColor
                                        : Colors.grey,
                                    size: 30,
                                  ),
                                  onPressed: () => _onItemTapped(0),
                                ),
                                IconButton(
                                  icon: Icon(
                                    HugeIcons.strokeRoundedBookmark02,
                                    color: _currentIndex == 1
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 30,
                                  ),
                                  onPressed: () => _onItemTapped(1),
                                ),
                                IconButton(
                                  icon: _currentIndex == 2
                                      ? const CustomShaderMask(
                                          child: Icon(
                                            HugeIcons.strokeRoundedRobot01,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        )
                                      : const Icon(
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
                                    color: _currentIndex == 3
                                        ? kSecondaryColor
                                        : Colors.grey,
                                  ),
                                  onPressed: () => _onItemTapped(3),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
