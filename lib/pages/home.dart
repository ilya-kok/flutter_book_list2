import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String userBook; //string?
  List bookList = []; //точный тип данныех (не пиши var)

  @override
  void initState() {
    super.initState();

    bookList.addAll([
      'bookTest1',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Список книг'),
        centerTitle: true,
      ),
      body: ListView.builder(
          //класс в формате списка
          itemCount: bookList.length,
          itemBuilder: (BuildContext context, int index) {
            return createListItem(index);
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  //всплыв окно добавления
                  return AlertDialog(
                    title: Text('Введите данные книги'),
                    content: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(labelText: 'Название книги'),
                          onChanged: (String value) {
                            userBook = value;
                          },
                        ),TextField(
                          decoration:
                              InputDecoration(labelText: 'Описание книги'),
                          onChanged: (String value) {
                            userBook = value;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Назад')),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              bookList.add(userBook);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Добавить'))
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add_alarm,
            color: Colors.grey,
          )),
    );
  }

  Widget createListItem(int index) => Dismissible(
        //возврат каждого элемента в списке
        key: Key(bookList[index]),
        child: Card(
          child: ListTile(
            title: Text(bookList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete_sweep, color: Colors.red),
              onPressed: () {
                setState(() {
                  bookList.removeAt(index);
                });
              },
            ),
          ),
        ),
        onDismissed: (direction) {
          setState(() {
            bookList.removeAt(index);
          });
        },
      );
}
