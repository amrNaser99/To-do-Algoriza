import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
