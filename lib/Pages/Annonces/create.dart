import 'package:btpp/Components/horizontalDivider.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CreateAnnonce extends StatefulWidget {
  final AnnonceModel annonce;

  const CreateAnnonce({Key key, this.annonce}) : super(key: key);

  @override
  _CreateAnnonceState createState() => _CreateAnnonceState(annonce: annonce);
}

class _CreateAnnonceState extends State<CreateAnnonce> {
  AnnonceModel data;
  final AnnonceModel annonce;
  final _pageController = PageController(initialPage: 0);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<int> selectedTache = List();

  _CreateAnnonceState({this.annonce});

  @override
  void initState() {
    data = annonce == null ? AnnonceModel() : annonce;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool checkpage() {
    if (_pageController.page.round() == _pageController.initialPage)
      _closeDialog();
    else {
      _pageController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  void _nextPage() {
    if (_formKey.currentState.validate() && _pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  bool _closeDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Voulez vous abandonner ?"),
          content:
              new Text("Vous n'avez pas terminer la creation de l'annonce"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Abandoner"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),new FlatButton(
              child: new Text("Annuler"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return false;
  }

  DateTime today = DateTime.now();
  DateTime debut = DateTime.now();
  DateTime fin = DateTime.now();
  bool tacheError = false;
  ValueChanged<DateTime> selectDate;

  Future<void> _selectDate(BuildContext context, DateTime value,
      {DateTime min, DateTime max, @required Function onChange}) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: value == null ? DateTime.now() : value,
        firstDate: min == null ? today : min,
        lastDate: today.add(Duration(days: 100000)));
    if (picked != null) {
      onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Future.sync(checkpage),
      child: PageView(
        physics: new NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _pageController,
        children: [MainDetailPage(), TacheSelectPage()],
      ),
    );
  }

  Widget TacheSelectPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tâches de l\'annonce'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  horizontalDivider(text: exampleCat[index].intitule),
                  ListView.builder(
                    itemBuilder: (context, index2) => GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: selectedTache
                                .contains(exampleCat[index].taches[index2].id),
                            onChanged: (x) {
                              int value = exampleCat[index].taches[index2].id;
                              print(value);
                              if (selectedTache.contains(value)) {
                                setState(() {
                                  selectedTache.remove(value);
                                });
                              } else {
                                setState(() {
                                  selectedTache.add(value);
                                });
                              }
                              print(selectedTache);
                            },
                          ),
                          Expanded(
                              child: Text(
                                  exampleCat[index].taches[index2].intitule))
                        ],
                      ),
                      onTap: () {
                        int value = exampleCat[index].taches[index2].id;
                        print(value);
                        if (selectedTache.contains(value)) {
                          setState(() {
                            selectedTache.remove(value);
                          });
                        } else {
                          setState(() {
                            selectedTache.add(value);
                          });
                        }
                        print(selectedTache);
                      },
                    ),
                    itemCount: exampleCat[index].taches.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  )
                ],
              );
            }, childCount: exampleCat.length),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                tacheError ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Selectionnez aumoin une tache',style: TextStyle(color: Colors.red),),
                ): SizedBox(height: 0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Suivant'),
                  onPressed: () {
                    if (selectedTache.length > 0 && _pageController.hasClients) {
                      tacheError = false;
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    } else {
                      setState(() {
                        tacheError = true;
                      });
                    }
                  },
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget MainDetailPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Annonce'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Detail de L\'annonce',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: data.intitule,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Veuillez entrer un titre';
                              }
                              return null;
                            },
                            decoration: new InputDecoration(
                              hintText: 'Un titre pour votre annonce',
                              labelText: 'Titre',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onSaved: (value) {
                              data.intitule = value;
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            initialValue: data.lieu,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Veuillez entrer un lieu';
                              }
                              return null;
                            },
                            decoration: new InputDecoration(
                              hintText:
                                  'Le lieu de votre annonce ex: USA, New York',
                              labelText: 'Lieu',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onSaved: (value) {
                              data.lieu = value;
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            initialValue: data.description,
                            maxLines: 4,
                            minLines: 1,
                            maxLength: 1000,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Veuillez entrer un titre';
                              }
                              if (value.length < 200) {
                                return 'Description trop courte, min 200';
                              }
                              return null;
                            },
                            decoration: new InputDecoration(
                              hintText: 'Decrivez ce qu\'il y-a a faire',
                              labelText: 'Description',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onSaved: (value) {
                              data.description = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Container(
                        color: Colors.grey[200],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Durée de L\'annonce',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _InputDropdown(
                            labelText: 'Date de Debut',
                            valueText: DateFormat.yMMMd().format(debut),
                            valueStyle: TextStyle(),
                            onPressed: () {
                              _selectDate(context, debut, onChange: (data) {
                                setState(() {
                                  debut = data;
                                  if (debut.isAfter(fin)) fin = data;
                                });
                              });
                            },
                          ),
                          _InputDropdown(
                            labelText: 'Date de Fin',
                            valueText: DateFormat.yMMMd().format(fin),
                            valueStyle: TextStyle(),
                            onPressed: () {
                              _selectDate(context, fin, min: debut,
                                  onChange: (data) {
                                setState(() {
                                  fin = data;
                                  if (fin.isBefore(debut)) {
                                    debut = data;
                                  }
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('Suivant'),
                          onPressed: _nextPage,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
