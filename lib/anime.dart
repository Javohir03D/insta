import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:insta/refresh.dart';

import 'package:smartrefresh/smartrefresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'anime_model.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  var animeList = <Media>[];
  final controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'AppBar',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: WRefresher(
        controller: controller,
        onRefresh: () {
          setState(() {});
          controller.refreshCompleted();
        },
        child: Query(
            options: QueryOptions(
              document: gql('''
              {
                Page {
                  media {
                    siteUrl
                    title {
                      english
                      native
                    }
                    description
                 }
               }
             }

              '''),
            ),
            builder: (result, {refetch, fetchMore}) {
              if (result.hasException) {
                return const Center(
                  child: Text(
                    "Nimadir xato ketti!",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                );
              }
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(result.data);
              final medias = (result.data?['Page']['media'] as List?)
                      ?.map(
                        (media) => Media.fromJson(
                          media ?? {},
                        ),
                      )
                      .toList() ??
                  [];
              return ListView.separated(
                itemBuilder: (_, index) {
                  return ExpansionTile(
                    title: Text(
                        '${medias[index].title?.english} - ${medias[index].title?.native}'),
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Website: ',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () async {
                                const url = 'https://blog.logrocket.com';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Text('${medias[index].siteUrl}')),
                        ],
                      ),
                      const Gap(
                        12,
                      ),
                      Text("${medias[index].description}"),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const Gap(
                  12,
                ),
                itemCount: medias.length,
              );
            }),
      ),
    );
  }
}
