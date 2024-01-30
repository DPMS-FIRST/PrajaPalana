import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';

class MemberCard extends StatelessWidget {
  final FamilyListMdl member;
  // final void Function()? onRemovePressed;
  // final void Function()? onEditPressed;
  MemberCard({
    required this.member,
    // required this.onRemovePressed,
    // required this.onEditPressed,
  });
  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 10, bottom: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  String maskNumber(int number) {
    String numberString = number.toString();
    if (numberString.length > 4) {
      String maskedPart = 'X' * (numberString.length - 4);
      String lastTwoDigits = numberString.substring(numberString.length - 4);
      return maskedPart + lastTwoDigits;
    } else {
      return numberString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RowComponent("NAME".tr(), '${member.name}'),
            RowComponent(
                "RELATION WITH THE APPLICANT".tr(), '${member.relation}'),
            RowComponent("DATE OF BIRTH".tr(), '${member.datEOFBIRTH}'),
            RowComponent("AADHAAR NO".tr(),
                '${maskNumber(int.tryParse(member.aadhaRNO ?? '') ?? 0)}'),
            Row(
              children: [
                Expanded(
                  child: RowComponent(
                      "GENDER".tr(),
                      member.gender?.toUpperCase() == "M"
                          ? 'Male'
                          : member.gender?.toUpperCase() == "F"
                              ? "Female"
                              : "Other"),
                ),
                /*  IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.pink,
                  onPressed: onRemovePressed,
                ), */
                /*  SizedBox(width: 5),
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.amber,
                  onPressed: onEditPressed,
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
