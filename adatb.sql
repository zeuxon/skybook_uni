CREATE TABLE Repuloter (
    repuloter_id NUMBER(5) PRIMARY KEY,
    nev VARCHAR(255) NOT NULL,
    varos VARCHAR(255) NOT NULL,
    orszag VARCHAR(255) NOT NULL
);

CREATE TABLE Felhasznalo (
    felhasznalo_id NUMBER(5) PRIMARY KEY,
    nev VARCHAR(255) NOT NULL,
    admin NUMBER(1) DEFAULT 0,
    jelszo VARCHAR(255) NOT NULL,
    felhasznalonev VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefonszam NUMBER(20),
    iranyitoszam NUMBER(4),
    telepules VARCHAR(100)
);

CREATE TABLE Ut (
    ut_id NUMBER PRIMARY KEY,
    indulasi_repuloter_id NUMBER(5) NOT NULL,
    erkezesi_repuloter_id NUMBER(5) NOT NULL,
    FOREIGN KEY (indulasi_repuloter_id) REFERENCES Repuloter(repuloter_id) ON DELETE CASCADE,
    FOREIGN KEY (erkezesi_repuloter_id) REFERENCES Repuloter(repuloter_id) ON DELETE CASCADE
);

CREATE TABLE Legitarsasag (
    legitarsasag_id NUMBER(5) PRIMARY KEY,
    nev VARCHAR(255) NOT NULL,
    szekhely VARCHAR(255) NOT NULL,
    orszag VARCHAR(100) NOT NULL
);

CREATE TABLE Repulogep (
    repulogep_id NUMBER(5) PRIMARY KEY,
    legitarsasag_id NUMBER(5) NOT NULL,
    kapacitas NUMBER(3) NOT NULL,
    tipus VARCHAR(255) NOT NULL,
    etkezes NUMBER(1) DEFAULT 0,
    FOREIGN KEY (legitarsasag_id) REFERENCES Legitarsasag(legitarsasag_id) ON DELETE CASCADE
);

CREATE TABLE Repulojarat (
    jaratid NUMBER(5) PRIMARY KEY,
    repulogep_id NUMBER(5) NOT NULL,
    ut_id NUMBER(5) NOT NULL,
    indulasi_ido DATE NOT NULL,
    erkezesi_ido DATE NOT NULL,
    FOREIGN KEY (repulogep_id) REFERENCES Repulogep(repulogep_id) ON DELETE CASCADE,
    FOREIGN KEY (ut_id) REFERENCES Ut(ut_id) ON DELETE CASCADE
);

CREATE TABLE Pontgyujtes (
    pontgyujtes_id NUMBER(5) PRIMARY KEY,
    felhasznalo_id NUMBER(5) NOT NULL,
    osszeg NUMBER(5) NOT NULL,
    FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(felhasznalo_id) ON DELETE CASCADE
);

CREATE TABLE Biztositas (
    biztositas_id NUMBER(5) PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    ar NUMBER(10) NOT NULL
);

CREATE TABLE Jegykategoria (
    jegykategoria_id NUMBER(5) PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    kedvezmeny_szazalek NUMBER(5) NOT NULL
);

CREATE TABLE Jegy (
    jegy_id NUMBER(5) PRIMARY KEY,
    jarat_id NUMBER(5) NOT NULL,
    jegykategoria_id NUMBER(5) NOT NULL,
    ar NUMBER(10) NOT NULL,
    foglalva NUMBER(1) DEFAULT 0,
    FOREIGN KEY (jarat_id) REFERENCES Repulojarat(jaratid) ON DELETE CASCADE,
    FOREIGN KEY (jegykategoria_id) REFERENCES Jegykategoria(jegykategoria_id) ON DELETE CASCADE
);

CREATE TABLE Foglalas (
    foglalas_id NUMBER(5) PRIMARY KEY,
    felhasznalo_id NUMBER(5) NOT NULL,
    jegy_id NUMBER(5) NOT NULL,
    datum DATE NOT NULL,
    statusz VARCHAR(50) NOT NULL,
    sor NUMBER(5),
    oszlop NUMBER(5),
    biztositas_id NUMBER(5),
    FOREIGN KEY (biztositas_id) REFERENCES Biztositas(biztositas_id) ON DELETE CASCADE,
    FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(felhasznalo_id) ON DELETE CASCADE,
    FOREIGN KEY (jegy_id) REFERENCES Jegy(jegy_id) ON DELETE CASCADE
);

