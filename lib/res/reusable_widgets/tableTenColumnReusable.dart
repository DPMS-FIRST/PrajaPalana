import 'package:flutter/material.dart';

class TableTenColumnReusableNew extends StatelessWidget {
  const TableTenColumnReusableNew(
      {super.key,
      this.serialNumber,
      this.passbook,
      this.landownerName,
      this.leaseDoc,
      this.removeicons,
      this.cardcolor,
      this.textcolor,
      this.dividercolor,
      this.height,
      this.verticaldividercolor,
      this.ontap,
      this.borderradius,
      this.periodOfLease,
      this.fromPeriod,
      this.ExtendFlag,
      this.iconFlag,
      this.toPeriod,
      this.surveyNo,
      this.subDivion,
      this.extent,
      this.acres,
      this.guntas,
      this.periodLeaseFlag});
  final String? serialNumber;
  final String? passbook;
  final String? landownerName;
  final String? leaseDoc;
  final String? periodOfLease;
  final String? fromPeriod;
  final String? toPeriod;
  final String? surveyNo;
  final String? subDivion;
  final String? extent;
  final String? acres;
  final String? guntas;
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
  final bool? periodLeaseFlag;

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
      child: Row(
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
                passbook.toString(),
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
                landownerName.toString(),
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
                leaseDoc.toString(),
                style: TextStyle(
                    color: textcolor ?? Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          /* Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          SizedBox(
            //width: 80,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: Text(
                entredField4.toString(),
                style: TextStyle(
                    color: textcolor ?? Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ), */
          Container(
            width: 1,
            height: height ?? MediaQuery.of(context).size.height * 0.074,
            color: verticaldividercolor ?? Colors.grey,
          ),
          periodLeaseFlag == false
              ? SizedBox(
                  //width: 200,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Center(
                    child: Text(
                      periodOfLease.toString(),
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
                            fromPeriod.toString(),
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
                            toPeriod.toString(),
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
          SizedBox(
            //width: 80,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: Text(
                surveyNo.toString(),
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
                subDivion.toString(),
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
                      extent.toString(),
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
                            acres.toString(),
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
                            guntas.toString(),
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
          //if (entredField5 != null)
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
