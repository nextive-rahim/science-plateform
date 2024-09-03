import 'package:science_platform/src/core/exception/error_handler.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

class CourseVideoViewController extends GetxController {
  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  late ContentModel contentModel;
  late String youTubeVideoLink;

  void getCourseVideo(ContentModel content, {bool isLive = true}) {
    contentModel = content;
    if (isLive) {
      if (contentModel.live.isNotNull && contentModel.live!.link.isNotNull) {
        youTubeVideoLink = contentModel.live!.link!;
      }
    } else {
      if (contentModel.video.isNotNull && contentModel.video!.link.isNotNull) {
        youTubeVideoLink = contentModel.video!.link!;
      }
    }
    _getYouTubeVideo();
  }

  _getYouTubeVideo() async {
    _pageStateController(PageState.loading);
    try {
      await checkIfTheVideoIsLive();
      _initializeVideoPlayerController();
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  /// Video player
  late final PodPlayerController podPlayerController;
  late PodPlayerController podController;
  bool isLiveVideo = false;

  Future<void> checkIfTheVideoIsLive() async {
    podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
      youTubeVideoLink,
      live: true,
    ));

    try {
      await podController.initialise();
    } catch (e) {
      isLiveVideo = false;
    }

    if (podController.isInitialised) {
      isLiveVideo = true;
    } else {
      isLiveVideo = false;
    }
  }

  void _initializeVideoPlayerController() {
    podPlayerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        youTubeVideoLink,
        live: isLiveVideo,
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        videoQualityPriority: [144, 240, 360, 480, 720, 1080],
        wakelockEnabled: true,
      ),
    )..initialise();

    if (podController.isInitialised) {
      podController.dispose();
    }
  }

  @override
  void onClose() {
    podPlayerController.dispose();
    super.onClose();
  }
}
