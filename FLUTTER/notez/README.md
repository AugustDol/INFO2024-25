# Notez

**Notez** è un'applicazione Flutter progettata per offrire un'esperienza semplice ed efficace nella gestione delle note personali. Utilizza ObjectBox come database locale per garantire prestazioni elevate e Riverpod per una gestione efficiente dello stato dell'applicazione

## Caratteristiche Principali

* **Gestione Completa delle Note**: Crea, modifica ed elimina note con facilità.
* **Archiviazione Locale**: Le note sono salvate permanentemente sul dispositivo utilizzando ObjectBox.
* **Interfaccia Intuitiva**: Le note sono presentate su card ben organizzate per una visualizzazione chiara.
* **Integrazione con Riverpod**: Utilizza Riverpod per una gestione dello stato reattiva e scalabile.

## Struttura del Progetto

[**models**](./lib/models/): Definizione delle classi dei modelli, inclusa la classe [Note](./lib/models/note.dart) annotata con @Entity per ObjectBox.
[**screens**](./lib/screens/): Schermate principali dell'applicazione, come la visualizzazione delle note e l'editor.
[**provider**](./lib/provider/): Gestione dello stato dell'applicazione utilizzando Riverpod.
[**router**](./lib/router/): Configurazione delle rotte dell'applicazione.