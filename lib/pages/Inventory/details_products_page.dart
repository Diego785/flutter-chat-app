import 'package:flutter/material.dart';

class DetailsProductsPage extends StatelessWidget {
  final String name;
  final DateTime fechaCreacion;
  final DateTime fechaVencimiento;
  final String imagePath;
  final int index;
  const DetailsProductsPage({
    required this.name,
    required this.fechaCreacion,
    required this.fechaVencimiento,
    required this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'foto$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(this.imagePath), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Container(
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.name,
                          style: TextStyle(
                            color: Colors.cyan.shade300,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Created: " + this.fechaCreacion.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Expiration: " + this.fechaVencimiento.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
