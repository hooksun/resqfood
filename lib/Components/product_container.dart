import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/10,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.fromBorderSide(BorderSide(color: Colors.grey, width: 1, strokeAlign: BorderSide.strokeAlignOutside)),
          color: Colors.black, //temp
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    clipBehavior: Clip.hardEdge,
                    fit: BoxFit.cover,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      child: Image.asset('assets/images/placeholder_thumbnail.png')
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(Icons.favorite_border, color: Colors.white, size: 30, )
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(1000))
                          ),
                        ),
                        const Text(
                          'Starbucks Coffee',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Coffee & Pastry', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Open at: 18:30 - 20:00', style: TextStyle(fontSize: 10),),
                            
                          ],
                        ),
                        Text('Rp. 48.000', style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
              )
            ),
          ],
        ),
      ),
    );
  }
}