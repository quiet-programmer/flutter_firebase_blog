import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_blog_app/screens/add_screen.dart';
import 'package:firebase_blog_app/services/crud.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrudMethods crudMethods = CrudMethods();
  Stream blogStream;

  Widget blogList() {
    return Container(
      child: blogStream != null
          ? Column(
              children: [
                StreamBuilder(
                  stream: blogStream,
                  builder: (_, snapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return BlogTile(
                          imageUrl:
                              snapshot.data.documents[index].data["imgUr"],
                          title: snapshot.data.documents[index].data["title"],
                          desc: snapshot.data.documents[index].data["desc"],
                          author:
                              snapshot.data.documents[index].data["autherName"],
                        );
                      },
                    );
                  },
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getAllData().then((result) {
      setState(() {
        blogStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase Blog"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return AddScreen();
          }));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: blogList(),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, author;

  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.author,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              // image: DecorationImage(
              //   image:
              //   fit: BoxFit.cover,
              // ),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              height: 150.0,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          Positioned(
            bottom: 1,
            top: 1,
            left: 1,
            right: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    author,
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
