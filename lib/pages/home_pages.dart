import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_http_req/pages/add_pages.dart';
import 'package:firebase_http_req/pages/detail_pages.dart';
import 'package:firebase_http_req/providers/players.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  @override
  void didChangeDependencies(){
    if(isInit){
      Provider.of<Players>(context).initialData();
    }
    isInit=false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final allPlayerProvider = Provider.of<Players>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Player'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, AddPlayer.routeName);
            }, 
            icon: Icon(Icons.add)),
        ],
      ),
      body: (allPlayerProvider.jumlahPlayer==0)
      ? Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Data",
            style: TextStyle(
              fontSize: 25,
            ),),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: (){
                Navigator.pushNamed(context, AddPlayer.routeName);
              }, 
              child: Text('Add Player',
              style: TextStyle(fontSize: 20),))
          ],
        ),
      )
      : ListView.builder(
        itemCount: allPlayerProvider.jumlahPlayer,
        itemBuilder: (context,index){
          var id = allPlayerProvider.allPlayer[index].id;
           return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailPlayer.routeName,
                      arguments: id,
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      allPlayerProvider.allPlayer[index].imageUrl.toString(),
                    ),
                  ),
                  title: Text(
                    allPlayerProvider.allPlayer[index].name.toString(),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd()
                        .format(allPlayerProvider.allPlayer[index].createdAt!),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      allPlayerProvider.deletePlayer(id!).then((_){
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Data Berhasil dihapus"),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}