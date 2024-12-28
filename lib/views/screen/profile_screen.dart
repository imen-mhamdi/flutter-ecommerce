import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/Login%20Signup/Screen/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la déconnexion : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Section Account
          const SectionTitle(title: "Account"),
          const ProfileOption(
            icon: Icons.shopping_bag_outlined,
            title: "Orders",
          ),
          const ProfileOption(
            icon: Icons.undo_outlined,
            title: "Returns",
          ),
          const ProfileOption(
            icon: Icons.favorite_outline,
            title: "Wishlist",
          ),
          const ProfileOption(
            icon: Icons.location_on_outlined,
            title: "Addresses",
          ),
          const ProfileOption(
            icon: Icons.payment_outlined,
            title: "Payment",
          ),
          const ProfileOption(
            icon: Icons.account_balance_wallet_outlined,
            title: "Wallet",
          ),

          const SectionTitle(title: "Personalization"),
          const ProfileOption(
            icon: Icons.notifications_outlined,
            title: "Notification",
            trailing: Text(
              "off",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const ProfileOption(
            icon: Icons.tune_outlined,
            title: "Preferences",
          ),

          const SectionTitle(title: "Settings"),
          const ProfileOption(
            icon: Icons.language_outlined,
            title: "Language",
          ),
          const ProfileOption(
            icon: Icons.location_on_outlined,
            title: "Location",
          ),

          const SectionTitle(title: "Help & Support"),
          const ProfileOption(
            icon: Icons.help_outline,
            title: "Get Help",
          ),
          const ProfileOption(
            icon: Icons.question_answer_outlined,
            title: "FAQ",
          ),

          const Divider(),
          ProfileOption(
            icon: Icons.logout,
            title: "Log Out",
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? Colors.black,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
