import 'package:flutter/material.dart';

class TableFiveColumnReusableNew extends StatelessWidget {
  const TableFiveColumnReusableNew(
      {super.key,
      this.serialNumber,
      this.entredField1,
      this.entredField2,
      this.entredField3,
      this.removeicons,
      this.cardcolor,
      this.textcolor,
      this.dividercolor,
      this.height,
      this.verticaldividercolor,
      this.ontap,
      this.borderradius,
      this.entredField4,
      this.entredField5,
      this.ExtendFlag,
      this.iconFlag});
  final String? serialNumber;
  final String? entredField1;
  final String? entredField2;
  final String? entredField3;
  final String? entredField4;
  final String? entredField5;
  final Widget? removeicons;
  final Color? cardcolor;
  final Color? textcolor;
  final Color? dividercolor;
  final double? height;
  final Color? verticaldividercolor;
  final Function()? ontap;
  final BorderRadiusGeometry? borderradius;

  final bool? ExtendFlag;
  final bool? iconFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderradius,
        color: cardcolor ?? Colors.amber,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      height: height ?? MediaQuery.of(context).size.height * 0.074,
      //width: MediaQuery.of(context).size.width,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            //width: 50,
            width: MediaQuery.of(context).size.width * 0.15,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                serialNumber.toString(),
                style: TextStyle(
                    color: textcolor ?? Color.fromARGB(255, 73, 77, 79),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          SizedBox(
            //width: 150,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                entredField1.toString(),
                style: TextStyle(
                    color: textcolor ?? Color.fromARGB(255, 73, 77, 79),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          SizedBox(
            //width: 80,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: Text(
                entredField2.toString(),
                style: TextStyle(
                    color: textcolor ?? Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          SizedBox(
            //width: 80,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: Text(
                entredField3.toString(),
                style: TextStyle(
                    color: textcolor ?? Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          ExtendFlag == false
              ? SizedBox(
                  //width: 200,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Center(
                    child: Text(
                      entredField4.toString(),
                      style: TextStyle(
                          color: textcolor ?? Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : SizedBox(
                  //width: 200,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        child: Center(
                          child: Text(
                            entredField4.toString(),
                            style: TextStyle(
                                color: textcolor ?? Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: height ??
                            MediaQuery.of(context).size.height * 0.074,
                        color: verticaldividercolor ?? Colors.grey,
                      ),
                      SizedBox(
                        //width: 100,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Center(
                          child: Text(
                            entredField5.toString(),
                            style: TextStyle(
                                color: textcolor ?? Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          if (entredField5 != null)
            Container(
              width: 1,
              height: height ?? MediaQuery.of(context).size.height * 0.074,
              color: verticaldividercolor ?? Colors.grey,
            ),
          iconFlag == true
              ? SizedBox(
                  height: 30,
                  child: GestureDetector(
                    onTap: ontap,
                    child: removeicons ??
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Container(
                            height: height ??
                                MediaQuery.of(context).size.height * 0.1,
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
                        ),
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.115,
                )
        ],
      ),
    );
  }
}
