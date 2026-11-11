/// Kumpulan fungsi validasi dan sanitasi input.
class Validators {
  /// Memvalidasi format email.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  /// Memvalidasi bahwa value tidak kosong.
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memvalidasi panjang value.
  static bool hasValidLength(
    String value, {
    int min = 1,
    int max = 100,
  }) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Membersihkan input dari karakter berbahaya.
  static String sanitize(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .trim();
  }

  /// Memvalidasi input teks.
  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }

    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }

    return null;
  }

  /// Memvalidasi email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!isValidEmail(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // ==========================================
  // LATIHAN 3: VALIDASI TAMBAHAN
  // ==========================================

  /// Memvalidasi nomor telepon (10-13 digit).
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final regex = RegExp(r'^\d{10,13}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Nomor telepon harus 10-13 digit angka';
    }

    return null;
  }

  /// Memvalidasi URL.
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }

    final regex = RegExp(r'^https?://');

    if (!regex.hasMatch(value.trim())) {
      return 'URL harus diawali http:// atau https://';
    }

    return null;
  }

  /// Memvalidasi password.
  /// Minimal 8 karakter, huruf kapital, angka, dan simbol.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9\s]).{8,}$',
    );

    if (!regex.hasMatch(value)) {
      return 'Password minimal 8 karakter dan harus mengandung '
          'huruf kapital, angka, dan simbol';
    }

    return null;
  }
}