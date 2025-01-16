import 'package:auto_access/features/rent/models/car_review_model.dart';
import 'package:auto_access/features/rent/screens/car_review/widget/rating_star.dart';
import 'package:auto_access/utility/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/formatters/formatters.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard ({super.key, required this.carReview});

  final CarReviewModel carReview;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
   return Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(carReview.userImageUrl ?? '')),
              const SizedBox(width: 10.0),
              Text(carReview.userName ?? '', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
            ],
           ),
           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
         ],
       ),
       const SizedBox(height: 10.0),

       /// Review
       Row(
         children: [
           ///Review Stars
           RRatingBarIndicator(rating: carReview.ratings),

           ///Review Date
           const SizedBox(width: 10.0),
           Text(RFormatter.formatDate(carReview.timestamp)),
         ],
       ),
       const SizedBox(height: 10.0),

       ///Review Text
       ReadMoreText(
         carReview.comment ?? '',
         trimLines: 3,
         colorClickableText: Colors.blue,
         trimMode: TrimMode.Line,
         trimExpandedText: 'show less',
         moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[700]),
         lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[700]),
       ),
       const SizedBox(height: 10.0),

         ///Review Reply
       Container(
         color: dark ? RColors.darkerGrey : RColors.grey,
         child: Padding(
           padding: const EdgeInsets.all(15.0),
           child: Column(
             children: [
               ///Car Rental Name
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const Text("Car Rental Services", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
                   Text(RFormatter.formatDate(carReview.shopTimestamp)),
                 ],
               ),
               const SizedBox(height: 10.0),

               /// Shop Reply
               ReadMoreText(
                 carReview.shopComment ?? '',
                 trimLines: 3,
                 colorClickableText: Colors.blue,
                 trimMode: TrimMode.Line,
                 trimExpandedText: '  show less',
                 moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                 lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[700]),
               ),
             ],
           ),
         ),
       ),
     ],
   );
  }
}