class API {
  static const prod = "https://science-platform.nextlms.net/api/";
  static const dev = "https://science-platform.nextlms.net/api/";

  static const base = dev;

  /// Authentication
  static const login = "login";
  static const signup = "register";
  static const otp = "get-otp";
  static const resetPassword = "otp/reset-password";
  static const phoneNumberVerification = "verify-phone";

  /// User
  static const user = "user";

  static updateUserData(id) => "users/$id";

  /// Home Drawer
  static const feedback = "contact-us";
  static const guidelines = "page/guideline";
  static const photoGalleryCategoties = "gallery";

  static appReviews(String type) => "all_information?type=$type";
  static const bkashPayment = "bkash/create-payment";
  static photoGallery(int id) => "gallery/$id";

  /// Home
  static const home = "home";
  static const notice = "notices";

  static noticeDetails(String slug) => "notices/$slug";
  static const ads = "advertisement/active";
  static const settings = "settings";

  /// Course
  static featuredCourses({int perPage = 100, int pageNo = 1}) =>
      "course?filter=featured&per_page= $perPage&page=$pageNo";

  static courseCategory({String? slug}) => "course-category/$slug";

  static const coursesByCategories = "courses";
  static const categoryWithCourses = "category-with-course/";

  static const courseDetails = 'app/courses/';

  static courseSectionsAndContents(String slug) => 'app/$slug/sections';

  static sectionContentList(String slug) => "app/$slug/contents";

  static content(String slug) => "content/$slug";

  static const coupon = "verify-coupon";
  static const courses = "courses";

  /// Comment
  static const comments = "comments";

  /// Comment
  static const uploadToAws = "aws-url";
  static const assignment = "assignment";

  /// Book Store
  static const books = "product/category?filter=all";

  static featureBooks({int perPage = 10, int pageNo = 1}) =>
      "product?per_page=$perPage&page=$pageNo&filter=featured";

  static bookdetails(String slug) => "product/$slug";

  static reletedBook(int categoryId) =>
      "product?filter=category&category_id=$categoryId";

  /// address
  static const order = "order";
  static orderDetails(int id) => "orders/$id";

  /// Course Purchase
  static const payments = "payment";
  static const purchaseFreeCourse = 'free-course-purchase';
  static const myOrders = 'orders';

  /// Payment
  static const aamarPayVerify = 'aamarpay/callback';
  static const paymentInstruction = "page";

  /// Admission Calendar
  static const varsities = "varsities";

  /// University Information
  static const universityCategories = "varsity-categories";

  static instituteSelect({id}) => "varsity-categories/$id";

  /// Eligibility Verification
  static const eligibility = "eligibility";

  /// Classroom
  static const myCourses = "my-course?per_page=100";
  static const happeningToday = "todays-event";
  static const todaysAssignment = "course/assignment/happening-today";

  ///  Blogs
  static const featuredBlogs = "featured-blogs";
  static const allBlogs = "blogs?per_page=100";
  static blogDetails(slug) => "blogs/$slug";

  /// Job Circular
  static const circularCategories = "job-circular-categories/all";
  static const allCirculars = "job-circular?per_page=100&page=1";

  static circularList(slug) => "circular-by-category/$slug";

  static const circularDetails = "job-circular/";

  /// Question bank
  static const modelTestCategories =
      "model-test-categories?filter=withModelTest";
  static const modelTests = "model-test";
  static const myModelTest = 'my-modeltest?per_page=100';
  static modelTestDetails(slug) => "model-tests/$slug";
  static examDetails(id) => "exams/$id";
  static const submitExam = "results";
  static const submitWrittenExam = "written-exam-result";

  static writtenExamDetails(id) => "written-exam/$id";

  static leaderBoard(int id, {int perPage = 10}) =>
      "ranking/$id/?per_page=$perPage&page=1";

  /// Affiliation
  static const checkAffiliation = "check-user-is-affiliate";
  static const applyForAffiliation = "affiliate-join";
  static const affiliationLeaderBoard = "affiliation-leader-board";
  static const affiliationDetails = "affiliate-details?filter=my-commission";

  static affiliationCommissions({int perPage = 10, int pageNo = 1}) =>
      "commissions?filter=my-commission&per_page=$perPage&page=$pageNo";

  static affiliationWithdraws(int id, {int perPage = 10, int pageNo = 1}) =>
      "withdraws?withdrawable_type=affiliation&user_id=$id&per_page=$perPage&page=$pageNo";
}
