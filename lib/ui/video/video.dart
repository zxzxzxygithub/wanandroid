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
  var vControllerList = Map();
  var cControllerList = Map();
  var overlayOffstage = false;
  var lastPosition = 0;
  var itemHeight;
  

  ScrollController listViewController = ScrollController();
  Map map3;
  Map map4;

  double max;

  var pageItems = List<Widget>();

  var minCount = 2;

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
    for (int i1 = 0; i1 < 6; i1++) {
      beanList.add(map4);
    }
    var length = beanList.length;
    print('beanlist length $length');
    listViewController.addListener(() {
      max = listViewController.position.maxScrollExtent;
    });
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
    for (var v in vControllerList.keys) {
      print('dispose v start');
      vControllerList[v].dispose();
      print('dispose v end');
    }
    for (var c in cControllerList.keys) {
      print('dispose c start');
      cControllerList[c].dispose();
      print('dispose c end');
    }
  }

//  var listviewContainers = List();
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
    var pageView = PageView.builder(
      itemCount: beanList.length,
      scrollDirection: Axis.vertical,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
//        if (index <= listviewContainers.length - 1 &&
//            listviewContainers[index] != null) {
//          return listviewContainers[index];
//        }
        Container container = getVideoContainer(index);
//        listviewContainers.add(container);
        print('add  $index');
        return container;
      },
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
  var downWard = false;

  onPageChanged(page) {
    print('page $page');
    if (lastPage != -1) {
      vControllerList[lastPage].pause();
    }
    vControllerList[page].play();
    if (page < lastPage) {
      downWard = true;
    } else {
      downWard = false;
    }
    lastPage = page;
    if (page >= beanList.length - 5) {
      setState(() {
        beanList.add(map4);
        beanList.add(map3);
//        var length = listviewContainers.length;
//        print('containers length $length');
      });
    }
    if (vControllerList.length >= 6) {
      if (downWard) {
        vControllerList[minCount].dispose();
        vControllerList[minCount + 1].dispose();
      } else {
        vControllerList[minCount - 2].dispose();
        vControllerList[minCount - 1].dispose();
      }
      vControllerList.removeWhere((key, value) {
        var condition = key < minCount;
        if (downWard) {
          condition = key >= minCount;
        }
        return condition;
      });
      if (downWard) {
        cControllerList[minCount].dispose();
        cControllerList[minCount + 1].dispose();
      } else {
        cControllerList[minCount - 2].dispose();
        cControllerList[minCount - 1].dispose();
      }
      cControllerList.removeWhere((key, value) {
        var condition = key < minCount;
        if (downWard) {
          condition = key >= minCount;
        }
        return condition;
      });
      if (downWard) {
        minCount -= 2;
      } else {
        minCount += 2;
      }
    }

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
    var curUrl = bean['url'];
//    print('build controller');
//    print('index');
//    print(index);
//    print('curUrl');
//    print(curUrl);

    var _controller = VideoPlayerController.network(curUrl);
    vControllerList[index] = _controller;
    var vlength = vControllerList.length;
    print('vcontroller length $vlength');
    var _chewieController = getChewieController(bean, _controller);
    cControllerList[index] = _chewieController;
    var clength = cControllerList.length;
    print('ccontroller length $clength');
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
    clearVControl();
    return Future.value(true);
  }
}

