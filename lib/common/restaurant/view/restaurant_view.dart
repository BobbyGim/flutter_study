import 'package:actual/common/const/api.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/restaurant/components/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  // future builder 함수 리턴
  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESSE_TOKEN_KEY);

    final res = await dio.get(
      baseUrl + "/restaurant",
      options: Options(
        headers: {
          "authorization": "Bearer $accessToken",
        },
      ),
    );

    print(res.data["data"]);

    return res.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
              future: paginateRestaurant(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                print(snapshot.data);

                if (!snapshot.hasData) {
                  return Container();
                }

                return ListView.separated(
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 40,
                  //   crossAxisSpacing: 10,
                  // ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (item, idx) {
                    final item = snapshot.data![idx];
                    return RestaurantCard(
                      // image: Image.asset(
                      //   "asset/img/food/ddeok_bok_gi.jpg",
                      //   fit: BoxFit.cover,
                      // ),
                      image: Image.network(
                        baseUrl + item["thumbUrl"],
                        fit: BoxFit.cover,
                      ),
                      name: item["name"],
                      tags: List<String>.from(item["tags"]),
                      ratings: item["ratings"],
                      ratingsCount: item["ratingsCount"],
                      deliveryTime: item["deliveryTime"],
                      deliveryFee: item["deliveryFee"],
                    );
                  },
                  separatorBuilder: (_, idx) {
                    return SizedBox(
                      height: 16,
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