CREATE TABLE Jarat_valtozas_log (
    jaratid NUMBER(5) PRIMARY KEY,
    jarat_valtozas VARCHAR(4000) DEFAULT 'Nincs változás a lefoglat járatokon!'
);

INSERT INTO Repuloter VALUES (1, 'Liszt Ferenc Nemzetközi Repülőtér', 'Budapest', 'Magyarország');
INSERT INTO Repuloter VALUES (2, 'Heathrow', 'London', 'Egyesült Királyság');
INSERT INTO Repuloter VALUES (3, 'Charles de Gaulle', 'Párizs', 'Franciaország');
INSERT INTO Repuloter VALUES (4, 'JFK', 'New York', 'USA');
INSERT INTO Repuloter VALUES (5, 'Schiphol', 'Amszterdam', 'Hollandia');

INSERT INTO Felhasznalo VALUES (1, 'Kiss Péter', 0, 'jelszo123', 'kisspeter', 'kiss.peter@example.com', 36201234567, 1011, 'Budapest');
INSERT INTO Felhasznalo VALUES (2, 'Nagy Anna', 1, 'admin123', 'nagyan', 'nagy.anna@example.com', 36209876543, 1024, 'Budapest');
INSERT INTO Felhasznalo VALUES (3, 'Tóth Gábor', 0, 'titkos123', 'tothg', 'toth.gabor@example.com', 36205551234, 6000, 'Kecskemét');
INSERT INTO Felhasznalo VALUES (4, 'Szabó Erika', 0, 'password', 'szaboerika', 'szabo.erika@example.com', 36207778899, 4026, 'Debrecen');
INSERT INTO Felhasznalo VALUES (5, 'Varga László', 0, 'laszlo123', 'vargalaszlo', 'varga.laszlo@example.com', 36203334455, 6720, 'Szeged');

INSERT INTO Ut VALUES (1, 1, 2);
INSERT INTO Ut VALUES (2, 2, 3);
INSERT INTO Ut VALUES (3, 3, 4);
INSERT INTO Ut VALUES (4, 4, 5);
INSERT INTO Ut VALUES (5, 5, 1);

INSERT INTO Legitarsasag VALUES (1, 'Wizz Air', 'Budapest', 'Magyarország');
INSERT INTO Legitarsasag VALUES (2, 'British Airways', 'London', 'Egyesült Királyság');
INSERT INTO Legitarsasag VALUES (3, 'Air France', 'Párizs', 'Franciaország');
INSERT INTO Legitarsasag VALUES (4, 'Delta Airlines', 'Atlanta', 'USA');
INSERT INTO Legitarsasag VALUES (5, 'KLM', 'Amszterdam', 'Hollandia');

INSERT INTO Repulogep VALUES (1, 1, 180, 'Airbus A320', 1);
INSERT INTO Repulogep VALUES (2, 2, 200, 'Boeing 737', 1);
INSERT INTO Repulogep VALUES (3, 3, 250, 'Airbus A330', 0);
INSERT INTO Repulogep VALUES (4, 4, 300, 'Boeing 777', 0);
INSERT INTO Repulogep VALUES (5, 5, 220, 'Embraer E190', 1);

INSERT INTO Repulojarat VALUES (1, 1, 1, DATE '2025-03-25', DATE '2025-03-25');
INSERT INTO Repulojarat VALUES (2, 2, 2, DATE '2025-03-26', DATE '2025-03-26');
INSERT INTO Repulojarat VALUES (3, 3, 3, DATE '2025-03-27', DATE '2025-03-27');
INSERT INTO Repulojarat VALUES (4, 4, 4, DATE '2025-03-28', DATE '2025-03-28');
INSERT INTO Repulojarat VALUES (5, 5, 5, DATE '2025-03-29', DATE '2025-03-29');

