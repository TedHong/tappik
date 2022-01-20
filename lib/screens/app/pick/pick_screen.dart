import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tappik/controllers/app/pick_controller.dart';
import 'package:tappik/screens/app/components/bottombar_widget.dart';
import 'package:tappik/ted_module/widget/fullscreen_slider.dart';

class PickScreen extends StatefulWidget {
  PickScreen({Key? key}) : super(key: key);

  @override
  _PickScreenState createState() => _PickScreenState();
}

class _PickScreenState extends State<PickScreen> {
  late final _pickCtrl;
  @override
  Widget build(BuildContext context) {
    _pickCtrl = Get.put(PickController());
    return Material(
      child: StreamBuilder<List<String>>(
        stream: _pickCtrl.getDataList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return videoScreen(); //FullscreenSlider(snapshot.data);
          }
        },
      ),
    );
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            onPageChanged: (value) {
              print(value);
              if (value == 1)
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              else
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return scrollFeed();
              else
                return Container(); //profileView();
            },
          )
        ],
      ),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: currentScreen()),
        BottomBar(),
      ],
    );
  }

  Widget currentScreen() {
    switch (_pickCtrl.actualScreen) {
      case 0:
        return feedVideos();
      // case 1:
      //   return SearchScreen();
      // case 2:
      //   return MessagesScreen();
      // case 3:
      //   return ProfileScreen();
      default:
        return feedVideos();
    }
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: _pickCtrl.videoSource?.listVideos.length,
          onPageChanged: (index) {
            //index = index % (_pickCtrl.videoSource!.listVideos.length);
            _pickCtrl.changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            //index = index % (feedViewModel.videoSource!.listVideos.length);
            return Container(); //videoCard(feedViewModel.videoSource!.listVideos[index]);
          },
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Following',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70)),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    color: Colors.white70,
                    height: 10,
                    width: 1.0,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text('For You',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ]),
          ),
        ),
      ],
    );
  }
}
