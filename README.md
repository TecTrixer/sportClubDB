# Sport Club Manager

## About this project:

This App provides an easy to use interface for a MySQL database.
The database is designed in such a way, that you can store information about all of your players and soon also about trainings.
Currently this App and the database use german as their main language, in future versions the database will use english as its native language.

### Attention!:
This App does not contain a database, you need to host your own database!

## Future Releases:

### Database Language Change
In the future the database language will be changed to english for international use.
If you want to use a different language feel free to fork this project and integrate your language.
For further support you can also contact me.

### Database Change!
In a future update this app will use a PostgreSQL database and the postgres dart package instead of the MySQL configuration.
PostgreSQL is a more modern open source database which is easier to use nowadays.
Please consider this change if you think about hosting your own database for this app!


## Database Format

Currently there only is one used table in the database with the following format:

### Table spieler
|spieler_nr|vorname|nachname|strasse|haus_nr|plz|email|geburtsjahr|geburtsdatum|
|---|---|---|---|---|---|---|---|---|
|int PRI Auto_Inc|varchar(255)|varchar(255)|varchar(255)|int|int|varchar(255)|int|date|

## Contact 

If you have any questions open a new issue and use the label "question".
If you have any ideas for new features and enhancements open a new issue and use the label "enhancement".
