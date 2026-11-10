import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('isValidEmail', () {
    test('email valid', () {
      expect(Validators.isValidEmail('user@example.com'), isTrue);
      expect(Validators.isValidEmail('a.b@mail.co.id'), isTrue);
    });

    test('email tanpa @', () {
      expect(Validators.isValidEmail('userexample.com'), isFalse);
    });

    test('email tanpa nama pengguna', () {
      expect(Validators.isValidEmail('@example.com'), isFalse);
    });

    test('email tanpa domain', () {
      expect(Validators.isValidEmail('user@'), isFalse);
    });

    test('email tanpa titik pada domain', () {
      expect(Validators.isValidEmail('user@example'), isFalse);
    });

    test('email dengan dua @', () {
      expect(Validators.isValidEmail('user@@example.com'), isFalse);
    });

    test('string kosong', () {
      expect(Validators.isValidEmail(''), isFalse);
    });
  });

  group('sanitize', () {
    test('mengganti tag script', () {
      expect(
        Validators.sanitize('<script>alert("x")</script>'),
        '&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt;',
      );
    });

    test('mengganti tanda kutip tunggal', () {
      expect(Validators.sanitize("O'Brien"), 'O&#x27;Brien');
    });

    test('menghapus spasi di awal dan akhir', () {
      expect(Validators.sanitize('  halo  '), 'halo');
    });

    test('teks biasa tidak berubah', () {
      expect(Validators.sanitize('Halo Dunia'), 'Halo Dunia');
    });
  });

  group('validateText', () {
    test('null dan kosong ditolak', () {
      expect(Validators.validateText(null), 'Field tidak boleh kosong');
      expect(Validators.validateText('   '), 'Field tidak boleh kosong');
    });

    test('terlalu pendek', () {
      expect(
        Validators.validateText('ab', fieldName: 'Nama', minLength: 3),
        'Nama harus antara 3-100 karakter',
      );
    });

    test('terlalu panjang', () {
      expect(
        Validators.validateText('a' * 101),
        'Field harus antara 1-100 karakter',
      );
    });

    test('panjang valid', () {
      expect(Validators.validateText('Budi'), isNull);
      expect(Validators.validateText('a' * 100), isNull);
    });
  });

  group('validatePhone', () {
    test('valid 10-13 digit', () {
      expect(Validators.validatePhone('0812345678'), isNull);
      expect(Validators.validatePhone('6281234567890'), isNull);
    });

    test('tidak valid', () {
      expect(Validators.validatePhone('12345'), isNotNull);
      expect(Validators.validatePhone('08123abc789'), isNotNull);
      expect(Validators.validatePhone('12345678901234'), isNotNull);
      expect(Validators.validatePhone(''), isNotNull);
    });
  });

  group('validateUrl', () {
    test('valid', () {
      expect(Validators.validateUrl('https://example.com'), isNull);
      expect(Validators.validateUrl('http://example.com/path'), isNull);
    });

    test('tidak valid', () {
      expect(Validators.validateUrl('example.com'), isNotNull);
      expect(Validators.validateUrl('ftp://example.com'), isNotNull);
      expect(Validators.validateUrl(''), isNotNull);
    });
  });

  group('validatePassword', () {
    test('valid', () {
      expect(Validators.validatePassword('Abcdef1!'), isNull);
    });

    test('terlalu pendek', () {
      expect(Validators.validatePassword('Ab1!'), isNotNull);
    });

    test('tanpa huruf kapital', () {
      expect(Validators.validatePassword('abcdef1!'), isNotNull);
    });

    test('tanpa angka', () {
      expect(Validators.validatePassword('Abcdefg!'), isNotNull);
    });

    test('tanpa simbol', () {
      expect(Validators.validatePassword('Abcdefg1'), isNotNull);
    });
  });
}
