import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as mysql;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp,
    //DeviceOrientation.landscapeLeft,
    //]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borussia Management',
      theme: ThemeData(primarySwatch: Colors.red, primaryColorDark: Colors.red),
      darkTheme: ThemeData(
          accentColor: Colors.red,
          primaryColorDark: Colors.red,
          primarySwatch: Colors.red,
          brightness: Brightness.dark),
      home: Home(),
      themeMode: ThemeMode.dark,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DECLARING VARIABLES
  String startPage = "Einstellungen";
  List<TextStyle> listTileColors = [];
  Widget bodyPlaceholder = Container();

  _HomeState() {
    // Filling listTileColors with default values
    for (var i = 0; i < 3; i++) {
      listTileColors.add(TextStyle(
        fontWeight: FontWeight.normal,
      ));
    }
    // Receiving info about StartPage and refreshing the page with new start page
    storageGetString("startPage").then((startPageData) => setState(() {
          if (startPageData != null) {
            startPage = startPageData;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    // CODE THAT EXECUTES EVERY BUILD

    // Selecting the current list tile
    if (startPage == "Einstellungen") {
      for (var i = 0; i < 3; i++) {
        listTileColors[i] = TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14,
        );
      }
      listTileColors[0] = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      );
      bodyPlaceholder = Einstellungen();
    } else if (startPage == "Spieler") {
      for (var i = 0; i < 3; i++) {
        listTileColors[i] = TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14,
        );
      }
      listTileColors[1] = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      );
      bodyPlaceholder = Spieler();
    } else if (startPage == "Training") {
      for (var i = 0; i < 3; i++) {
        listTileColors[i] = TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14,
        );
      }
      listTileColors[2] = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      );
      bodyPlaceholder = Center(
        child: Text(
          "Training",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      );
    }

    // Returning static widget tree
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: Text(
          startPage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[700],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(""),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    startPage = "Spieler";
                  });
                  Navigator.pop(context);
                },
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Spieler",
                        style: listTileColors[1],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    startPage = "Training";
                  });
                  Navigator.pop(context);
                },
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Icon(
                          Icons.directions_run,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Training",
                        style: listTileColors[2],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    startPage = "Einstellungen";
                  });
                  Navigator.pop(context);
                },
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Einstellungen",
                        style: listTileColors[0],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: bodyPlaceholder,
    );
  }
}

// CUSTOM WIDGET CLASSES

// Einstellungen widget

class Einstellungen extends StatefulWidget {
  @override
  _EinstellungenState createState() => _EinstellungenState();
}

class _EinstellungenState extends State<Einstellungen> {
  String serverName = "Lädt...";
  String userName = "Lädt...";
  int portName = 3306;
  String password = "Lädt...";
  String database = "Lädt...";
  List<String> startPages = ["Spieler", "Training", "Einstellungen"];
  String startPage = "Einstellungen";

