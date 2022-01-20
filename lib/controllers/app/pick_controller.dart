import 'package:get/get.dart';

class PickController extends GetxController {
  final _imgList = [].obs;

  //test : prototype
  final _testList = [
    "https://i.imgur.com/HNMpVLk.jpeg",
    "https://i.imgur.com/L68FtMA.jpeg",
    "https://i.imgur.com/nDlNN3X.jpeg",
    "https://i.imgur.com/r3aOrQT.jpeg",
    "https://i.imgur.com/FCjuQ8I.jpeg",
    "https://i.imgur.com/fMw5nBz.jpeg",
    "https://i.imgur.com/NQyY32x.jpeg",
    "https://i.imgur.com/gte755a.jpeg",
    "https://i.imgur.com/Be5PTBb.jpeg",
    "https://i.imgur.com/Ht1BP1v.png",
    "https://i.imgur.com/M8iVhoj.jpeg",
  ];

  final List<String> _ids = [
    '2DSO1BeFnpU',
    'OOPAnSu4Cqs',
    'D7R0Ocn5C0M',
    'wifmYqdkmuI',
    'TQROhTsxak8',
    'ErD39HZYYEc',
    'SfnXig_2GmM',
    '6NFg59C3Dcc',
    'iOtqsyM5R7I',
    'QdN5oxCht5A',
  ];

  // VideoPlayerController? controller;
  // VideosAPI? videoSource;

  int prevVideo = 0;
  int actualScreen = 0;
  

  @override
  void onInit() {
    _imgList.bindStream(getDataList());
    super.onInit();
  }

  Stream<List<String>> getDataList() {
    // Stream <QuerySnapshot> stream =
    //   Firestore.instance.collection('videos').snapshots();

    // return stream.map((qShot) => qShot.documents
    //   .map((doc) => Video(
    //     title: doc.data['title'],
    //     url: doc.data['url'],
    //     datum: doc.data['datum']))
    //   .toList());
    return _getTestStream();
  }

  //test : prototype
  Stream<List<String>> _getTestStream() async* {
    List<String> result = [];
    for (var i = 0; i < _ids.length; i++) {
      result.add(_ids[i]);
      await Future.delayed(Duration(milliseconds: 100));
    }
    yield result;
  }
}
