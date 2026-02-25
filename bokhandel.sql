/*  Martin Hellström YH25
	Inlämning 1 - Databaser
    Fil: inlamning1.sql 
    */
    
-- Raderar gammal databas om den finns plus skapar ny ren databas varje gång
DROP DATABASE IF EXISTS Bokhandel;
CREATE DATABASE Bokhandel CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci;
USE Bokhandel;

-- Skapar Kundtabell
CREATE TABLE Kunder (
    KundID INT PRIMARY KEY AUTO_INCREMENT,
    Namn VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefon VARCHAR(20),
    Adress VARCHAR(200) 
    );
    
-- Kontroll: Visa att tabellen har skapats korrekt
SELECT * FROM Kunder;
    
-- Skapar Boktabell
CREATE TABLE Böcker (
    ISBN VARCHAR(20) PRIMARY KEY,
    Titel VARCHAR(200) NOT NULL,
    Författare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL,
    Lager INT NOT NULL DEFAULT 0
    );
    
-- Kontroll: Visa att tabellen har skapats korrekt
SELECT * FROM Böcker;
    
-- Skapar Beställningstabell
CREATE TABLE Beställningar (
    Ordernummer INT PRIMARY KEY AUTO_INCREMENT,
    KundID INT NOT NULL,
    Datum DATE NOT NULL,
    Totalsumma DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) ON DELETE CASCADE
    );

-- Kontroll: Visa att tabellen har skapats korrekt
SELECT * FROM Beställningar;
    
-- Skapar Orderradstabell
CREATE TABLE Orderrader (
    Ordernummer INT NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    Antal INT NOT NULL DEFAULT 1,
    PRIMARY KEY (Ordernummer, ISBN),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN) ON DELETE RESTRICT,
    FOREIGN KEY (Ordernummer) REFERENCES Beställningar(Ordernummer) ON DELETE CASCADE
    );
    
    
-- Visar att alla tabeller är skapade med rätt kolumner, nycklar och datatyper
SHOW TABLES;
DESCRIBE Kunder; 
DESCRIBE Beställningar;
DESCRIBE Orderrader; 
DESCRIBE Böcker;

-- TESTDATA: 9 kunder
INSERT INTO Kunder (Namn, Email, Telefon, Adress) VALUES
('Anna Karlsson', 'Anna@mail.se', '0701234567', 'Storgatan 1, Kalmar'),
('Eric Svensson', 'Eric@mail.se', '0703214567', 'Kungsgatan 4, Stockholm'),
('Kalle Karlsson', 'Kalle@mail.se', '0701234765', 'Kalasgatan 7, Nybro'),
('Johannes Carlsson', 'Johannes@mail.se', '0704532567', 'Nygatan 14, Oskarshamn'),
('Filippa Fjord', 'Filippa@mail.se', '0731234567', 'Storgatan 11, Kalmar'),
('Kajsa Stigsson', 'Kajsa@mail.se', '0761234567', 'Havsgatan 5, Karlskrona'),
('Emma Jonsson', 'Emma@mail.se', '0721234567', 'Lokgatan 2, Stockholm'),
('Jonas Franzen', 'Jonas@mail.se', '0722234567', 'Torggatan 15, Halmstad'),
('Hannes Åfors', 'Hannes@mail.se', '0722224567', 'Pilgatan 22, Kalmar');

-- TESTDATA: 20 Böcker
INSERT INTO Böcker (ISBN, Titel, Författare, Pris, Lager) VALUES
('978-0161214722', 'Klenoden', 'Klas Östergren', 199.00, 12),
('978-0122533964', 'Julkalas Alfons Åberg', 'Gunilla Bergström', 179.00, 14),
('978-0141439600', 'A Tale of Two Cities', 'Charles Dickens', 349.00, 15),
('978-0156012195', '1984', 'George Orwell', 279.00, 20),
('978-0061120084', 'The Alchemist', 'Paulo Coelho', 329.00, 18),
('978-0747532699', 'Harry Potter and the Philosopher''s Stone', 'J. K. Rowling', 399.00, 25),
('978-0006479888', 'And Then There Were None', 'Agatha Christie', 349.00, 12),
('978-0140449266', 'Dream of the Red Chamber', 'Cao Xueqin', 229.00, 10),
('978-0140301694', 'The Hobbit', 'J. R. R. Tolkien', 429.00, 22),
('978-0140366990', 'Alice''s Adventures in Wonderland', 'Lewis Carroll', 329.00, 16),
('978-0140283297', 'She: A History of Adventure', 'H. Rider Haggard', 179.00, 14),
('978-0385504201', 'The Da Vinci Code', 'Dan Brown', 249.00, 19),
('978-0747538486', 'Harry Potter and the Chamber of Secrets', 'J. K. Rowling', 379.00, 21),
('978-0316769488', 'The Catcher in the Rye', 'J. D. Salinger', 279.00, 13),
('978-0747546245', 'Harry Potter and the Prisoner of Azkaban', 'J. K. Rowling', 329.00, 23),
('978-0747551003', 'Harry Potter and the Goblet of Fire', 'J. K. Rowling', 369.00, 24),
('978-0747591054', 'Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 379.00, 20),
('978-0747581086', 'Harry Potter and the Half-Blood Prince', 'J. K. Rowling', 349.00, 18),
('978-0545010221', 'Harry Potter and the Deathly Hallows', 'J. K. Rowling', 329.00, 26),
('978-0446518628', 'The Bridges of Madison County', 'Robert James Waller', 279.00, 11),
('978-0060975548', 'One Hundred Years of Solitude', 'Gabriel García Márquez', 329.00, 17),
('978-0140283334', 'Lolita', 'Vladimir Nabokov', 199.00, 15);

-- TESTDATA: Beställningar
-- Totalsumma är medvetet denormaliserad här för prestanda och historik
-- I produktion skulle värdet alltid sättas av applikationen eller trigger
INSERT INTO Beställningar (KundID, Datum, Totalsumma) VALUES 
(1, '2025-11-20', 977.00), 
(3, '2025-11-21', 987.00),  
(5, '2025-11-22', 399),
(7, '2025-11-23', 698.00),
(9, '2025-11-24', 916.00);

-- TESTDATA: Orderrader
INSERT INTO Orderrader (Ordernummer, ISBN, Antal) VALUES
(1, '978-0141439600', 2), 
(1, '978-0156012195', 1),  
(2, '978-0061120084', 3),  
(3, '978-0747532699', 1),
(4, '978-0006479888', 2),
(5, '978-0140449266', 4);

-- Visar grundläggande sökning och sortering
SELECT Namn, Telefon FROM Kunder;
SELECT * FROM Böcker WHERE Pris > 200;
SELECT * FROM Böcker ORDER BY Pris ASC;
SELECT * FROM Böcker ORDER BY PRIS DESC; 

-- Komplett order med kund och bok information
SELECT
	b.Ordernummer,
    b.Datum,
    k.Namn,
    b.Totalsumma AS Sparad_summa,
    SUM(o.Antal * bo.Pris) AS Beräknad_summa,
    round(b.Totalsumma - SUM(o.Antal * bo.Pris), 2) as Skillnad
FROM Beställningar b
JOIN Orderrader o ON b.Ordernummer = o.Ordernummer
JOIN Böcker bo ON o.ISBN = bo.ISBN
JOIN Kunder k ON b.KundID = k.KundID
GROUP BY b.Ordernummer, b.Datum, k.Namn, b.Totalsumma
ORDER BY b.Ordernummer; 


