import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Image> images = [
    Image(
      image: NetworkImage(
          'https://drive.google.com/uc?export=view&id=1zhSdES1D_2YAjDXGutOjDDOLKxg1UqEj'),
      fit: BoxFit.fill,
    ),
    Image(
      image: NetworkImage(
          'https://drive.google.com/uc?export=view&id=12x0WWHzPw8SEYbTxJK5ag4JBj5t6dQp8'),
      fit: BoxFit.fill,
    ),
    Image(
      image: NetworkImage(
          'https://drive.google.com/uc?export=view&id=1ARQS_gXDAbSDkRw6YNV6RKkFf7Dj-w_m'),
      fit: BoxFit.fill,
    )
  ];
  CircleAvatar shape1 = CircleAvatar(
    backgroundColor: Colors.amber,
    radius: 5,
  );
  CircleAvatar shape2 = CircleAvatar(
    backgroundColor: Colors.grey,
    radius: 5,
  );
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return ListView(
        children: [
          Stack(
            children: [
              Container(
                  width: constrains.maxHeight, //double.infinity,
                  height: constrains.maxHeight,
                  child: images[index]),
              Positioned(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if(index < 2 )     index++;
                    });
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                bottom: 15,
                left: constrains.maxWidth / 1.3,
              ),
              Positioned(
                bottom: 15,
                left: 20,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if(index > 0 )     index--;
                    });
                  },
                  child: Text(
                    'Previous',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: constrains.maxWidth / 2.3,
                child: Wrap(
                  spacing: 5,
                  children: [
                    index == 0 ?   shape1:
                    shape2,
                    index == 1 ?   shape1:
                    shape2,
                    index == 2 ?   shape1:
                    shape2,


                  ],
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
