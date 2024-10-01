import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD em Memória',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD em Memória'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormPage(
                      onSubmit: (item) {
                        setState(() {
                          _items.add(item);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: 200.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                    )),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Realizar depósito",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ]),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListPage(
                      items: _items,
                      onDelete: (index) {
                        setState(() {
                          _items.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: 200.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                    )),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ver depósitos",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  final Function(String) onSubmit;

  FormPage({required this.onSubmit});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depósito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Valor a depositar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bota um valor ai patrão';
                  }

                  final double? number = double.tryParse(value);
                  if (number == null) {
                    return 'Tem que ser um double meu mano';
                  }

                  return null;
                },
                onSaved: (value) {
                  _inputValue = value ?? '';
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Depositar'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    widget.onSubmit(_inputValue);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  final List<String> items;
  final Function(int) onDelete;

  ListPage({required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Depósitos'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onDelete(index);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
