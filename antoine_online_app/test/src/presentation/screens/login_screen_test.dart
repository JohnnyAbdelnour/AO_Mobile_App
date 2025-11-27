import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:antoine_online_app/src/presentation/screens/auth/login_screen.dart';
import 'package:antoine_online_app/src/presentation/providers/auth/auth_providers.dart';
import 'package:antoine_online_app/src/domain/usecases/auth/login_use_case.dart';
import 'package:antoine_online_app/src/data/models/auth/login_request.dart';
import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  testWidgets('LoginScreen test', (WidgetTester tester) async {
    when(mockLoginUseCase.call(any)).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Verify that the widgets are on the screen.
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Test form validation.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Test successful login.
    const email = 'test@test.com';
    const password = 'password';
    await tester.enterText(find.byType(TextFormField).first, email);
    await tester.enterText(find.byType(TextFormField).last, password);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(mockLoginUseCase.call(argThat(isA<LoginRequest>()))).called(1);
  });
}