INSERT INTO Pontgyujtes VALUES (1, 1, 500);
INSERT INTO Pontgyujtes VALUES (2, 2, 1000);
INSERT INTO Pontgyujtes VALUES (3, 3, 750);
INSERT INTO Pontgyujtes VALUES (4, 4, 300);
INSERT INTO Pontgyujtes VALUES (5, 5, 1200);

INSERT INTO Biztositas VALUES (1, 'Alap biztosítás', 5000);
INSERT INTO Biztositas VALUES (2, 'Utazási biztosítás', 10000);
INSERT INTO Biztositas VALUES (3, 'Prémium biztosítás', 15000);
INSERT INTO Biztositas VALUES (4, 'Családi biztosítás', 20000);
INSERT INTO Biztositas VALUES (5, 'Diák biztosítás', 3000);

INSERT INTO Jegykategoria VALUES (1, 'Economy', 0);
INSERT INTO Jegykategoria VALUES (2, 'Premium Economy', 10);
INSERT INTO Jegykategoria VALUES (3, 'Business', 20);
INSERT INTO Jegykategoria VALUES (4, 'First Class', 30);
INSERT INTO Jegykategoria VALUES (5, 'Diák kedvezmény', 15);

INSERT INTO Jegy VALUES (1, 1, 1, 20000, 0);
INSERT INTO Jegy VALUES (2, 2, 2, 30000, 0);
INSERT INTO Jegy VALUES (3, 3, 3, 50000, 0);
INSERT INTO Jegy VALUES (4, 4, 4, 70000, 0);
INSERT INTO Jegy VALUES (5, 5, 5, 15000, 0);

INSERT INTO Foglalas VALUES (1, 1, 1, DATE '2025-03-20', 'Fizetett', 1, 1, 1);
INSERT INTO Foglalas VALUES (2, 2, 2, DATE '2025-03-21', 'Fizetett', 1, 1, 1);
INSERT INTO Foglalas VALUES (3, 3, 3, DATE '2025-03-22', 'Függőben', 1, 1, 1);
INSERT INTO Foglalas VALUES (4, 4, 4, DATE '2025-03-23', 'Fizetett', 1, 1, 1);
INSERT INTO Foglalas VALUES (5, 5, 5, DATE '2025-03-24', 'Törölve', 1, 1, 1);

BEGIN
    FOR i IN 6..15 LOOP
        INSERT INTO Repuloter VALUES (
            i,
            'Repülőtér ' || i,
            'Város ' || i,
            'Ország ' || i
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 6..15 LOOP
        INSERT INTO Ut VALUES (
            i,
            MOD(i,10)+1,
            MOD(i+1,10)+1
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 6..15 LOOP
        INSERT INTO Legitarsasag VALUES (
            i,
            'Legitársaság ' || i,
            'Város ' || i,
            'Ország ' || i
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 6..15 LOOP
        INSERT INTO Repulogep VALUES (
            i,
            MOD(i,15)+1,
            150 + (i*10),
            'Típus ' || i,
            MOD(i,2)
        );
    END LOOP;
END;
/


BEGIN
    FOR i IN 6..35 LOOP
        INSERT INTO Repulojarat VALUES (
            i,
            MOD(i,15)+1,
            MOD(i,15)+1,
            DATE '2025-04-01' + (i-6),
            DATE '2025-04-01' + (i-6)
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 6..15 LOOP
        INSERT INTO Pontgyujtes VALUES (
            i,
            MOD(i,5)+1,
            1000 + (i*100)
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 6..25 LOOP
        INSERT INTO Biztositas VALUES (
            i,
            'Extra biztosítás ' || i,
            3000 + (i*500)
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 6..15 LOOP
        INSERT INTO Jegykategoria VALUES (
            i,
            'Speciális kategória ' || i,
            MOD(i,30)
        );
    END LOOP;
END;
/


BEGIN
    FOR i IN 6..135 LOOP
        INSERT INTO Jegy VALUES (
            i,
            MOD(i,35)+1,
            MOD(i,15)+1,
            8000 + MOD(i*123, 40000),
            0
        );
    END LOOP;
END;
/