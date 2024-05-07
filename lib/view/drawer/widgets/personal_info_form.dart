import 'package:flutter/material.dart';

import 'package:sparkler/core/core.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

// 个人信息部件
class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              // 个人头像
              child: CircleAvatar(
                radius: 50, // 头像半径
                // backgroundImage:
                // NetworkImage('https://example.com/avatar.jpg'), // 从网络加载图片
                // 或者使用本地资源文件
                backgroundImage: AssetImage(AppIcons.pro),
              ),
            ),
            // EasyDateTimeLine日期选择器组件
            EasyDateTimeLine(
              // initialDate设置初始日期为当前日期
              initialDate: DateTime.now(),
              // onDateChange是日期改变时的回调函数，selectedDate是新选择的日期
              onDateChange: (selectedDate) {
                //`selectedDate` 是新选择的日期.
              },
              // headerProps设置日期选择器的头部属性
              headerProps: const EasyHeaderProps(
                // monthPickerType设置月份选择器的类型为切换器类型
                monthPickerType: MonthPickerType.switcher,
                // dateFormatter设置日期格式为完整的日期（日月年）
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              // dayProps设置日期选择器的日属性
              dayProps: const EasyDayProps(
                // dayStructure设置日的结构为字符串的日+数字的日
                dayStructure: DayStructure.dayStrDayNum,
                // activeDayStyle设置活动日的样式
                activeDayStyle: DayStyle(
                  // decoration设置装饰，包括边框半径和渐变色
                  decoration: BoxDecoration(
                    // borderRadius设置边框半径为8
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    // gradient设置渐变色，从上到下，颜色从渐变到
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 51, 255, 231),
                        Color.fromARGB(255, 218, 27, 164),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ],
    );
  }
}
