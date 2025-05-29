CREATE DATABASE IF NOT EXISTS diyet_takip;
USE diyet_takip;

CREATE TABLE diyetisyen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefon VARCHAR(20),
    sifre VARCHAR(100) NOT NULL
);

CREATE TABLE musteri (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefon VARCHAR(20),
    dogum_tarihi DATE,
    cinsiyet ENUM('Erkek','Kadın'),
    boy_cm INT,
    kilo_kg FLOAT,
    diyetisyen_id INT,
    FOREIGN KEY (diyetisyen_id) REFERENCES diyetisyen(id)
       
);

CREATE TABLE diyet_plani (
    id INT AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT NOT NULL,
    baslangic_tarihi DATE NOT NULL,
    bitis_tarihi DATE,
    aciklama TEXT,
    FOREIGN KEY (musteri_id) REFERENCES musteri(id)
       
);

CREATE TABLE ogun (
    id INT AUTO_INCREMENT PRIMARY KEY,
    diyet_plani_id INT NOT NULL,
    tarih DATE NOT NULL,
    ogun_turu ENUM('Kahvaltı','Öğle','Akşam','Ara Öğün') NOT NULL,
    icerik TEXT,
    kalori INT,
    FOREIGN KEY (diyet_plani_id) REFERENCES diyet_plani(id)
        
);

CREATE TABLE olcumler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT NOT NULL,
    tarih DATE NOT NULL,
    kilo_kg FLOAT,
    yag_orani FLOAT,
    kas_orani FLOAT,
    FOREIGN KEY (musteri_id) REFERENCES musteri(id)
       
);

CREATE TABLE geribildirim (
    id INT AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT NOT NULL,
    diyetisyen_id INT NOT NULL,
    tarih DATE NOT NULL,
    yorum TEXT,
    FOREIGN KEY (musteri_id) REFERENCES musteri(id)
        
    FOREIGN KEY (diyetisyen_id) REFERENCES diyetisyen(id)
        
);

