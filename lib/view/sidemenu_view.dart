import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/constants/app_assets.dart';
import '../view_model/sidemenu_view_model.dart';

class SideMenuView extends StatefulWidget {
  const SideMenuView({
    Key? key,
  }) : super(key: key);
  @override
  State<SideMenuView> createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  List<Map<String, dynamic>> subtitleGroups = [
    /*  {
      'title': 'Designs',
      'subtitles': [
        {'title': 'Grids', 'image': AppAssets.appIcon},
        {'title': 'GridsInCard', 'image': AppAssets.appIcon},
        {'title': 'ListView', 'image': AppAssets.appIcon},
        {'title': 'HorizontalListView', 'image': AppAssets.appIcon},
        {'title': 'HorizontalVerticalListView', 'image': AppAssets.appIcon},
      ],
    }, */
    {
      'title': '',
      'subtitles': [
        {'title': 'Home', 'image': AppAssets.home},
        /*  {'title': 'Attendance', 'image': AppAssets.appIcon},
        {'title': 'Approve Team Attendance', 'image': AppAssets.appIcon},
        {'title': 'Team Attendance', 'image': AppAssets.appIcon},
        {'title': 'Download Masters', 'image': AppAssets.appIcon}, */
      ],
    },
    {
      'title': 'Services',
      'subtitles': [
        {'title': 'Download Masters', 'image': AppAssets.downloadMasters},
        {'title': 'Reports', 'image': AppAssets.reports},
        /*  {'title': 'Attendance', 'image': AppAssets.appIcon},
        {'title': 'Approve Team Attendance', 'image': AppAssets.appIcon},
        {'title': 'Team Attendance', 'image': AppAssets.appIcon},
        {'title': 'Download Masters', 'image': AppAssets.appIcon}, */
      ],
    },
    {
      'title': 'Info',
      'subtitles': [
        {'title': 'Privacy Policy', 'image': AppAssets.privacy},
        {'title': 'App Info', 'image': AppAssets.info}
      ],
    },
    {
      'title': 'Others',
      'subtitles': [
        {'title': 'Exit application', 'image': AppAssets.exit},
        {'title': 'Logout', 'image': AppAssets.logout},
      ],
    },
  ]; // Define the subtitle groups as a list of maps
  List<Map<String, dynamic>> subtitles = [];

  String? ImagePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuViewModel>(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.appIcon),
                  fit: BoxFit.fill,
                ),
              ),
              /*  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset(AppAssets.appIcon),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white)),
                ],
              ), */
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                itemCount: subtitleGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  String groupTitle = subtitleGroups[index]['title'];
                  List<Map<String, dynamic>> subtitles =
                      subtitleGroups[index]['subtitles'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groupTitle != '') ...{
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 5.0),
                          child: Text(
                            groupTitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black45),
                          ),
                        ),
                        Column(
                          children: subtitles.map((subtitle) {
                            return ListTile(
                              leading: Image.asset(
                                subtitle['image'],
                                width: 28.0,
                                height: 28.0,
                                fit: BoxFit.cover,
                              ),
                              title: Text(subtitle['title']),
                              onTap: () {
                                sideMenuProvider.navigationTo(
                                    context, subtitle['title']);
                              },
                            );
                          }).toList(),
                        ),
                      } else ...{
                        Column(
                          children: subtitles.map((subtitle) {
                            return ListTile(
                              leading: Image.asset(
                                subtitle['image'],
                                width: 28.0,
                                height: 28.0,
                                fit: BoxFit.cover,
                              ),
                              title: Text(subtitle['title']),
                              onTap: () {
                                sideMenuProvider.navigationTo(
                                    context, subtitle['title']);
                              },
                            );
                          }).toList(),
                        ),
                      },
                      Divider()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
