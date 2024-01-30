import 'package:flutter/material.dart';

class TableComponentReusable extends StatelessWidget {
  const TableComponentReusable(
      {super.key,
      this.serialNumber,
      this.entredField,
      this.removeicons,
      this.cardcolor,
      this.textcolor,
      this.dividercolor,
      this.height,
      this.verticaldividercolor,
      this.ontap,
      this.borderradius});
  final String? serialNumber;
  final String? entredField;
  final Widget? removeicons;
  final Color? cardcolor;
  final Color? textcolor;
  final Color? dividercolor;
  final double? height;
  final Color? verticaldividercolor;
  final Function()? ontap;
  final BorderRadiusGeometry? borderradius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderradius,
        color: cardcolor ?? Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      height: height ?? MediaQuery.of(context).size.height * 0.074,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                  child: Text(
                    serialNumber.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textcolor ?? Color.fromARGB(255, 73, 77, 79),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                entredField.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textcolor ?? Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          removeicons != null
              ? Container(
                  width: 1,
                  height: height ?? MediaQuery.of(context).size.height * 0.074,
                  color: verticaldividercolor ?? Colors.grey,
                )
              : Container(),
          removeicons != null
              ? Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: ontap,
                    child: Center(child: removeicons ?? Container()),
                    /* CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: 15,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ), */
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