CREATE TABLE log_kayitlari (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mesaj TEXT NOT NULL,
    zaman DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

USE diyet_takip;

INSERT INTO diyetisyen (ad, soyad, email, telefon, sifre) VALUES
('Sultan', 'tekercioglu', 'sultan.tkrcglu@example.com', '05551234567', 'sifre123'),
('Esranur', 'sürücü', 'esra.src@example.com', '05559876543', 'sifre456'),
('Ferat', 'kılın', 'ferat.kln@example.com', '05557654321', 'sifre789');

INSERT INTO musteri (ad, soyad, email, telefon, dogum_tarihi, cinsiyet, boy_cm, kilo_kg, diyetisyen_id) VALUES
('İsmail', 'aksan', 'ismail.aksn@example.com', '05321234567', '1985-03-20', 'Erkek', 175, 80.5, 1),
('Emirhan', 'emir', 'emirhan.emr@example.com', '05329876543', '1992-11-15', 'Erkek', 180, 75.0, 2),
('Ayşe', 'Kara', 'ayse.kara@example.com', '05328765432', '1990-07-05', 'Kadın', 165, 65.0, 1),
('Murat', 'Şahin', 'murat.sahin@example.com', '05327654321', '1988-01-12', 'Erkek', 170, 78.0, 3),
('Fatma', 'Yıldız', 'fatma.yildiz@example.com', '05326543210', '1995-09-25', 'Kadın', 160, 62.0, 2);

INSERT INTO diyet_plani (musteri_id, baslangic_tarihi, bitis_tarihi, aciklama) VALUES
(1, '2025-05-01', '2025-06-01', 'Kilo verme programı, düşük karbonhidrat.'),
(2, '2025-04-15', '2025-05-15', 'Kas kazanımı için protein ağırlıklı.'),
(3, '2025-05-10', '2025-06-10', 'Dengeli diyet, ara öğünlerle destekli.'),
(4, '2025-03-20', '2025-04-20', 'Yağ oranını azaltmaya yönelik.'),
(5, '2025-05-05', '2025-06-05', 'Enerji artırıcı ve hafif diyet.');

INSERT INTO ogun (diyet_plani_id, tarih, ogun_turu, icerik, kalori) VALUES
(1, '2025-05-02', 'Kahvaltı', 'Yumurta, tam buğday ekmeği, yeşillik', 350),
(1, '2025-05-02', 'Öğle', 'Izgara tavuk, sebze yemeği, salata', 550),
(2, '2025-04-16', 'Akşam', 'Izgara somon, brokoli, kinoa', 600),
(3, '2025-05-11', 'Ara Öğün', 'Badem ve yoğurt', 200),
(4, '2025-03-21', 'Öğle', 'Mercimek çorbası, tam buğday ekmeği', 400),
(5, '2025-05-06', 'Kahvaltı', 'Yulaf ezmesi, süt, meyve', 300);

INSERT INTO olcumler (musteri_id, tarih, kilo_kg, yag_orani, kas_orani) VALUES
(1, '2025-05-01', 80.5, 25.0, 30.0),
(1, '2025-05-15', 78.0, 23.5, 31.0),
(2, '2025-04-15', 75.0, 20.0, 35.0),
(3, '2025-05-10', 65.0, 22.0, 28.0),
(4, '2025-03-20', 78.0, 26.5, 29.0),
(5, '2025-05-05', 62.0, 24.0, 27.0);

INSERT INTO geribildirim (musteri_id, diyetisyen_id, tarih, yorum) VALUES
(1, 1, '2025-05-15', 'Program çok faydalı oldu, teşekkür ederim.'),
(2, 2, '2025-04-30', 'Kas kütlesinde artış gözlemledim.'),
(3, 1, '2025-05-20', 'Diyet programı dengeliydi, ara öğünler iyi geldi.'),
(4, 3, '2025-04-01', 'Yağ oranımda azalma başladı.'),
(5, 2, '2025-05-20', 'Enerji seviyem arttı, öneriler için teşekkürler.');

INSERT INTO log_kayitlari (mesaj, zaman) VALUES
('Sistem başlangıcı', '2025-05-01 08:00:00'),
('Yeni müşteri kaydı: İsmail aksan', '2025-05-01 09:00:00'),
('Diyet planı oluşturuldu: ID 1', '2025-05-01 09:30:00'),
('Ölçüm eklendi: İsmail aksan', '2025-05-15 08:00:00'),
('Geribildirim alındı: İsmail aksan', '2025-05-15 10:00:00'),
('Sistem kapanışı', '2025-05-29 18:00:00');

SELECT 
    m.ad AS musteri_ad,
    m.soyad AS musteri_soyad,
    d.ad AS diyetisyen_ad,
    d.soyad AS diyetisyen_soyad
FROM musteri m
JOIN diyetisyen d ON m.diyetisyen_id = d.id;

SELECT 
    m.ad, m.soyad, 
    dp.baslangic_tarihi, dp.bitis_tarihi,
    dp.aciklama
FROM diyet_plani dp
JOIN musteri m ON dp.musteri_id = m.id;

SELECT 
    o.tarih, o.kilo_kg, o.yag_orani, o.kas_orani
FROM olcumler o
JOIN musteri m ON o.musteri_id = m.id
WHERE m.ad = 'İsmail' AND m.soyad = 'aksan'
ORDER BY o.tarih;

SELECT 
    o.tarih, o.ogun_turu, o.icerik, o.kalori
FROM ogun o
JOIN diyet_plani dp ON o.diyet_plani_id = dp.id
JOIN musteri m ON dp.musteri_id = m.id
WHERE m.ad = 'Emirhan';

SELECT 
    g.tarih, m.ad AS musteri_ad, d.ad AS diyetisyen_ad, g.yorum
FROM geribildirim g
JOIN musteri m ON g.musteri_id = m.id
JOIN diyetisyen d ON g.diyetisyen_id = d.id
WHERE g.tarih >= CURDATE() - INTERVAL 30 DAY;

SELECT 
    d.ad, d.soyad, COUNT(m.id) AS musteri_sayisi
FROM diyetisyen d
LEFT JOIN musteri m ON d.id = m.diyetisyen_id
GROUP BY d.id;

SELECT * 
FROM log_kayitlari 
ORDER BY zaman DESC 
LIMIT 5;