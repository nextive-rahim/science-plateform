import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class PaymentRepository {
  Future<dynamic> aamarPayVerify(
      Map<String, dynamic> data, String orderId) async {
    final res = await RestClient().post(
      APIType.PROTECTED,
      API.aamarPayVerify,
      data,
      headers: {
        'order_id': orderId,
      },
    );
    return res.data;
  }

  Future<dynamic> paymentOrder(Map<String, dynamic> data) async {
    final res = await RestClient.dev().post(
      APIType.PROTECTED,
      API.payments,
      data,
    );
    return res.data;
  }

  Future<dynamic> fetchPaymentInstruction() async {
    final res = await RestClient().get(
      APIType.PROTECTED,
      '${API.paymentInstruction}/how-to-payment',
    );

    return res.data;
  }

  Future<dynamic> bkashPaymentOrder(Map<String, dynamic> data) async {
    final res = await RestClient.dev().post(
      APIType.PROTECTED,
      API.bkashPayment,
      data,
    );
    return res.data;
  }
}
