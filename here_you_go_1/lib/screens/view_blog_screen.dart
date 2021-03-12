
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hereyougo/models/blog_model.dart';
import 'package:hereyougo/screens/read_blog.dart';
import 'add_blog_screen.dart';


class ViewBlog extends StatefulWidget {
  @override
  _ViewBlogState createState() => _ViewBlogState();
}

class _ViewBlogState extends State<ViewBlog> {
  String collection = "blogs";
  final firestore = Firestore.instance;

  Future getblog() async{
      QuerySnapshot qs= await firestore.collection(collection).getDocuments();
      return qs.documents;
  }

  Future deleteBlog(String id) async {
    await firestore.collection(collection).document(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }
  
  Future getBlogByCategory(String category)async{
    QuerySnapshot qs= await firestore.collection(collection).where('category').getDocuments();
    return qs.documents;
  }
  
  /*deleteBlog(DocumentReference blogRef) {
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(blogModel.reference);
      },
    );
  }*/
  


  neviagteToBlogDetails(DocumentSnapshot blogSnapshot){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogScreen(blogSnapshot: blogSnapshot,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Blogs'),),
      body: FutureBuilder(
        future: getblog(),
        builder: (_, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: Text('Loading...'),
          );
        }
        else{
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index){
                return Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                snapshot.data[index].data['picture'],
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadBlog()));
                                      //neviagteToBlogDetails(snapshot.data[index].data);
                                      neviagteToBlogDetails(snapshot.data[index]);
                                    },
                                    child: Text(
                                      snapshot.data[index].data['blogname'],
                                      maxLines: 2,
                                      /*style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)*/
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 22.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBlog()));
                                      /*Firestore.instance.runTransaction((Transaction myTransaction) async {
                                        await myTransaction.delete(snapshot.data.documents[index].reference);
                                      });*/
                                      deleteBlog(snapshot.data.documents[index].data['id']);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            /*Text(
                              document['description'],
                              maxLines: 2,
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )*/
                          ],
                        ),
                      ),
                    ));
              },
          );
        }
      },),






















      /*StreamBuilder(
        stream: firestore.collection(collection).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Data Available'),
            );
          }
          return ListView(
              children: snapshot.data.documents.map((document) {

                /*return Center(
                child: Container(
                  child: Text("Name="+document['name']),
                ),
              );*/

                return Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  document.data['picture'],
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadBlog()));
                                      neviagteToBlogDetails(snapshot.data.documents[index]);

                                    },
                                    child: Text(
                                      document['blogname'],
                                      maxLines: 2,
                                      /*style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)*/
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 22.0),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBlog()));

                                  },
                                  child: Expanded(
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            /*Text(
                              document['description'],
                              maxLines: 2,
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )*/
                          ],
                        ),
                      ),
                    ));
              }).toList());
        },
      ),*/
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBlog()));
        },
        icon: Icon(Icons.add),
        label: Text('Create new'),
        backgroundColor: Colors.black54,
      ),
    );



  }
}
