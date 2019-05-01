import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPage extends StatefulWidget {
  @override
  MediaState createState() {
    return MediaState();
  }
}

class MediaState extends State<VideoPage> {
  var curIndex = 1;
  var videoUrl = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/t0modmjaiqzi9o4cpulx.mp4';
  var beanList = List();
  var vControllerList = List();
  var cControllerList = List();
  var overlayOffstage = false;
  var lastVideoController;
  var lastChewController;

  ScrollController listViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    Map map = Map();
    var url1 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/t0modmjaiqzi9o4cpulx.mp4';
    map['url'] = url1;
    map['videoidth'] = 544;
    map['videoHeight'] = 960;
    beanList.add(map);
    Map map2 = Map();
    var url2 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/a3ktpgfk1w0vok997qzc.mp4';
    map2['url'] = url2;
    map2['videoidth'] = 368;
    map2['videoHeight'] = 640;
    beanList.add(map2);
    Map map3 = Map();
    var url3 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/0moddwhac1a8gswxrgux.mp4';
    map3['url'] = url3;
    map3['videoidth'] = 368;
    map3['videoHeight'] = 640;
    beanList.add(map3);
    Map map4 = Map();
    var url4 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/z010m9ohg0a649k605c9.mp4';
    map4['url'] = url4;
    map4['videoidth'] = 368;
    map4['videoHeight'] = 350;
    beanList.add(map4);
    listViewController.addListener(() {
      print('listViewController load complete');
      if (listViewController.position.pixels ==
          listViewController.position.maxScrollExtent) {
        print('scroll to bottom');
      }
    });
  }

  @override
  void dispose() {
    for (var v in vControllerList) {
      print('dispose v start');
      v.dispose();
      print('dispose v end');
    }
    for (var c in cControllerList) {
      print('dispose c start');
      c.dispose();
      print('dispose c end');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery
        .of(context)
        .size
        .height;
    var listView = ListView.builder(
            controller: listViewController,
            itemCount: 4,
            itemBuilder: (context, index) {
              var container = Container(
                height: itemHeight,
                child: Chewie(
                  controller: buildController(index),
                ),);

              return container;
            },
          );
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Media"),
            actions: <Widget>[],
          ),
          body: NotificationListener(
            onNotification:(ScrollNotification note){
//              print(' 滚动位置。');  // 滚动位置。
//              print(note.metrics.pixels.toInt());  // 滚动位置。
//              print(' extentInside。');  // 滚动位置。
//              print(note.metrics.extentInside);  // 滚动位置。
              print(' axisDirection。');  // 滚动位置。
              print(note.metrics.axisDirection.toString());  // 滚动位置。
            },
            child: listView,
          ),));
  }

  ChewieController buildController(int index) {
    var bean = beanList[index];
    lastVideoController?.pause();
    lastChewController?.pause();
    var curUrl = bean['url'];
    print('index');
    print(index);
    print('curUrl');
    print(curUrl);

    var _controller = VideoPlayerController.network(curUrl);
    lastVideoController = _controller;
    vControllerList.add(_controller);
    var _chewieController = getChewieController(bean, _controller);
    cControllerList.add(_chewieController);
    lastChewController = _chewieController;
    if (index == curIndex) {
      _controller.play();
    } else {
      _controller.pause();
    }
    return _chewieController;
  }

  ChewieController getChewieController(dynamicBean, _controller) {
    return ChewieController(
      videoPlayerController: _controller,
      aspectRatio: dynamicBean['videoidth'] / dynamicBean['videoHeight'],
      autoPlay: false,
      looping: true,
      showControls: false,
      overlay: Offstage(
        offstage: overlayOffstage,
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
      // 占位图
      placeholder: Container(
        color: const Color(0xFF333333),
      ),
      // 是否在 UI 构建的时候就加载视频
      autoInitialize: true,
    );
  }


  Future<bool> _onWillPop() {
    print('_onWillPop');
    print(vControllerList.toString());
    for (var v in vControllerList) {
      print('dispose v start');
      v.dispose();
      print('dispose v end');
    }
    print(cControllerList.toString());
    for (var c in cControllerList) {
      print('dispose c start');
      c.dispose();
      print('dispose c end');
    }
    print('$cControllerList.length' + '~');
    return Future.value(true);
  }
}

