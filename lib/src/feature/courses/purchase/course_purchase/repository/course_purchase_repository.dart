import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class CoursePurchaseRepository {
  Future<dynamic> placeOrder(Map<String, dynamic> data) async {
    final res = await RestClient().post(
      APIType.PROTECTED,
      API.order,
      data,
    );
    return res.data;
  }

  Future<dynamic> enrollInFreeCourse({required int orderId}) async {
    final res = await RestClient().post(
      APIType.PROTECTED,
      API.purchaseFreeCourse,
      {},
      queryParams: {
        'order_id': orderId,
      },
    );
    return res.data;
  }
}
