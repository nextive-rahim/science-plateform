import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class BlogRepository {
  Future<dynamic> fetchFeaturedBlogs() async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.featuredBlogs,
    );
    return res.data;
  }

  Future<dynamic> fetchBlogs(String? slug) async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.allBlogs,
    );
    return res.data;
  }

  Future<dynamic> fetchBlogDetails(String slug) async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.blogDetails(slug),
    );
    return res.data;
  }
}
