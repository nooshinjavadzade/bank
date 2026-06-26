import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_protector/screen_protector.dart';

import '../models/card_model.dart';
import '../presenter/home_presenter.dart';
import '../services/auth_service.dart';
import '../views/Ihome_view.dart';
import '../widgets/bank_card_widget.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements IHomeView {
  late final HomePresenter _presenter;

  List<BankCardModel> _cards = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _presenter = HomePresenter(this);

    _presenter.loadUserCards();

    _enableScreenProtection();
  }

  Future<void> _enableScreenProtection() async {
    try {
      await ScreenProtector.preventScreenshotOn();
    } catch (_) {}
  }

  Future<void> _disableScreenProtection() async {
    try {
      await ScreenProtector.preventScreenshotOff();
    } catch (_) {}
  }

  @override
  void dispose() {
    _disableScreenProtection();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    final authService = AuthService();

    await authService.logout();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("خروج امن با موفقیت انجام شد"),
        backgroundColor: Color(0xFF516161),
      ),
    );

    context.go('/login');
  }

  @override
  void onCardsLoaded(List<BankCardModel> cards) {
    if (!mounted) return;

    setState(() {
      _cards = cards;
      _isLoading = false;
    });
  }

  @override
  void onError(String message) {
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: "خروج امن",
            icon: const Icon(
              Icons.logout,
              color: Color(0xFFBA1A1A),
            ),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF70585B),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: _cards.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 24),
                          child: BankCardWidget(
                            card: _cards[index],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}