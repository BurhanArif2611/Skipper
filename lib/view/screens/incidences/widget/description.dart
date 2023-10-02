import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/search_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../../../../util/styles.dart';

class Description extends StatelessWidget {
  final bool isItem;
  Description({@required this.isItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (homeController) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Column(mainAxisSize: MainAxisSize.min,

              children: [
              (homeController.incidenceDetailResponse !=null && homeController.incidenceDetailResponse.audio.length>0 ?
              Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child:
                  ListView.builder(
                    itemCount: homeController.incidenceDetailResponse.audio.length,
                    padding: EdgeInsets.all(Dimensions
                        .PADDING_SIZE_EXTRA_LARGE_SMALL),
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      double _progressValue = 0.0;
                      Duration _currentPosition = Duration.zero;
                      Duration _duration = Duration.zero;
                      FlutterSoundPlayer _player= FlutterSoundPlayer();
                      return
                        Container(
                          margin: EdgeInsets.all(Dimensions
                              .PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                  width: 0.3,
                                  color: Theme.of(context).hintColor),
                              color: Theme.of(context).cardColor),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(_player.isPlaying ? Icons.pause : Icons.play_arrow),
                                    onPressed: () {
                                      if (_player.isPlaying) {
                                        _player.stopPlayer();
                                      } else {
                                        // playAudio(homeController.uploadedAudioURL[index].toString());

                                        try {
                                          if (_player.isPlaying) {
                                            _player.closeAudioSession();
                                            _player.closePlayer();
                                          }
                                          if (!_player.isPlaying) {
                                            _player.closePlayer();
                                            _player.openAudioSession();
                                          }
                                          print("url ling>>> ${homeController.uploadedAudioURL[index].toString()}");
                                          _player.startPlayer(fromURI: homeController.uploadedAudioURL[index].toString(),codec: Codec.aacADTS,);
                                          _player.setSubscriptionDuration(Duration(milliseconds: 100));
                                          print('Audio playback started');
                                          /* setState(() {
                                                      _isPlaying = true;
                                                    });*/

                                          _player.onProgress.listen((event) {
                                            print('Error starting audio playback: ${event.position}');
                                            /*setState(() {*/
                                              _currentPosition = event.position;
                                              _duration = event.duration;
                                              _progressValue = event.position.inMilliseconds / _duration.inMilliseconds;
                                              print('Error starting audio playback 21: $_progressValue');
                                           /* });*/
                                          });
                                        } catch (e) {
                                          print('Error starting audio playback: $e');
                                        }
                                      }
                                    },
                                  ),

                                  LinearProgressIndicator(
                                    color: Colors.red,
                                    value: _progressValue,
                                  ),
                                  Text('${_currentPosition.toString()} / ${_duration.toString()}'),
                                ],
                              ),

                            ],
                          ),
                        );
                    },
                  )):SizedBox()),

              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              Align(alignment: Alignment.centerLeft,
              child:
                Text(
                homeController.incidenceDetailResponse.description,
                style: robotoBold.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.5)),textAlign: TextAlign.start,
              )),
            ],)

          ),
        );
      }),
    );
  }
}
