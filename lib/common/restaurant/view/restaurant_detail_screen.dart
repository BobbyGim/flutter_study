import 'package:actual/common/const/api.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/restaurant/components/restaurant_card.dart';
import 'package:actual/common/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/product/components/product_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String id;

  const RestaurantDetailScreen({super.key, required this.id});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final acessToken = await storage.read(key: ACCESSE_TOKEN_KEY);

    final res = await dio.get(
      baseUrl + "/restaurant/${widget.id}",
      options: Options(
        headers: {
          "authorization": "Bearer $acessToken",
        },
      ),
    );

    return res.data;
  }

  @override
  void initState() {
    getRestaurantDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final item = RestaurantDetailModel.fromJson(snapshot.data!);

          return CustomScrollView(
            slivers: [
              renderTop(model: item),
              rederLabel(),
              renderProducts(products: item.products),
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, idx) {
            final model = products[idx];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(
                model: model,
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverPadding rederLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          "메뉴",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
