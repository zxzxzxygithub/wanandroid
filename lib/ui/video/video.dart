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
  var lastPosition = 0;
  var itemHeight;
  

  ScrollController listViewController = ScrollController();
  Map map3;
  Map map4;

  double max;

  var pageItems = List<Widget>();

  @override
  void initState() {
    super.initState();
    print("111111111111111111111111111111111111111");
    Map map1 = Map();
    var url1 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/t0modmjaiqzi9o4cpulx.mp4';
    map1['url'] = url1;
    map1['videoidth'] = 544;
    map1['videoHeight'] = 960;
    beanList.add(map1);
    Map map2 = Map();
    var url2 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/a3ktpgfk1w0vok997qzc.mp4';
    map2['url'] = url2;
    map2['videoidth'] = 368;
    map2['videoHeight'] = 640;
    beanList.add(map2);
    map3 = Map();
    var url3 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/0moddwhac1a8gswxrgux.mp4';
    map3['url'] = url3;
    map3['videoidth'] = 368;
    map3['videoHeight'] = 640;
    map4 = Map();
    var url4 = 'http://mpmallapp.oss-cn-beijing.aliyuncs.com/dynamic/20190426/z010m9ohg0a649k605c9.mp4';
    map4['url'] = url4;
    map4['videoidth'] = 368;
    map4['videoHeight'] = 350;
    for (int i1 = 0; i1 < 4; i1++) {
      beanList.add(map4);
    }
    listViewController.addListener(() {
      max = listViewController.position.maxScrollExtent;
    });
    for (int i = 0; i < beanList.length; i++) {
      var container = getVideoContainer(i);
      pageItems.add(container);
    }
  }

  @override
  void didUpdateWidget(VideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(sep + 'didupdate widget' + sep);
  }

  @override
  void dispose() {
    clearVControl();
    super.dispose();
  }

  void clearVControl() {
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
  }

  List listviewContainers = List();
  var setPosition = -1;
  var minuseCount = 0;
  var pixels;
  var currentPosition;
  var sep = '~~~~~~~ ~~~~~~~ ~~~~~~~ ~~~~~~~ ';
  @override
  Widget build(BuildContext context) {
    itemHeight = MediaQuery
        .of(context)
        .size
        .height;
    var listView = ListView.builder(
            controller: listViewController,
      itemCount: beanList.length,
            itemBuilder: (context, index) {
              // if cached, use cache
              print('index $index');
              var length = listviewContainers.length;
              print('listviewcontainer length $length');
              if (index <= length - 1) {
                var storedContainer = listviewContainers[index];
                if (storedContainer != null) {
                  print('use cached list item~~~~~~~~~~~~~');
                  return storedContainer;
                }
              }
              Container container = getVideoContainer(index);
              listviewContainers.add(container);
              print('add  $index');
              return container;
            },
          );
    var pageView = PageView(
      scrollDirection: Axis.vertical,
      onPageChanged: onPageChanged,
      children: pageItems,
    );
    var notificationListener = NotificationListener(
      onNotification: (ScrollNotification note) {
        pixels = note.metrics.pixels;
        var position = (pixels / itemHeight).floor();
        currentPosition = position;
//              print('itemheight $height');
//              print('pixels $pixels');
//              print('position $position');
//              print('totalPosition $currentPosition');
//              print('current positon $currentPosition');
//              print(
//                  '~~~~~~~ ~~~~~~~ ~~~~~~~ ~~~~~~~ currentPosition currentPosition currentPosition currentPosition ~~~~~~~ $currentPosition ');
//              if(currentPosition-lastPosition==2 && vControllerList.length!=6){
//                currentPosition = lastPosition;
//              }
        if (currentPosition != setPosition) {
          setState(() {
            if (beanList.length < 6) {
              beanList.add(map3);
              beanList.add(map4);
            }
            if (beanList.length == 6 && vControllerList.length == 6) {
              vControllerList[0].dispose();
              vControllerList[1].dispose();
              cControllerList[0].dispose();
              cControllerList[1].dispose();
              vControllerList.removeRange(0, 2);
              cControllerList.removeRange(0, 2);
              beanList.removeRange(0, 2);
              listviewContainers.removeRange(0, 2);
              currentPosition = currentPosition - 2;
              lastPosition = currentPosition;
            }
            playCurrentPauselast(currentPosition);
            setPosition = currentPosition;
          }
          );
        } else {
          playCurrentPauselast(currentPosition);
        }
      },
      child: listView,
    );
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Media111"),
            actions: <Widget>[],
          ),
          body: pageView,));
  }

  Container getVideoContainer(int index) {
    var container = Container(
      height: itemHeight,
      child: Chewie(
        controller: buildController(index),
      ),);
    return container;
  }

  var lastPage = -1;

  onPageChanged(page) {
    print('page $page');
    if (lastPage != -1) {
      vControllerList[lastPage].pause();
    }
    vControllerList[page].play();
    lastPage = page;
  }

  void playCurrentPauselast(int currentPosition) {
//    if(currentPosition != lastPosition){
//      VideoPlayerController l = vControllerList[lastPosition];
//      l.pause();
//      print('pause $lastPosition');
//      VideoPlayerController c = vControllerList[currentPosition];
//      c.play();
//      print('play position $currentPosition');
//      lastPosition = currentPosition;
//    }
  }

  ChewieController buildController(int index) {
    var bean = beanList[index];
    lastVideoController?.pause();
    lastChewController?.pause();
    var curUrl = bean['url'];
//    print('build controller');
//    print('index');
//    print(index);
//    print('curUrl');
//    print(curUrl);

    var _controller = VideoPlayerController.network(curUrl);
    lastVideoController = _controller;
    var containsV = vControllerList.contains(_controller);
    if (!containsV) {
      vControllerList.add(_controller);
    }
    var vlength = vControllerList.length;
    print('vcontroller length $vlength');
    var _chewieController = getChewieController(bean, _controller);
    cControllerList.add(_chewieController);
    var clength = cControllerList.length;
    print('ccontroller length $clength');
    lastChewController = _chewieController;
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
      print('_onWillPop dispose v start');
      v.dispose();
      print('_onWillPop dispose v end');
    }
    print(cControllerList.toString());
    for (var c in cControllerList) {
      print('_onWillPop dispose c start');
      c.dispose();
      print('_onWillPop dispose c end');
    }
    print('$cControllerList.length' + '~');
    return Future.value(true);
  }
}

