import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

import '../views/IBiometricView.dart';

class BiometricPresenter {
  final IBiometricView _view;
  final LocalAuthentication _auth = LocalAuthentication();

  BiometricPresenter(this._view);

  Future<void> authenticateUser() async {
    try {
      final bool canCheckBiometrics =
          await _auth.canCheckBiometrics;

      final bool isDeviceSupported =
          await _auth.isDeviceSupported();

      if (!canCheckBiometrics && !isDeviceSupported) {
        _view.onBiometricFailure(
          "قفل امنیتی یا بیومتریک روی این دستگاه تنظیم نشده است.",
        );
        return;
      }

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason:
            'لطفاً برای ورود به بخش حساس بانکی، هویت خود را تایید کنید',

        biometricOnly: false,

        persistAcrossBackgrounding: true,

        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'تایید هویت بیومتریک',
            cancelButton: 'انصراف',
          ),
        ],
      );

      if (didAuthenticate) {
        _view.onBiometricSuccess();
      } else {
        _view.onBiometricFailure(
          "احراز هویت ناموفق بود.",
        );
      }
    } on LocalAuthException catch (e) {
      _view.onBiometricFailure(
        "خطای احراز هویت: ${e.code}",
      );
    } catch (e) {
      _view.onBiometricFailure(
        "خطای ناشناخته: $e",
      );
    }
  }
}

