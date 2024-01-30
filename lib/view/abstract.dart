import 'package:flutter/material.dart';

import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';

class Abstract extends StatefulWidget {
  const Abstract({super.key});

  @override
  State<Abstract> createState() => _AbstractState();
}

class _AbstractState extends State<Abstract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: "Abstract",
        onPressedHome: () {
          Navigator.pop(context);
        },
        onPressedBack: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage(AppAssets.appBg),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 4.0),
                    child: GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 1.3),
                      itemBuilder: (context, index) {
                        List<Color?> backgroundColors = [
                          Color(0xffCEDFB9),
                          Color(0xffC8E6FD),
                          Color(0xffF8CAA6),
                          Color(0xffE4CDF5),
                          Color(0xffD2D4F7),
                          Color(0xffEBE5C5),
                        ];
                        Color? selectedColor =
                            backgroundColors[index % backgroundColors.length];
                        //final details = officerAbstractInfoList?[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.indigo[900] ?? Colors.grey,
                                  width: 1,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          color: Colors.indigo[900],
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.18,
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.07,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(32),
                                                topRight: Radius.circular(8),
                                                topLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            color: selectedColor),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06),
                                          child: Icon(Icons.person,
                                              color: Colors.white)
                                         /*  Image.network(
                                            "details?.image",
                                            height: 30,
                                            width: 30,
                                          ), */
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "details?.name",
                                    style: TextStyle(
                                        color: Colors.indigo[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
