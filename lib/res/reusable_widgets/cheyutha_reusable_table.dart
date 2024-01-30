import 'package:flutter/material.dart';

class TableCheyuthaColumnReusableNew extends StatelessWidget {
  const TableCheyuthaColumnReusableNew({
    super.key,
    this.serialNumber,
    this.entredField1,
    this.entredField2,
    this.entredField3,
    this.entredField4,
    this.removeicons,
    this.cardcolor,
    this.textcolor,
    this.dividercolor,
    this.height,
    this.verticaldividercolor,
    this.ontap,
    this.borderradius,
  });
  final String? serialNumber;
  final String? entredField1;
  final String? entredField2;
  final String? entredField3;
  final String? entredField4;
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  serialNumber.toString(),
                  style: TextStyle(
                      color: textcolor ?? Color.fromARGB(255, 73, 77, 79),
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 1,
              color: verticaldividercolor ?? Colors.grey,
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  entredField1.toString(),
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: textcolor ?? Color.fromARGB(255, 73, 77, 79),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: verticaldividercolor ?? Colors.grey,
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  entredField2.toString(),
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: textcolor ?? Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              width: 1,
              color: verticaldividercolor ?? Colors.grey,
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entredField3.toString(),
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: textcolor ?? Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: verticaldividercolor ?? Colors.grey,
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entredField4.toString(),
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: textcolor ?? Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: verticaldividercolor ?? Colors.grey,
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: ontap,
                child: Center(child: removeicons ?? SizedBox()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
