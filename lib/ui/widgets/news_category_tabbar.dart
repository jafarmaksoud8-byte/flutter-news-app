import 'package:flutter/material.dart';
import 'package:project_2/core/app_color.dart';

class NewsCategoryTabbar extends StatelessWidget {
  final List<Widget> tabs;
  final Function(int)? onTap;
  const NewsCategoryTabbar({super.key, required this.tabs, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.kPrimaryColor1,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        unselectedLabelColor: AppColor.kPrimaryColor3,
        indicatorColor: AppColor.kPrimaryColor4,
        labelColor: AppColor.kPrimaryColor4,
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        tabs: tabs,
        onTap: onTap,
      ),
    );
  }
}
