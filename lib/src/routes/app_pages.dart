import 'package:get/get.dart';
import 'package:science_platform/src/feature/authentication/forgot_password/views/forgot_password_page.dart';
import 'package:science_platform/src/feature/authentication/login/views/login_page.dart';
import 'package:science_platform/src/feature/authentication/otp/views/otp_page.dart';
import 'package:science_platform/src/feature/authentication/root/bindings/authentication_bindings.dart';
import 'package:science_platform/src/feature/authentication/set_new_password/binding/set_new_password_binding.dart';
import 'package:science_platform/src/feature/authentication/set_new_password/views/set_new_password_page.dart';
import 'package:science_platform/src/feature/authentication/signup/views/phone_number_verification_page.dart';
import 'package:science_platform/src/feature/authentication/signup/views/sign_up_page.dart';
import 'package:science_platform/src/feature/classroom/root/view/my_courses_page.dart';
import 'package:science_platform/src/feature/courses/content/view/content_details/course_video_page/binding/video_player_binding.dart';
import 'package:science_platform/src/feature/courses/content/view/content_details/course_video_page/view/course_video_page.dart';
import 'package:science_platform/src/feature/courses/content/view/content_details/pdf/pdf_screen.dart';
import 'package:science_platform/src/feature/courses/content/view/content_details/root/note_details_page.dart';
import 'package:science_platform/src/feature/courses/content/view/content_list_page.dart';
import 'package:science_platform/src/feature/courses/free_courses/view/free_classes_page.dart';
import 'package:science_platform/src/feature/courses/free_courses/view/free_exams_page.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/view/bkash_webviewe.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/view/checkout_page.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/view/congratulation_page.dart';
import 'package:science_platform/src/feature/courses/root/binding/course_details_binding.dart';
import 'package:science_platform/src/feature/courses/root/view/category_details_page.dart';
import 'package:science_platform/src/feature/courses/root/view/course_details_page.dart';
import 'package:science_platform/src/feature/courses/root/view/courses_tab_page.dart';
import 'package:science_platform/src/feature/courses/root/view/sub_category_details_page.dart';
import 'package:science_platform/src/feature/courses/sections/view/course_sections_page.dart';
import 'package:science_platform/src/feature/dashboard/binding/dashboard_binding.dart';
import 'package:science_platform/src/feature/dashboard/view/dashboard_page.dart';
import 'package:science_platform/src/feature/exam/binding/exam_binding.dart';
import 'package:science_platform/src/feature/exam/binding/leaderboard_binding.dart';
import 'package:science_platform/src/feature/exam/view/exam_analysis_page.dart';
import 'package:science_platform/src/feature/exam/view/exam_info_page.dart';
import 'package:science_platform/src/feature/exam/view/exam_leaderboard_page.dart';
import 'package:science_platform/src/feature/exam/view/exam_page.dart';
import 'package:science_platform/src/feature/exam/view/group_exam_page.dart';
import 'package:science_platform/src/feature/home/blogs/bindings/blog_binding.dart';
import 'package:science_platform/src/feature/home/blogs/view/blog_details_page.dart';
import 'package:science_platform/src/feature/home/blogs/view/blog_page.dart';
import 'package:science_platform/src/feature/home/feedback/binding/feedback_binding.dart';
import 'package:science_platform/src/feature/home/feedback/view/feedback_page.dart';
import 'package:science_platform/src/feature/home/job_circular/view/circular_details_page.dart';
import 'package:science_platform/src/feature/home/job_circular/view/circulars_page.dart';
import 'package:science_platform/src/feature/home/model_test/binding/question_bank_binding.dart';
import 'package:science_platform/src/feature/home/model_test/view/exam_list_page.dart';
import 'package:science_platform/src/feature/home/model_test/view/exam_webview_page.dart';
import 'package:science_platform/src/feature/home/model_test/view/model_test_page.dart';
import 'package:science_platform/src/feature/home/model_test/view/subject_choice_page.dart';
import 'package:science_platform/src/feature/home/model_test/view/unit_selection_page.dart';
import 'package:science_platform/src/feature/home/notifications/notification_notice_tab.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/view/notice_details_page.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/view/notice_page.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notification/view/notification_page.dart';
import 'package:science_platform/src/feature/home/root/view/home_page.dart';
import 'package:science_platform/src/feature/home/root/view/webview_page.dart';
import 'package:science_platform/src/feature/home/support/binding/support_binding.dart';
import 'package:science_platform/src/feature/home/support/view/support_page.dart';
import 'package:science_platform/src/feature/onboarding/splash/view/splash_page.dart';
import 'package:science_platform/src/feature/profile/view/profile_info_page.dart';
import 'package:science_platform/src/feature/profile/view/profile_page.dart';
import 'package:science_platform/src/feature/profile/view/profile_update_page.dart';

