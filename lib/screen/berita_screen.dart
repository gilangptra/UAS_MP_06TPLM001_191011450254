import 'package:flutter/material.dart';
import '../cubit/berita_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  _BeritaScreenState createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  final BeritaCubit beritaCubit = BeritaCubit();

  @override
  void initState() {
    beritaCubit.getDataBerita();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
        children: [
          Center(child: Text('191011450254 - Gilang Putra Ramadhan')),
        ],
      )),
      body: BlocBuilder<BeritaCubit, BeritaState>(
          bloc: beritaCubit,
          builder: (context, state) {
            if (state is BeritaInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              shrinkWrap: true,
              itemCount: beritaCubit.beritaModel.data?.posts?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    title: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Image.network(beritaCubit
                              .beritaModel.data!.posts![index].thumbnail!),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 190,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Text(
                                  beritaCubit
                                      .beritaModel.data!.posts![index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 15,
                                    top: 15,
                                  ),
                                  child: Text(
                                    beritaCubit.beritaModel.data!.posts![index]
                                        .pubDate!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  beritaCubit.beritaModel.data!.posts![index]
                                      .description!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
