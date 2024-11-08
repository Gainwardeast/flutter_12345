import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CardWidget extends Card {
  CardWidget(String imageSrc, String title, Function() onLiked, Function() onCardClicked) : super(
          color: Colors.yellow[50],
          elevation: 8.0,
          margin: EdgeInsets.all(4.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  onCardClicked();
                }, // Image tapped
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image.network(imageSrc, scale: 7.0, frameBuilder: (context, child, frame, _) {
                      if (frame == null) {
                        return CircularProgressIndicator();
                      }
                      return child;
                    })),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  onLiked();
                }, // Image tapped
                child: LikeButton(
                  size: 50,
                  circleColor: const CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  onTap: (isLiked) async {
                    if(!isLiked){
                      await onLiked();
                    }
                    return !isLiked;
                  },
                ),
              ),
            ],
          ),
        );
}