  _EinstellungenState() {
    storageGetString("Server").then((serverNameData) => setState(() {
          if (serverNameData != null) {
            serverName = serverNameData;
          } else {
            serverName = "Empty";
          }
        }));
    storageGetString("User").then((userNameData) => setState(() {
          if (userNameData != null) {
            userName = userNameData;
          } else {
            userName = "Empty";
          }
        }));
    storageGetInt("Port").then((portNameData) => setState(() {
          if (portNameData != null) {
            portName = portNameData;
          } else {
            portName = 3306;
          }
        }));
    storageGetString("Password").then((passwordData) => setState(() {
          if (passwordData != null) {
            password = passwordData;
          } else {
            password = "Empty";
          }
        }));
    storageGetString("Database").then((databaseData) => setState(() {
          if (databaseData != null) {
            database = databaseData;
          } else {
            database = "Empty";
          }
        }));
    storageGetString("startPage").then((startPageData) => setState(() {
          if (startPageData != null) {
            startPage = startPageData;
          } else {
            startPage = "Einstellungen";
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "Datenbankeinstellungen:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                        child: TextField(
                          keyboardType: TextInputType.url,
                          maxLines: 1,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Server",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            )),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Hier eingeben:  ",
                          ),
                          onChanged: (text) {
                            setState(() {
                              serverName = text;
                              storageSetString("Server", text);
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '$serverName',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ]),
          Row(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Port",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            )),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Hier eingeben:  ",
                          ),
                          onChanged: (text) {
                            setState(() {
                              portName = int.parse(text);
                              storageSetInt("Port", int.parse(text));
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '$portName',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ]),
          Row(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                        child: TextField(
                          maxLines: 1,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Nutzername",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            )),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Hier eingeben:  ",
                          ),
                          onChanged: (text) {
                            setState(() {
                              userName = text;
                              storageSetString("User", text);
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '$userName',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ]),
          Row(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                        child: TextField(
                          obscureText: true,
                          maxLines: 1,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Passwort",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            )),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Hier eingeben:  ",
                          ),
                          onChanged: (text) {
                            setState(() {
                              password = text;
                              storageSetString("Password", text);
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '${password.replaceAll(RegExp(r"."), "*")}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ]),
          Row(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                        child: TextField(
                          maxLines: 1,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Datenbank",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            )),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Hier eingeben:  ",
                          ),
                          onChanged: (text) {
                            setState(() {
                              database = text;
                              storageSetString("Database", text);
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '$database',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
              ]),
          Row(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "Appeinstellungen:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Startseite:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 2,
                child: DropdownButton<String>(
                  items: startPages.map((String startPage) {
                    return DropdownMenuItem<String>(
                      value: startPage,
                      child: Text(
                        startPage,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                  selectedItemBuilder: (BuildContext context) {
                    return startPages.map((String value) {
                      return Row(
                        children: <Widget>[
                          Text(
                            startPage,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  iconSize: 30.0,
                  iconEnabledColor: Colors.white,
                  onChanged: (String value) {
                    setState(() {
                      startPage = value;
                      storageSetString("startPage", value);
                    });
                  },
                  value: startPage,
                ),
              ),
              SizedBox(
                width: 15.0,
              )
            ],
          )
        ],
      ),
    );
  }
}

// Spieler widget

class Spieler extends StatefulWidget {
  @override
  _SpielerState createState() => _SpielerState();
}

class _SpielerState extends State<Spieler> {
  mysql.ConnectionSettings settings;
  bool newSpieler = false;
  String server;
  int port;
  String user;
  String password;
  String database;
  int getDataCount = 0;
  Duration timeout = Duration(milliseconds: 3500);
  int sortColumnIndex = 1;
  bool sortAsc = true;
  String spielerNr = "";
  String vorname = "";
  String nachname = "";
  String strasse = "";
  String haus_nr = "";
  String plz = "";
  String email = "";
  String geburtsjahr = "";
  String geburtsdatum = "";
  bool deleteAnswer = false;
  bool spielerEdit = false;
  String textAbove = "";
  Widget buttonBelow;

  List<List> tableHead = [
    ["Vorname", "vorname"],
    ["Nachname", "nachname"],
    ["Strasse", "strasse"],
    ["HausNr", "haus_nr"],
    ["PLZ", "plz"],
    ["E-Mail", "email"],
    ["Geburtsjahr", "geburtsjahr"],
    ["Geburtsdatum", "geburtsdatum"]
  ];

  _SpielerState() {
    getDataCount = 0;
    storageGetString("Server").then((data) => setState(() {
          server = data;
          settings = mysql.ConnectionSettings(
            host: server,
            port: port,
            user: user,
            password: password,
            db: database,
            timeout: timeout,
          );
          getDataCount++;
          loader();
        }));
    storageGetInt("Port").then((data) => setState(() {
          if (data != null) {
            port = data;
          } else {
            port = 3306;
          }
          settings = mysql.ConnectionSettings(
            host: server,
            port: port,
            user: user,
            password: password,
            db: database,
            timeout: timeout,
          );
          getDataCount++;
          loader();
        }));
    storageGetString("User").then((data) => setState(() {
          user = data;
          settings = mysql.ConnectionSettings(
            host: server,
            port: port,
            user: user,
            password: password,
            db: database,
            timeout: timeout,
          );
          getDataCount++;
          loader();
        }));
    storageGetString("Password").then((data) => setState(() {
          password = data;
          settings = mysql.ConnectionSettings(
            host: server,
            port: port,
            user: user,
            password: password,
            db: database,
            timeout: timeout,
          );
          getDataCount++;
          loader();
        }));
    storageGetString("Database").then((data) => setState(() {
          database = data;
          settings = mysql.ConnectionSettings(
            host: server,
            port: port,
            user: user,
            password: password,
            db: database,
            timeout: timeout,
          );
          getDataCount++;
          loader();
        }));
  }

  Widget placeholder = Container();

  Future<void> showDeleteDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Löschen'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wollen sie $vorname $nachname wirklich löschen?'),
                Text('Sie können die Informationen nicht wiederherstellen!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ja',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                deleteAnswer = true;
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Nein",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                deleteAnswer = false;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  loader() {
    if (getDataCount > 4 && !spielerEdit) {
      sqlSpielerQuery(settings, tableHead[sortColumnIndex][1], sortAsc)
          .then((data) => setState(() {
                if (data != null) {
                  List<DataRow> rows = [];
                  List<DataCell> cells = [];
                  for (var row in data) {
                    cells = [];
                    int i = 0;
                    for (var entry in row) {
                      if (i == 0) {
                        i++;
                        continue;
                      }
                      if (i == 8) {
                        entry = entry.add(Duration(days: 1));
                        String date = entry.day.toString() +
                            "." +
                            entry.month.toString() +
                            "." +
                            entry.year.toString();
                        cells.add(DataCell(Text(
                          date,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )));
                        i++;
                        continue;
                      }
                      cells.add(DataCell(Text(
                        entry.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )));
                      i++;
                    }
                    rows.add(DataRow(
                        cells: cells,
                        onSelectChanged: (selected) {
                          if (selected) {
                            setState(() {
                              spielerEdit = true;
                              spielerNr = row.toList()[0].toString();
                              vorname = row.toList()[1];
                              nachname = row.toList()[2];
                              strasse = row.toList()[3];
                              haus_nr = row.toList()[4].toString();
                              plz = row.toList()[5].toString();
                              email = row.toList()[6];
                              geburtsjahr = row.toList()[7].toString();
                              var entry =
                                  row.toList()[8].add(Duration(days: 1));
                              geburtsdatum = entry.year.toString() +
                                  "-" +
                                  entry.month.toString() +
                                  "-" +
                                  entry.day.toString();
                              print(row.toList());
                              loader();
                            });
                          }
                        }));
                  }
                  placeholder = SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    color: Colors.red[900],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Spieler hinzufügen"),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        spielerEdit = true;
                                        newSpieler = true;
                                        spielerNr = "";
                                        vorname = "";
                                        nachname = "";
                                        strasse = "";
                                        haus_nr = "";
                                        plz = "";
                                        email = "";
                                        geburtsjahr = "";
                                        geburtsdatum = "";
                                        loader();
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                showCheckboxColumn: false,
                                sortColumnIndex: sortColumnIndex,
                                sortAscending: sortAsc,
                                columns: tableHead
                                    .map((data) => DataColumn(
                                        label: Text(
                                          data[0],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onSort: (columnIndex, sortAscending) {
                                          setState(() {
                                            if (columnIndex ==
                                                sortColumnIndex) {
                                              sortAsc = sortAscending;
                                              loader();
                                            } else {
                                              sortColumnIndex = columnIndex;
                                              loader();
                                            }
                                          });
                                        }))
                                    .toList(),
                                rows: rows),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  placeholder = Center(
                    child: Text(
                      "Connection Error",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  );
                }
              }));
    } else if (getDataCount > 4 && spielerEdit) {
      if (!newSpieler) {
        textAbove = "Spieler bearbeiten:";
        buttonBelow = Row(children: <Widget>[
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                    color: Colors.red[800],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Spieler löschen",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                    onPressed: () {
                      showDeleteDialog(context).then((result) {
                        if (deleteAnswer) {
                          sqlSpielerDelete(settings, spielerNr).then((result) {
                            setState(() {
                              spielerEdit = false;
                              newSpieler = false;
                              spielerNr = "";
                              vorname = "";
                              nachname = "";
                              strasse = "";
                              haus_nr = "";
                              plz = "";
                              email = "";
                              geburtsjahr = "";
                              geburtsdatum = "";
                              deleteAnswer = false;
                              loader();
                            });
                          });
                        }
                      });
                    })),
          ),
        ]);
      } else {
        textAbove = "Spieler hinzufügen:";
        buttonBelow = Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.red[800],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Abbrechen",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      spielerEdit = false;
                      newSpieler = false;
                      loader();
                    });
                  },
                ),
              ),
            )
          ],
        );
      }
      placeholder = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: Text(
                        textAbove,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                      color: Colors.red[900],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Fertig"),
                          Icon(Icons.check),
                        ],
                      ),
                      onPressed: () {
                        if (!newSpieler) {
                          sqlSpielerEdit(
                                  settings,
                                  spielerNr,
                                  vorname,
                                  nachname,
                                  strasse,
                                  haus_nr,
                                  plz,
                                  email,
                                  geburtsjahr,
                                  geburtsdatum)
                              .then((result) {
                            setState(() {
                              print(result);
                              spielerEdit = false;
                              loader();
                            });
                          });
                        } else {
                          sqlSpielerAdd(
                                  settings,
                                  vorname,
                                  nachname,
                                  strasse,
                                  haus_nr,
                                  plz,
                                  email,
                                  geburtsjahr,
                                  geburtsdatum)
                              .then((result) {
                            if (result == null) {
                              showMyDialog(context).then((result) {
                                setState(() {
                                  loader();
                                });
                              });
                            } else {
                              setState(() {
                                newSpieler = false;
                                spielerEdit = false;
                                loader();
                              });
                            }
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "Vorname",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                vorname = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$vorname',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "Nachname",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                nachname = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$nachname',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "Strasse",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                strasse = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$strasse',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "HausNr",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                haus_nr = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$haus_nr',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "PLZ",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                plz = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$plz',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "E-Mail",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                email = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$email',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "Geburtsjahr",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                geburtsjahr = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$geburtsjahr',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 5.0),
                          child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: "Geburtsdatum",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Hier eingeben:  ",
                            ),
                            onChanged: (text) {
                              setState(() {
                                geburtsdatum = text;
                                loader();
                                // TO DO
                                // add sql alter or insert query
                              });
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$geburtsdatum',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            buttonBelow,
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return placeholder;
  }
}

// FUNCTIONS

storageGetInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int result = prefs.getInt(key);
  return result;
}

storageSetInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

storageGetString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String result = prefs.getString(key);
  return result;
}

storageSetString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

sqlSpielerQuery(settings, String order, bool sortAsc) async {
  mysql.MySqlConnection conn;
  try {
    String upordown = "ASC";
    if (sortAsc) {
      upordown = "ASC";
    } else {
      upordown = "DESC";
    }
    var conn = await mysql.MySqlConnection.connect(settings);
    var results =
        await conn.query("Select * from Spieler order by $order $upordown");
    return results;
  } catch (e) {
    print(e);
    return null;
  } finally {
    try {
      conn.close();
    } catch (e) {}
  }
}

sqlSpielerEdit(settings, spieler_nr, vorname, nachname, strasse, haus_nr, plz,
    email, geburtsjahr, String geburtsdatum) async {
  mysql.MySqlConnection conn;
  try {
    var conn = await mysql.MySqlConnection.connect(settings);
    var results = await conn.query(
        "UPDATE spieler SET vorname = \"$vorname\", nachname = \"$nachname\", strasse = \"$strasse\", haus_nr = $haus_nr, plz = $plz, email = \"$email\", geburtsjahr = $geburtsjahr, geburtsdatum = \"$geburtsdatum\" WHERE spieler_nr = $spieler_nr");
    return results;
  } catch (e) {
    print(e);
    return null;
  } finally {
    try {
      conn.close();
    } catch (e) {}
  }
}

sqlSpielerAdd(settings, vorname, nachname, strasse, haus_nr, plz, email,
    geburtsjahr, String geburtsdatum) async {
  mysql.MySqlConnection conn;
  try {
    var conn = await mysql.MySqlConnection.connect(settings);
    var results = await conn.query(
        "INSERT INTO spieler (vorname, nachname, strasse, haus_nr, plz, email, geburtsjahr, geburtsdatum) VALUES(\"$vorname\",\"$nachname\",\"$strasse\", $haus_nr, $plz,\"$email\", $geburtsjahr, \"$geburtsdatum\")");
    return results;
  } catch (e) {
    print(e);
    return null;
  } finally {
    try {
      conn.close();
    } catch (e) {}
  }
}

sqlSpielerDelete(settings, spieler_nr) async {
  mysql.MySqlConnection conn;
  try {
    var conn = await mysql.MySqlConnection.connect(settings);
    var results =
        await conn.query("DELETE FROM spieler WHERE spieler_nr = $spieler_nr");
    return results;
  } catch (e) {
    print(e);
    return null;
  } finally {
    try {
      conn.close();
    } catch (e) {}
  }
}

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Fehler'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Konnte den Spieler nicht hinzufügen!'),
              Text(
                  'Bitte alle Angaben ausfüllen und auf ihre Richtigkeit überprüfen!'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
