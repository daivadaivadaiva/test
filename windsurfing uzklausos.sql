-- pasitikrinu kiekiviena stulpeli
SELECT * FROM instruktoriai;
SELECT * FROM iranga;
SELECT * FROM mokejimai;
SELECT * FROM mokiniai;
SELECT * FROM nuoma;
SELECT * FROM pamokos;
SELECT * FROM rezervacijos;
SHOW TABLES;

-- panaudoju round funkcija
SELECT 
    ROUND(SUM(mokejimo_suma) / COUNT(mokejimo_suma)) AS vidurkis_mokejimu
FROM
    mokejimai;
    
SELECT 
    ROUND(AVG(kaina), 2) AS vidutinė_kaina
FROM
    pamokos;
--

SELECT 
    vardas, pavarde, lygis
FROM
    mokiniai
ORDER BY CASE
    WHEN lygis = 'beginner' THEN 1
    WHEN lygis = 'intermediate' THEN 2
    WHEN lygis = 'advanced' THEN 3
END;

ALTER TABLE mokiniai #cia pakeiciu duomenu tipa registracijos_datai, nes datetime, rodo ir laika, todel negaunu atsakymu zemiau
MODIFY COLUMN registracijos_data DATE;

-- limit ir offset

SELECT 
    *
FROM
    mokiniai
ORDER BY registracijos_data
LIMIT 10 
OFFSET 20;

-- kitos uzklausos bus su where, taip pat bus panaudota ir order by 

SELECT 
    Vardas
FROM
    mokiniai
WHERE
    Vardas LIKE 'A%'
ORDER BY Vardas ASC;

SELECT 
    Vardas, pavarde
FROM
    mokiniai
WHERE
    Vardas LIKE 'J%' AND pavarde LIKE 'P%';


SELECT 
    Vardas, pavarde, gimimo_data
FROM
    mokiniai
WHERE
    gimimo_data >= '2000-01-01'
ORDER BY Vardas ASC;

-- subquery

SELECT 
    *
FROM
    pamokos
WHERE
    kaina > (SELECT 
            ROUND(AVG(kaina), 2)
        FROM
            pamokos);

-- group by, order by

SELECT 
    lygis, COUNT(*) AS mokiniu_lygiu_skaicius
FROM
    mokiniai
GROUP BY lygis
ORDER BY mokiniu_lygiu_skaicius DESC;

-- 

SELECT 
    ROUND(AVG(kaina), 2) AS vidutinė_kaina
FROM
    pamokos;

-- round, min , max, count
SELECT 
    ROUND(AVG(kaina), 2) AS vidutinė_kaina_pamokos,
    MIN(kaina) AS pigiausia_pamoka,
    MAX(kaina) AS brangiausia_pamoka
FROM
    pamokos;


SELECT 
    COUNT(*) AS rezervacijos_vasara
FROM
    rezervacijos
WHERE
    MONTH(uzsakymo_data) IN (6 , 7, 8);
    
-- Join

SELECT 
    m.vardas, m.pavarde, r.uzsakymo_data
FROM
    mokiniai m
        JOIN
    rezervacijos r ON m.idMokiniai = r.Mokiniai_id;

SELECT 
    CONCAT(i.Vardas, ' ', Pavarde) AS instruktoriaus_v_p,
    COUNT(p.idPamokos) AS pravestos_pamokos
FROM
    instruktoriai i
        JOIN
    Pamokos p ON i.idInstruktoriai = p.Instruktoriai_id
GROUP BY i.idInstruktoriai , instruktoriaus_v_p;

-- case
SELECT
    idPamokos,
    studentu_kiekis,
    CASE
        WHEN studentu_kiekis <=5  THEN 'Pamokoje yra vietos'
        ELSE 'Pamoka pilna'
    END AS Pamokos_vietu_patikrinimas
FROM
    Pamokos;
    
    SELECT 
    CASE
        WHEN bukle = 'new' THEN 'Nauja'
        WHEN bukle = 'good' THEN 'Gera'
        WHEN bukle = 'fair' THEN 'Patenkinama'
        WHEN bukle = 'damaged' THEN 'Sugadinta'
        ELSE 'Nežinoma'
    END AS ir_bukle,
    COUNT(*) AS kiekis
FROM
    iranga
GROUP BY ir_bukle;
-- if
SELECT 
    IF(bukle IN ('new' , 'good'),
        'Galima naudoti',
        'Reikia taisyti') AS kategorija,
    COUNT(*) AS kiekis
FROM
    iranga
GROUP BY kategorija;


-- HAVING

SELECT
    Irangos_tipas,
    COUNT(*) AS viso_irangos
FROM
    iranga
GROUP BY
    Irangos_tipas
HAVING
    COUNT(*) > 5;
    
SELECT gamintojas, COUNT(*) AS kiekis
FROM iranga
GROUP BY gamintojas
HAVING COUNT(*) > 5;
    
    
    
    
