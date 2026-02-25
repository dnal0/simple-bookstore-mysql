# Inlämning 1 – Databaser

## Översikt
En komplett relationsdatabas för en liten svensk bokhandel. Databasen hanterar kunder, böcker, beställningar och orderrader med realistiska relationer och svenska tecken (åäö).


## Designval och motiveringar

## Tabeller och primärnycklar
- **Kunder** -> KundID (AUTO_INCREMENT)
- **Böcker** -> ISBN
- **Beställningar** -> Ordernummer (AUTO_INCREMENT)
- **Orderrader** -> sammansatt PK (Ordernummer + ISBN) -> löser M:N-relationen mellan beställningar och böcker

## Främmande nycklar och raderingsstrategi
- KundID i Beställningar -> *ON DELETE CASCADE* (tar bort kundens ordrar vid GDPR-radering)
- Ordernummer i Orderrader -> *ON DELETE CASCADE* (rensar automatiskt vid borttagen order)
- ISBN i Orderrader → *ON DELETE RESTRICT* (förhindrar radering av sålda böcker -> bevarar historik)

## Övriga val
- DECIMAL(10,2) för pris -> exakta belopp
- UNIQUE på e-post -> förhindrar dubbla konton
- DEFAULT 0 på Lager och DEFAULT 1 på Antal -> förenklar INSERT
- Databasen skapad med *utf8mb4_swedish_ci* -> fullt stöd för åäö och korrekt sortering
- Alla tabell- och kolumnnamn på svenska (Böcker, Författare, Beställningar)

## Totalsumma (medvetet denormaliserad)
Kolumnerna Totalsumma lagras för prestanda och historik.
I en produktionsmiljö sätter man värdet av applikationen eller en trigger.

<img width="274" height="213" alt="ER-diagram" src="https://github.com/user-attachments/assets/2a64c1fb-ff99-4496-b223-7c2b7fdd4596" />


