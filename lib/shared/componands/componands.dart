import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/app_cubit.dart';

Widget mainButton({
  required BuildContext context,
  Color color = Colors.green,
  required String text,
  double width = double.infinity,
  double? height,
  EdgeInsetsGeometry? padding,
  void Function()? onClick,
}) =>
    Padding(
      padding: padding = EdgeInsets.zero,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: MaterialButton(
            onPressed: onClick,
            child: Text(
              text,
              style: GoogleFonts.actor(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            )),
      ),
    );

void NavigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void NavigateAndFinish(context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (
        route) => false);

Widget divideLine() =>
    Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1,
    );

Widget TFF({
  required String hintText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  bool isIcon = false,
  double? width,
  double? height,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20.0),
  void Function()? onTap,
  FormFieldValidator<String>? validator,
  Icon? icon,
}) =>
    Container(
      width: width = double.infinity,
      height: height = 50,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: isIcon ? icon : null,
        ),
        onTap: onTap,
        validator: validator,
        cursorColor: Colors.black,
      ),
    );

Widget taskItemBuilder({
  required BuildContext context,
  EdgeInsetsGeometry padding = const EdgeInsets.all(10.0),
  required bool itemCheckValue,
  required Color checkColor,
  void Function(bool?)? onChecked,
  required String itemTitle,
  TextStyle? style,
}) {
  return Padding(
    padding: padding,
    child: Row(
      children: [
        Checkbox(
          value: itemCheckValue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          onChanged: onChecked,
          checkColor: checkColor,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            itemTitle,
            style: style = GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/////////////////////////////////////////////////////

Widget buildTaskItem(Map model, context) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Container(
        color: Colors.white24,
        child: Row(
          children: [
            Checkbox(

              value: model['status'] == 'completed' ? true : false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              onChanged: (value) {
                if (value!) {
                  AppCubit.get(context).updateTaskStatus(
                      model['id'], 'completed');
                } else {
                  AppCubit.get(context).updateTaskStatus(model['id'], 'active');
                }
              },
              // checkColor: model['status'] == 'completed' ? Colors.red : Colors.green,
              activeColor: model['status'] == 'completed'
                  ? Colors.green
                  : Colors.red,


            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: GoogleFonts.aldrich(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['date']}',
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateTaskStatus(
                    model['id'], 'completed');
              },
              icon: const Icon(Icons.check_box),
              color: Colors.green,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        // AppCubit.get(context).deleteData(
        //   id: model['id'],
        // );
      },
    );

Widget taskBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) =>
          ListView.separated(
              itemBuilder: (context, index) =>
                  buildTaskItem(tasks[index], context),
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: tasks.length),
      fallback: (context) =>
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.menu,
                  size: 100.0,
                  color: Colors.grey,
                ),
                Text(
                  'No Tasks Yey, Please Insert Some Tasks',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
    );
