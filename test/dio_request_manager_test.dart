import 'package:flutter_test/flutter_test.dart';
import 'package:dio_request_manager/dio_request_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

class MockDioRequestManager extends Mock implements DioRequestManager {}

@GenerateMocks([DioRequestManager])
void main() {
  late MockDioRequestManager mockApiManager;

  setUp(() {
    mockApiManager = MockDioRequestManager();
  });

  test('Successful API Call', () async {
    when(
      mockApiManager.request(
        '/test-endpoint',
        {},
        RequestType.get,
        useToken: false,
      ),
    ).thenAnswer(
      (_) async => ApiResponse(
        message: 'Success',
        success: true,
        data: {'key': 'value'},
      ),
    );

    final response = await mockApiManager.request(
      '/test-endpoint',
      {},
      RequestType.get,
      useToken: false,
    );

    expect(response.success, true);
    expect(response.message, 'Success');
    expect(response.data, {'key': 'value'});
  });

  test('Failed API Call', () async {
    when(
      mockApiManager.request(
        '/error-endpoint',
        {},
        RequestType.get,
        useToken: false,
      ),
    ).thenAnswer(
      (_) async => ApiResponse(message: 'Error', success: false, data: null),
    );

    final response = await mockApiManager.request(
      '/error-endpoint',
      {},
      RequestType.get,
      useToken: false,
    );

    expect(response.success, false);
    expect(response.message, 'Error');
    expect(response.data, null);
  });
}
