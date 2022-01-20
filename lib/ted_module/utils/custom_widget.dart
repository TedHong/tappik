import 'package:cached_network_image/cached_network_image.dart';
import '../common/colors.dart';
import 'tplog.dart';
import 'tdtext.dart';
import '../utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomWidget {
  FadeInImage getFadeInImage(String _url, double _w, double _h, BoxFit _fit) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: _url,
      width: _w,
      height: _h,
      fit: _fit,
    );
  }

  static AEImage(String path) {
    return CachedNetworkImage(
      imageUrl: path,
      placeholder: (context, url) => Container(
        height: 240,
      ), //Indicator(300, 300, 50, AEColors.POINT, 5),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    // return FadeInImage.assetNetwork(
    //   placeholder: 'assets/images/loading.gif',
    //   image: path,
    // );
  }

  static AEImageSize(String path, double _w, double _h, BoxFit _f) {
    if (path == null) {
      return Container();
    } else {
      if (path.contains('http')) {
        return CachedNetworkImage(
          width: _w,
          height: _h,
          fit: _f,
          imageUrl: path,
          placeholder: (context, url) =>
              Container(), //Indicator(_w, _h, 50, AEColors.POINT, 5),
          errorWidget: (context, url, error) {
            TPLog.log(error.toString());
            return Icon(Icons.error);
          },
        );
      } else if (path.contains('.svg')) {
        return SvgPicture.asset(
          path,
          //color: Colors.white,
          semanticsLabel: '',
          width: _w,
          height: _h,
          fit: _f,
        );
      } else {
        return SizedBox(
            width: _w,
            height: _h,
            child: Image.asset(path, width: _w, height: _h, fit: _f));
      }
    }

    // return FadeInImage.assetNetwork(
    //   placeholder: 'assets/images/loading.gif',
    //   image: path,
    //   width: _w,
    //   height: _h,
    //   fit: _f,
    //   placeholderScale: 0.3,
    // );
  }

  static getBlankBox(double _width, double _height) {
    return SizedBox(
      width: _width,
      height: _height,
    );
  }

  // 4분할, 이미지, 텍스트
  static getVideoCard(
      BuildContext context,
      double _w,
      double _h,
      String _filePath,
      double _img_w,
      double _img_h,
      String _title,
      String _subTitle) {
    return Container(
        width: _w,
        height: _h,
        //color: Colors.blue,
        child: Wrap(
          children: [
            Column(
              children: [
                SizedBox(
                  width: _w,
                  child:
                      AEImageSize(_filePath, _img_w, _img_h, BoxFit.fitWidth),
                ),
                Visibility(
                    visible: (_title != ""),
                    child: AutoSizeText(
                      _title,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    )),
                Visibility(
                  visible: (_subTitle != ""),
                  child: AutoSizeText(
                    _title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(0x008D8D8D),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  //기본 가로형 강의 카드
  static getClassCardNormal_HOR(
    BuildContext context,
    String fileFullPath,
    String contentsName,
    int playingTime,
    int classIndex,
  ) {
    double _dw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Row(
        children: [
          //썸네일
          SizedBox(
            width: 166,
            height: 93,
            child: Stack(
              children: [
                CustomWidget.AEImageSize(
                    fileFullPath, 166, 93, BoxFit.fitWidth),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                      visible: playingTime > 0,
                      child: Container(
                          color: Color.fromARGB(125, 0, 0, 0),
                          child: SizedBox(
                            width: 82,
                            height: 24,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.convertTime(playingTime * 100),
                                  style: TextStyle(color: Colors.white),
                                )),
                          ))),
                ),
              ],
            ),
          ),
          //타이틀
          SizedBox(
              width: _dw - 200,
              height: 80,
              child: Column(
                children: [
                  Visibility(
                    visible: classIndex > 0,
                    child: TDText(
                        message: "${classIndex}강",
                        textAlignment: Alignment.centerLeft,
                        textColor: Color(
                          0xFFB3B3B3,
                        ),
                        textWeight: FontWeight.w400,
                        textSize: 14,
                        textPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  ),
                  TDText(
                    message: "${contentsName}",
                    textAlignment: Alignment.centerLeft,
                    textColor: Color(
                      0xffe0e0e0,
                    ),
                    textWeight: FontWeight.w400,
                    textSize: 16,
                    textPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    maxLines: 2,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  //기본 세로형 강의 카드
  static getClassCardNormal_VER(
    BuildContext context,
    String fileFullPath,
    String contentsName,
    String cast,
    int playingTime,
    int classIndex,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Column(
        children: [
          //썸네일
          SizedBox(
            width: 166,
            height: 93,
            child: Stack(
              children: [
                CustomWidget.AEImageSize(
                    fileFullPath, 166, 93, BoxFit.fitWidth),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                      visible: playingTime > 0,
                      child: Container(
                          color: Color.fromARGB(125, 0, 0, 0),
                          child: SizedBox(
                            width: 82,
                            height: 24,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Utils.convertTime(playingTime * 100),
                                  style: TextStyle(color: Colors.white),
                                )),
                          ))),
                ),
              ],
            ),
          ),
          //타이틀
          SizedBox(
              width: 200,
              height: 80,
              child: Column(
                children: [
                  TDText(
                    message: "${contentsName}",
                    textAlignment: Alignment.centerLeft,
                    textColor: Color(
                      0xffe0e0e0,
                    ),
                    textWeight: FontWeight.w400,
                    textSize: 16,
                    textPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    maxLines: 2,
                  ),
                  TDText(
                    message: "${cast}",
                    textAlignment: Alignment.centerLeft,
                    textColor: Colors.white60,
                    textWeight: FontWeight.w400,
                    textSize: 14,
                    textPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    maxLines: 2,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  static getNothingLayout(double _w, double _h, String _msg, String imagePath) {
    return Container(
      //color: Colors.white,
      width: _w,
      height: _h,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          _msg,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static Indicator(
      double _w, double _h, double _size, Color _color, int dot_num) {
    return Container(
      alignment: Alignment.center,
      width: _w,
      height: _h,
      child: JumpingDotsProgressIndicator(
        numberOfDots: dot_num,
        fontSize: _size,
        color: _color,
      ),
    );
  }

  static CircularIndicatorFullSize(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AEColors.POINT50),
      ),
    );
  }

  static ErrorBox(double _w, double _h) {
    return Container(
      width: _w,
      height: _h,
      child: getNothingLayout(_w, _h, "데이터를 불러오지 못했습니다.", ""),
    );
  }

  static getImageButton(Function() func, String imgPath, double _w, double _h) {
    return InkWell(
      splashColor: Colors.yellow,
      onTap: func,
      child: CustomWidget.AEImageSize(imgPath, _w, _h, BoxFit.none),
    );
  }

  // static getGridTile(ProgramModel data) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //     width: 200,
  //     height: 200,
  //     //color: Colors.blue,
  //     child: Column(
  //       children: [
  //         CustomWidget.AEImageSize(
  //             data.programImage.fileFullPath, 190, 103, BoxFit.fitHeight),
  //         AEText(
  //           message: data.programTitle,
  //           textSize: 14,
  //           minSize: 10,
  //           maxLines: 2,
  //           textColor: AEColors.COLOR_WHITE_T100,
  //           textPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
  //         ),
  //         AEText(
  //           message: data.castName,
  //           textSize: 12,
  //           minSize: 9,
  //           textColor: AEColors.WHITE_60,
  //           textPadding: EdgeInsets.fromLTRB(5, 3, 5, 0),
  //           maxLines: 2,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static getHorLine(w) {
    return Container(
      width: w,
      height: 1,
      decoration: BoxDecoration(
        color: Colors.white24,
      ),
    );
  }

  static getFlatButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: Colors.black26,
      primary: AEColors.POINT,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );
  }

  static getRoundedButton(msg, {margin = EdgeInsets.zero, double w = 80, double h = 30, c = Colors.lightBlue, double fs = 10, tc = Colors.black, double rad = 8, FontWeight fw = FontWeight.w300}) {
    return Container(
      margin: margin,
      child: Text(
        msg,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: tc,
          fontSize: fs,
          fontWeight: fw
        ),
      ),
      height: h,
      width: w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(rad),
      ),
    );
  }

  static Widget getCustomInput(context, title, TextEditingController _ctrl){
    return Row(
      children : [
        Text(title, style: Theme.of(context).textTheme.subtitle1),
        TextFormField(
              controller: _ctrl,
              decoration: InputDecoration(hintText: title),
          ),
      ] 
    );
  }
}
