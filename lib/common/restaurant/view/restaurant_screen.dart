import 'package:actual/common/const/api.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/restaurant/components/restaurant_card.dart';
import 'package:actual/common/restaurant/model/restaurant_model.dart';
import 'package:actual/common/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

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
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (item, idx) {
                    final item = snapshot.data![idx];

                    final pItem2 = RestaurantModel.fromJson(
                      json: item,
                    );

                    // final pItem = RestaurantModel(
                    //   id: item["id"],
                    //   name: item["name"],
                    //   thumbUrl: baseUrl + item["thumbUrl"],
                    //   tags: List<String>.from(item["tags"]),
                    //   priceRange: RestaurantPriceRangeEnum.values.firstWhere(
                    //     (e) => e.name == item["priceRange"],
                    //   ),
                    //   ratings: item["ratings"],
                    //   ratingsCount: item["ratingsCount"],
                    //   deliveryTime: item["deliveryTime"],
                    //   deliveryFee: item["deliveryFee"],
                    // );

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(
                              id: pItem2.id,
                            ),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(
                        model: pItem2,
                      ),
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
