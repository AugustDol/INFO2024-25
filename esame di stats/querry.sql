CREATE TABLE palestra (
    id INTEGER PRIMARY KEY,
    citta VARCHAR(255) NOT NULL,
    id_coordinate INTEGER,
    lat INTEGER,
    long INTEGER
);

CREATE TABLE attivita (
    id INTEGER PRIMARY KEY,
    prezzo INTEGER NOT NULL,
    tipologia ENUM('Yoga', 'Pilates', 'Cardio', 'Pesistica') NOT NULL,
    giorno DATETIME NOT NULL,
    n_max INTEGER NOT NULL,
    n_prenotazioni INTEGER DEFAULT 0,
    id_palestra INTEGER NOT NULL,
    FOREIGN KEY (id_palestra) REFERENCES palestra(id)
);


CREATE TABLE prenotazione (
    id INTEGER PRIMARY KEY,
    id_attivita INTEGER NOT NULL,
    id_abbonamento INTEGER NOT NULL,
    FOREIGN KEY (id_attivita) REFERENCES attivita(id),
    FOREIGN KEY (id_abbonamento) REFERENCES abbonamento(n_abb)
);

CREATE TABLE abbonamento (
    n_abb INTEGER PRIMARY KEY
);