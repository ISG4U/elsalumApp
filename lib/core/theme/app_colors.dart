import 'package:flutter/material.dart';

/// Centralized color palette matching the Odoo UI design system.
class AppColors {
  AppColors._();

  // ── Brand / Primary ────────────────────────────────────────────────────────
  /// App dark primary (matches existing theme 0xFF1A100B)
  static const Color primary = Color(0xFF1A100B);

  /// Odoo brand purple – used as accent / FAB
  static const Color odooPurple = Color(0xFF714B67);

  /// Odoo teal – used for "new" status indicator
  static const Color odooTeal = Color(0xFF017E84);

  /// Odoo success green – used for "uploaded" status indicator
  static const Color odooSuccess = Color(0xFF28A745);

  /// Odoo warning amber
  static const Color odooWarning = Color(0xFFFFC107);

  /// Odoo error red
  static const Color odooError = Color(0xFFDC3545);

  // ── Surfaces ───────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Status chips ───────────────────────────────────────────────────────────
  static const Color statusNew = odooTeal;
  static const Color statusUploaded = odooSuccess;

  // ── Action ─────────────────────────────────────────────────────────────────
  static const Color fabColor = odooPurple;
}
