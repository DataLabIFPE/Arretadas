import 'package:arretadas/UIcontacts/ContactPage.dart';
import 'package:arretadas/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeContactsPage extends StatefulWidget {
  @override
  _HomeContactsPageState createState() => _HomeContactsPageState();
}

class _HomeContactsPageState extends State<HomeContactsPage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amigos"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCart(context, index);
        },
      ),
    );
  }

  Widget _contactCart(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/logo-white.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    /*Text(
                      contacts[index].email ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),*/
                    Text(contacts[index].phone ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _showCardContact(context, index);
      },
    );
  }

  /*void _showOptions(BuildContext context, index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(color: Colors.pink, fontSize: 20.0),
                        ),
                        onPressed: () {},
                      ),
                      TextButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(color: Colors.pink, fontSize: 20.0),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              });
        });
  }
  */

  Future<void> _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    if (recContact != null) {
      if (contact != null) {
        helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContact().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void _showCardContact(BuildContext context, index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Icon(
                                                Icons.person_pin,
                                                color: Colors.pink,
                                                size: 40,
                                              )),
                                          Text(contacts[index].name ?? "",
                                              style: TextStyle(
                                                  color: Colors.pink,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic))
                                        ]),
                                        /*Row(children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Icon(Icons.place,
                                                  color: Colors.pink,
                                                  size: 40)),
                                          Expanded(
                                              child: Text(
                                                  contacts[index].endress ?? "",
                                                  style: TextStyle(
                                                      color: Colors.pink,
                                                      fontSize: 18.0,
                                                      fontStyle:
                                                          FontStyle.italic))),
                                        ]),*/
                                        Row(children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Icon(Icons.phone,
                                                  color: Colors.pink,
                                                  size: 40)),
                                          Text(contacts[index].phone,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: Colors.pink,
                                                  fontSize: 18.0,
                                                  fontStyle: FontStyle.italic))
                                        ]),
                                      ],
                                    )),
                              ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            child: Column(children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.pink,
                              ),
                              Text(
                                "Ligar",
                                style: TextStyle(
                                    color: Colors.pink, fontSize: 20.0),
                              )
                            ]),
                            onPressed: () {
                              launch("tel:${contacts[index].phone}");
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Column(children: <Widget>[
                              Icon(
                                Icons.cached, //mode_edit,
                                color: Colors.pink,
                              ),
                              Text(
                                "Editar",
                                style: TextStyle(
                                    color: Colors.pink, fontSize: 20.0),
                              )
                            ]),
                            onPressed: () {
                              Navigator.pop(context);
                              _showContactPage(contact: contacts[index]);
                            },
                          ),
                          TextButton(
                            child: Column(children: <Widget>[
                              Icon(
                                Icons.delete, //delete,
                                color: Colors.pink,
                              ),
                              Text(
                                "Deletar",
                                style: TextStyle(
                                    color: Colors.pink, fontSize: 20.0),
                              )
                            ]),
                            onPressed: () {
                              helper.deleteContact(contacts[index].id);
                              setState(() {
                                contacts.removeAt(index);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