part './app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    /// On boarding
    GetPage(
      transition: Transition.fade,
      name: Routes.initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.splash,
      page: () => const SplashPage(),
    ),

    /// Authentication
    GetPage(
      transition: Transition.fade,
      name: Routes.login,
      page: () => LoginPage(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.signup,
      page: () => SignUpPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.confirmPhoneNumber,
      page: () => PhoneNumberVerificationPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.otp,
      page: () => const OtpPage(),
    ),
    GetPage(
        transition: Transition.fade,
        name: Routes.setNewPassword,
        page: () => SetNewPasswordPage(),
        binding: SetNewPasswordBinding()),
    GetPage(
      transition: Transition.fade,
      name: Routes.updateProfilePage,
      page: () => ProfileUpdatePage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.profileInfo,
      page: () => const ProfileInfoScreen(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.profileDashboard,
      page: () => const ProfileDashboardPage(),
    ),

    /// Dashboard
    GetPage(
      transition: Transition.fade,
      name: Routes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),

    /// Tabs
    GetPage(
      transition: Transition.fade,
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.courses,
      page: () => const CourseTabPage(),
    ),

    /// Home Drawer
    GetPage(
      transition: Transition.fade,
      name: Routes.support,
      page: () => const SupportPage(),
      binding: SupportBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.feedback,
      page: () => const FeedbackPage(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.myCourse,
      page: () => const MyCoursesPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.categoryDetails,
      page: () => CategoryDetailsPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.subCategoryDetails,
      page: () => SubCategoryDetailsPage(),
    ),

    /// Free Courses
    GetPage(
      transition: Transition.fade,
      name: Routes.freeClasses,
      page: () => const FreeClassesPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.freeExams,
      page: () => const FreeExamsPage(),
    ),

    /// Question Bank
    GetPage(
      transition: Transition.fade,
      name: Routes.questionBank,
      page: () => const ModelTestPage(),
      binding: QuestionBankBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.unitSelection,
      page: () => const UnitSelectionPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.examList,
      page: () => const ExamListPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.examInfo,
      page: () => ExamInfoPage(),
      binding: ExamInfoBinding(),
    ),
    GetPage(
        transition: Transition.fade,
        name: Routes.subjectChoice,
        page: () => SubjectChoicePage(),
        binding: ExamInfoBinding()),
    GetPage(
      transition: Transition.fade,
      name: Routes.examPage,
      page: () => ExamPage(),
      binding: ExamBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.examWebviewPage,
      page: () => const ExamWebviewPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.groupExamPage,
      page: () => const GroupExamPage(),
      binding: ExamBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.examAnalysis,
      page: () => ExamAnalysisPage(),
      binding: ExamAnalysisBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.examLeaderboard,
      page: () => ExamLeaderboardPage(),
      binding: LeaderboardBinding(),
    ),

    /// Subject Review
    GetPage(
      transition: Transition.fade,
      name: Routes.blogPage,
      page: () => const BlogPage(),
      binding: BlogBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.blogDetailsPage,
      page: () => BlogDetailsPage(),
      // binding: CourseIntroVideoViewController(),
    ),

    /// Job Circular
    GetPage(
      transition: Transition.fade,
      name: Routes.circulars,
      page: () => const CircularsPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.circularDetails,
      page: () => const CircularDetailsPage(),
    ),

    /// Notification And Notice
    GetPage(
      transition: Transition.fade,
      name: Routes.notificationAndNoticeTab,
      page: () => const NotificationAndNoticeTab(
        initialIndex: 1,
      ),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.notification,
      page: () => const NotificationPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.notice,
      page: () => const NoticePage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.noticeDetails,
      page: () => const NoticeDetailsPage(),
    ),

    /// Course Details
    GetPage(
      transition: Transition.fade,
      name: Routes.courseDetails,
      page: () => CourseDetailsPage(),
      binding: CourseDetailsBinding(),
    ),

    /// Classroom

    GetPage(
      transition: Transition.fade,
      name: Routes.courseSections,
      page: () => const CourseSectionsPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.courseSectionContents,
      page: () => const ContentListPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.pdfDetails,
      page: () => const PDFScreen(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.noteDetails,
      page: () => const NoteDetailsPage(),
    ),
    GetPage(
      //transition: Transition.fade,
      name: Routes.courseVideo,
      page: () => const CourseVideoPage(),
      binding: VideoPlayerBinding(),
    ),

    /// Checkout
    GetPage(
      transition: Transition.fade,
      name: Routes.checkout,
      page: () => CheckoutPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.congratulation,
      page: () => const CongratulationPage(),
    ),

    /// Misc
    GetPage(
      transition: Transition.fade,
      name: Routes.webviewPage,
      page: () => const WebviewPage(),
    ),   GetPage(
      name: Routes.bkashWebview,
      page: () => const BkashWebViewPage(),
      transition: Transition.fade,
      // curve: Curves.easeInOut,
      // transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
