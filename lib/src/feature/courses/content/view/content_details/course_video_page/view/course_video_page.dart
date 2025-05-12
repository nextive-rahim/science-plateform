import 'package:flutter/services.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/models/video_model.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoPage extends StatefulWidget {
  const CourseVideoPage({super.key});

  @override
  State<CourseVideoPage> createState() => _CourseVideoPageState();
}

class _CourseVideoPageState extends State<CourseVideoPage> {
  final VideoModel video = Get.arguments;
  late final PodPlayerController controller;
  late final YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    controller = _controller;
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(video.link ?? '')!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideThumbnail: true,
        enableCaption: false,
        forceHD: false,
        loop: false,
      ),
    );

    super.initState();
  }

  PodPlayerController get _controller {
    String videoId =
        video.link != null ? video.link!.replaceAll(RegExp(r'[^0-9]'), '') : '';
    return PodPlayerController(
      playVideoFrom: video.source == VideoSourceType.vimeo.name
          ? PlayVideoFrom.vimeo(videoId)
          : PlayVideoFrom.youtube(
              video.link ?? 'https://www.youtube.com/watch?v=AOZdV0AaYMk',
            ),
    )..initialise();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String? selectedVendor = 'Auto';
  @override
  Widget build(BuildContext context) {
    return video.source == 'youtube'
        ? YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: youtubePlayerController,
              topActions: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const PlaybackSpeedButton(),

                      CommonPopupMenu2(
                        value2: selectedVendor,
                        onChanged: (value) {
                          setState(() {
                            selectedVendor = value;
                          });
                        },
                        dropdownItems: const [
                          'Auto',
                          '144',
                          '240',
                          '360',
                          '480',
                          '720'
                        ],
                        value: selectedVendor,
                      )
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.settings,
                      //       color: AppColors.white,
                      //     ))
                    ],
                  ),
                ),
              ],
              bottomActions: [
                BackwardButton(controller: youtubePlayerController),
                const CurrentPosition(),
                const ProgressBar(
                  isExpanded: true,
                ),
                const RemainingDuration(),
                ForwardButton(controller: youtubePlayerController),
                const FullScreenButton(),
              ],
            ),
            onExitFullScreen: () {
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp],
              );
            },
            onEnterFullScreen: () {
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft],
              );
            },
            builder: (context, player) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    video.title ?? '',
                  ),
                  backgroundColor: AppColors.primary,
                ),
                body: ListView(
                  children: [
                    const SizedBox(height: 1),
                    player,
                  ],
                ),
              );
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                video.title ?? 'Video Lecture',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.primary,
              elevation: 0,
            ),
            body: Column(
              children: [
                video.source == VideoSourceType.embedded.name
                    ? HtmlWidget(video.embedded)
                    : PodVideoPlayer(controller: controller),
              ],
            ),
          );
  }
}

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    super.key,
    required YoutubePlayerController controller,
  }) : _controller = controller;

  final YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.forward_10),
      color: Colors.white,
      onPressed: () {
        _controller.seekTo(
          Duration(
            seconds: _controller.value.position.inSeconds + 10,
          ),
        );
      },
    );
  }
}

class BackwardButton extends StatelessWidget {
  const BackwardButton({
    super.key,
    required YoutubePlayerController controller,
  }) : _controller = controller;

  final YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.replay_10),
      color: Colors.white,
      onPressed: () {
        _controller.seekTo(
          Duration(
            seconds: _controller.value.position.inSeconds - 10,
          ),
        );
      },
    );
  }
}

class CommonPopupMenu2 extends StatelessWidget {
  const CommonPopupMenu2({
    super.key,
    required this.onChanged,
    required this.dropdownItems,
    required this.value,
    required this.value2,
  });
  final void Function(String)? onChanged;
  final List<String> dropdownItems;
  final String? value;
  final String? value2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: LayoutBuilder(builder: (context, constraints) {
        return PopupMenuButton<String>(
            constraints: const BoxConstraints.tightFor(
              height: 200, // Adjust factor and max height
            ),
            color: AppColors.transparent.withOpacity(.3),
            onSelected: onChanged,
            itemBuilder: (context) {
              return [
                for (var value in dropdownItems)
                  PopupMenuItem(
                    value: value,
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: value == value2
                              ? AppColors.white
                              : AppColors.transparent,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          value,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
              ];
            },
            child: const Icon(
              Icons.settings,
              color: AppColors.white,
            )

            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: AppColors.lightBlack40,
            //     ),
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           value!,
            //           style: const TextStyle(color: AppColors.lightBlack60),
            //         ),
            //         const Icon(
            //           Icons.keyboard_arrow_down_rounded,
            //           size: 25,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            );
      }),
    );
  }
}
