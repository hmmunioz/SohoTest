import 'package:sohotest/app/blocs/blocs.dart';
import 'package:sohotest/app/blocs/task/task_state.dart';
import 'package:sohotest/app/ui/navigation/navigation_cubit.dart';
import 'package:sohotest/app/ui/container/container_app_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sohotest/app/common_widgets/app_bar.dart';
import 'package:sohotest/app/common_widgets/bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohotest/app/constants/colors.dart';
import 'package:sohotest/app/constants/constants.dart';

class ContainerAppUI extends StatelessWidget {
  const ContainerAppUI({super.key, required this.interactor, required this.children});
  final Widget children;
  final ContainerAppInteractor interactor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navigationState) {
        return Container(
          color: Colors.black,
          child: SafeArea(
            top: false,
            bottom: false,
            child: ScreenUtilInit(
              designSize: ConstantsValues.designSize,
              builder: (context, child) {
                return Scaffold(
                  backgroundColor: ColorsTheme.deepSpace,
                  resizeToAvoidBottomInset: true,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(0.06.sh),
                    child: BlocBuilder<TaskBloc, TaskState>(
                      builder: (_, state) {
                        return const AppBarSoho(
                          isBack: false,
                        );
                      },
                    ),
                  ),
                  body: children,
                  extendBody: true,
                  drawerEnableOpenDragGesture: true,
                  bottomNavigationBar: BottomBarStarWars(logout: () {
                    interactor.logOut(context);
                  }),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
