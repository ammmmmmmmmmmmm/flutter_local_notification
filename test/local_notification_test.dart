import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_notification/local_notification.dart';

void main() {
  const MethodChannel channel = MethodChannel('local_notification');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await LocalNotification.platformVersion, '42');
  });
}
