import 'package:flutter_test/flutter_test.dart';
import '../../lib/utils/validators.dart';

void main() {
  group('Validators Unit Test', () {

    // =====================================
    // A. TEST EMAIL
    // =====================================

    group('isValidEmail()', () {
      test('Email valid', () {
        expect(Validators.isValidEmail('user@gmail.com'), true);
      });

      test('Email tanpa @', () {
        expect(Validators.isValidEmail('usergmail.com'), false);
      });

      test('Email tanpa domain', () {
        expect(Validators.isValidEmail('user@'), false);
      });

      test('Email tanpa ekstensi domain', () {
        expect(Validators.isValidEmail('user@gmail'), false);
      });
    });

    // =====================================
    // B. TEST SANITIZE
    // =====================================

    group('sanitize()', () {
      test('Membersihkan karakter HTML berbahaya', () {
        final result = Validators.sanitize(
          '<script>alert("XSS")</script>',
        );

        expect(
          result,
          '&lt;script&gt;alert(&quot;XSS&quot;)&lt;/script&gt;',
        );
      });

      test('Membersihkan karakter khusus', () {
        final result = Validators.sanitize(
          'Tom & Jerry <test>',
        );

        expect(
          result,
          'Tom &amp; Jerry &lt;test&gt;',
        );
      });

      test('Membersihkan tanda petik satu', () {
        final result = Validators.sanitize("It's dangerous");

        expect(result, 'It&#x27;s dangerous');
      });
    });

    // =====================================
    // C. TEST VALIDATE TEXT
    // =====================================

    group('validateText()', () {
      test('Teks valid', () {
        expect(Validators.validateText('Hello'), null);
      });

      test('Teks kosong', () {
        expect(
          Validators.validateText(''),
          'Field tidak boleh kosong',
        );
      });

      test('Teks terlalu pendek', () {
        expect(
          Validators.validateText('AB', minLength: 3),
          'Field harus antara 3-100 karakter',
        );
      });

      test('Teks terlalu panjang', () {
        final text = List.filled(101, 'A').join();

        expect(
          Validators.validateText(text),
          'Field harus antara 1-100 karakter',
        );
      });

      test('Teks sesuai batas minimum', () {
        expect(
          Validators.validateText('ABC', minLength: 3),
          null,
        );
      });

      test('Teks sesuai batas maksimum', () {
        final text = List.filled(100, 'A').join();

        expect(
          Validators.validateText(text, maxLength: 100),
          null,
        );
      });
    });
  });
}