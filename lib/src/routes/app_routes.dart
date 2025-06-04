part of './app_pages.dart';

abstract class Routes {
  /// On boarding
  static const String initial = '/';
  static const String splash = '/splash';

  /// Authentication
  static const login = '/login';
  static const signup = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const otp = '/otp';
  static const setNewPassword = '/set-new-password';
  static const confirmPhoneNumber = '/confirm-phone-number';

  /// Dashboard
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const courses = '/courses';
  static const classroom = '/classroom';
  static const profileDashboard = '/profileDashboard';
  static const profileInfo = '/profileInfo';

  /// Classroom
  static const courseSections = '/courseContent';
  static const courseSectionContents = '/courseContentDetails';
  static const pdfList = '/pdfList';
  static const pdfDetails = '/pdfDetails';
  static const noteDetails = '/noteDetails';
  static const courseVideo = '/courseVideo';
  static const assignment = '/assignment';
  static const uploadAssignment = '/assignmentUpload';
  static const assignmentAnswer = '/assignmentAnswer';
  static const courseCommunity = '/courseCommunity';

  /// Book Store

  static const bookStoreDetail = '/bookStoreDetail';
  static const bookStore = '/bookStore';
  static const bookPreviews = '/bookPreviews';

  /// Book Purchase
  static const cart = '/cart';
  static const addressInfo = '/addressInfo';
  static const checkout = '/checkout';
  static const bookCheckout = '/bookCheckout';
  static const congratulation = '/congratulation';

  /// My Orders
  static const myOrders = '/myOrders';
  static const myOrderDetails = '/myOrderDetails';

  /// Home drawer
  static const support = '/support';
  static const feedback = '/feedback';
  static const myCourse = '/myCourse';
  static const affiliation = '/affiliation';
  static const applyAffiliation = '/applyAffiliation';

  /// Free courses
  static const freeClasses = '/freeClasses';
  static const freeExams = '/freeExams';

  /// Notification & Notice
  static const notificationAndNoticeTab = '/notificationAndNoticeTab';
  static const notification = '/notification';
  static const notice = '/notice';
  static const noticeDetails = '/noticeDetails';

  /// Subject Review
  static const blogPage = '/blogPage';
  static const blogDetailsPage = '/blogDetailsPage';

  /// Job circular
  static const circulars = '/circulars';
  static const circularDetails = '/circularDetailsPage';

  /// Question Bank
  static const questionBank = '/questionBank';
  static const varsitySelection = '/universitySelection';
  static const unitSelection = '/unitSelection';
  static const examList = '/examList';

  static const subjectChoice = '/examSubjectChoice';
  static const examPage = '/examPage';
  static const examWebviewPage = '/examWebviewPage';
  static const groupExamPage = '/groupExamPage';
  static const examInfo = '/examInfo';
  static const examAnalysis = '/examAnalysis';
  static const examLeaderboard = '/examLeaderboard';

  static const writtenExamInfo = '/writtenExamInfo';
  static const writtenExamPage = '/writtenExam';
  static const writtenExamAnswer = '/writtenExamAnswer';

  /// Courses
  static const courseDetails = '/courseDetails';
  static const categoryDetails = '/categoryDetails';
  static const subCategoryDetails = '/subCategoryDetails';

  /// MISC
  static const updateProfilePage = '/updateProfilePage';
  static const webviewPage = '/webviewPage';
  static const bkashWebview = '/bkashWebview';
}
