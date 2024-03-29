import 'package:flutter/material.dart';

class ResponsavelProfilePage extends StatefulWidget {
  @override
  _ResponsavelProfilePageState createState() =>
      new _ResponsavelProfilePageState();
}

class _ResponsavelProfilePageState extends State<ResponsavelProfilePage> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos =
        new List.generate(_count, (int i) => new ContactRow());

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("NonstopIO"),
        ),
        body: new LayoutBuilder(builder: (context, constraint) {
          final _maxHeight = constraint.biggest.height / 3;
          final _biggerFont = TextStyle(fontSize: _maxHeight / 6);

          return new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.all(20.0),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Data de nascimento',
                  ),
                ),

                new Container(
                  padding: new EdgeInsets.all(20.0),
                ),
                new Container(
                  height: 200.0,
                  child: new ListView(
                    children: _contatos,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                 ElevatedButton(
                  onPressed: _addNewContactRow,
                  child: new Icon(Icons.add),
                ),
                //new ContactRow()
              ],
            ),
          );
        }));
  }

  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
    });
  }
}

class ContactRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactRow();
}

class _ContactRow extends State<ContactRow> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Container(
        width: 170.0,
        padding: new EdgeInsets.all(5.0),
        // ignore: unnecessary_new
        child: new Column(children: <Widget>[
          new TextFormField(
            decoration: new InputDecoration(
              labelText: 'Contato',
            ),
          ),
         Text("Tipo Contato: "),
           DropdownButton(
            value: _currentContactType,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem("test"),
          ),
          new Container(
            padding: new EdgeInsets.all(20.0),
          ),
        ]));
  }

  List _contactTypes = ["Phone (SMS)", "Phone (Whatsapp)", "Email"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String? _currentContactType;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentContactType = null;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String city in _contactTypes) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

   changedDropDownItem(String selectedCity) {
    setState(() {
      _currentContactType = selectedCity;
    });
  }
}