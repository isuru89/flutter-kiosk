import 'package:flutter/material.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/model/items.dart';

class FeaturedItemList extends StatelessWidget {
  const FeaturedItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => FeaturedItem(
                  item: demoFeaturedItems[index],
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  width: 32,
                ),
            itemCount: demoFeaturedItems.length));
  }
}

class FeaturedItem extends StatelessWidget {
  final Item item;

  const FeaturedItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: AssetImage(item.imageUrl),
            fit: BoxFit.fill,
          ),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [
                      0,
                      1.0
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontSize: 20, color: Colors.white),
                  ),
                ),
                Text(
                  "\$${item.price}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
