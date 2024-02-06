import 'package:flutter/material.dart';

import 'picsum_model.dart';
import 'picsum_repository.dart';

class PicsumView extends StatefulWidget {
  const PicsumView({super.key});

  @override
  State<PicsumView> createState() => _PicsumViewState();
}

class _PicsumViewState extends State<PicsumView> {
  List<PicsumModel> picsumModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    setState(() {
      isLoading = true;
    });
    picsumModelList = await PicsumRepository.instance.fetchDataUsingDio();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              body: ListView.builder(
                itemCount: picsumModelList.length,
                itemBuilder: (BuildContext context, index) {
                  return picsumCardWidget(context, index);
                },
              ),
            ),
    );
  }

  Widget picsumCardWidget(context, int index) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
        horizontal: MediaQuery.of(context).size.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              picsumModelList[index].downloadUrl,
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.height * 0.13,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID : ${picsumModelList[index].id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Author : ${picsumModelList[index].author}'),
              Text('Height : ${picsumModelList[index].height}'),
              Text('Width : ${picsumModelList[index].width}'),
            ],
          ),
        ],
      ),
    );
  }
}
