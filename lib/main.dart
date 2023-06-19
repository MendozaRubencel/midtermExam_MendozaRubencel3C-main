import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Runbencel S. Mendoza', '077 matagdem main rd sccp', '10/13/1999',
        'https://scontent.fmnl17-3.fna.fbcdn.net/v/t1.6435-9/41197448_2101877373410235_1714674729815638016_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG-SPV6O0Y4mj8matyB_VgoW-97yON0NPlb73vI43Q0-Ujm8-tDOhObtU1z9DakjPtUcJzhqdU0r698gE1UF_r5&_nc_ohc=T7mhPSR8EYsAX9NSMkN&_nc_ht=scontent.fmnl17-3.fna&oh=00_AfBa2uubhLcIuUi18QbCKIS8fc52URqo3MgO4Y2iNMcJgQ&oe=6473B0D7'),
    Person('John Peter Deguzman', 'nelintap sccp', '11/1999',
        'https://scontent.fmnl17-5.fna.fbcdn.net/v/t1.6435-9/74604676_2373324459598857_2951398936222367744_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=174925&_nc_eui2=AeF2tFUDi1mU6f7nNckZHGhpDE6zuUpVVLoMTrO5SlVUurKPTrdherRnZ2L2iMYVGjDVVrATSudrvqnMUg32-Yfe&_nc_ohc=iyau2Tk-_2UAX8ucbnI&_nc_ht=scontent.fmnl17-5.fna&oh=00_AfDSrtOi1-mILU0-BEDCuh3BmskH5hr6DyHlT0CBvJhmKA&oe=6473ACA3'),
    Person('kenneth Soriano', 'tarece sccp', '3/23/2000',
        'https://scontent.fmnl17-1.fna.fbcdn.net/v/t1.6435-9/71271978_2331923960405574_764438371199090688_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_eui2=AeFnbCrPzhy2ThCfhrsF0cOnYq3d16oQZ9pird3XqhBn2pHrGf6fnx29BAeRFyHL6LH5_X3_t17xygW6l38vbaGI&_nc_ohc=qVffY756WksAX9Q60er&_nc_ht=scontent.fmnl17-1.fna&oh=00_AfBlh_ei1UeqDGnRSs7ESWfUV0jNfyiDVR0fH382MtpqTQ&oe=6473D9C3'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/2677048.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
