🎯 PL/SQL’de Exception Handling (Hata Yönetimi)

PL/SQL'de hata yönetimi (Exception Handling), programın beklenmeyen durumlarda çalışmaya devam edebilmesini sağlamak için kullanılır. EXCEPTION bloğu kullanılarak hatalar yakalanır ve uygun işlemler yapılabilir.
🚀 PL/SQL Exception Yapısı

PL/SQL’de hata yönetimi şu üç ana blok içinde yer alır:

BEGIN
    -- Normal kodlar
EXCEPTION
    WHEN <istisna_adı> THEN
        -- Hata durumunda yapılacak işlemler
END;

✅ 1. NO_DATA_FOUND Örneği

SELECT INTO komutu veri bulamazsa NO_DATA_FOUND hatası oluşur.

DECLARE
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = 9999; -- Çalışan yok!
    DBMS_OUTPUT.PUT_LINE('Çalışanın maaşı: ' || v_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Bu çalışan bulunamadı!');
END;
/

📌 Çalıştırma Sonucu:
Hata: Bu çalışan bulunamadı!

✅ 2. TOO_MANY_ROWS Örneği

Eğer SELECT INTO sorgusu birden fazla satır döndürürse, TOO_MANY_ROWS hatası meydana gelir.

DECLARE
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE department_id = 10; -- Birden fazla kişi olabilir!
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Birden fazla çalışan bulundu, lütfen sorguyu daraltın!');
END;
/

📌 Çalıştırma Sonucu:
Hata: Birden fazla çalışan bulundu, lütfen sorguyu daraltın!

✅ 3. ZERO_DIVIDE Örneği

Bir sayıyı sıfıra bölerseniz, ZERO_DIVIDE hatası oluşur.

DECLARE
    v_result NUMBER;
BEGIN
    v_result := 10 / 0;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Bir sayı sıfıra bölünemez!');
END;
/

📌 Çalıştırma Sonucu:
Hata: Bir sayı sıfıra bölünemez!

✅ 4. OTHERS ile Tüm Hataları Yakalama

Tüm diğer hatalar için WHEN OTHERS THEN kullanılabilir.

DECLARE
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = 9999;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Kayıt bulunamadı!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Birden fazla satır döndü!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Genel Hata: ' || SQLERRM);
END;
/

📌 SQLERRM: Hata mesajını döndürür.
🔥 Özel Exception Tanımlama

Eğer kendi özel hata yönetimini oluşturmak isterseniz EXCEPTION tanımlayıp RAISE ile hata fırlatabilirsiniz.

DECLARE
    v_salary NUMBER;
    salary_not_found EXCEPTION; -- Özel hata tanımlandı
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = 9999;

    IF v_salary IS NULL THEN
        RAISE salary_not_found; -- Hata fırlatılıyor
    END IF;
EXCEPTION
    WHEN salary_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Özel Hata: Maaş bilgisi bulunamadı!');
END;
/

📌 Çalıştırma Sonucu:
Özel Hata: Maaş bilgisi bulunamadı!

🎯 Özet
📌 Exception handling, PL/SQL’de programın hatalar karşısında çökmemesi ve uygun aksiyonların alınması için oldukça önemlidir.
