import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Bloc/netflix_bloc.dart';

import '../Repository/Model_Class/NetflixModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    BlocProvider.of<NetflixBloc>(context).add(FetchNetflix());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<NetflixBloc, NetflixState>(
              builder: (context, state) {
                if (state is NetflixBlocLoading) {
                  print("loading");
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is NetflixBlocError) {
                  return const Center(
                    child: Text('something else !!'),
                  );
                }
                if (state is NetflixBlocLoaded) {
                  data = BlocProvider.of<NetflixBloc>(context).netflixModel;
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              data.titles![index].jawSummary!.backgroundImage!
                                          .url ==
                                      ''
                                  ? const SizedBox()
                                  : Image.network(
                                      data.titles![index].jawSummary!
                                          .backgroundImage!.url
                                          .toString(),
                                      height: 100,
                                      width: 200,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                data.titles![index].jawSummary!.title
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: data.titles!.length),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

late NetflixModel data;
TextEditingController controller = TextEditingController();
