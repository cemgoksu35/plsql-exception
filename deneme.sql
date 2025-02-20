BEGIN
    -- Normal kodlar
EXCEPTION
    WHEN <istisna_adı> THEN
        -- Hata durumunda yapılacak işlemler
END;


--

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

--

DECLARE
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE department_id = 10; -- Birden fazla kişi olabilir!
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Birden fazla çalışan bulundu, lütfen sorguyu daraltın!');
END;
/

--

DECLARE
    v_result NUMBER;
BEGIN
    v_result := 10 / 0;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Hata: Bir sayı sıfıra bölünemez!');
END;
/

--

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

--

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
