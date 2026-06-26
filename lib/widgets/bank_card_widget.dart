import 'package:flutter/material.dart';
import '../models/card_model.dart';

class BankCardWidget extends StatelessWidget {
  final BankCardModel card;

  const BankCardWidget({required this.card, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.58 / 1,
      child: Container(
        decoration: BoxDecoration(
          color: Color(card.backgroundColorHex),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(112, 88, 91, 0.1),
              blurRadius: 40,
              offset: Offset(0, 20),
            )
          ],
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ردیف بالایی کارت
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.bankName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF70585b),
                      ),
                    ),
                    const Text(
                      "CREDIT CARD",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF70585b),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.contactless, color: Color(0xFF70585b)),
              ],
            ),
            
            // ردیف وسط و پایینی کارت
            Column(
              children: [
                Text(
                  card.cardNumber,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF70585b),
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                // بخش شیشه‌ای (Glassmorphic Container) طبق ساختار کدهای تلویند شما
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn("صاحب کارت", card.holderName, CrossAxisAlignment.start),
                      _buildInfoColumn("EXP", card.expireDate, CrossAxisAlignment.center),
                      _buildInfoColumn("CVV2", card.cvv2, CrossAxisAlignment.end),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF70585b)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1a1c1c)),
        ),
      ],
    );
  }
}
