import 'package:auto_access/features/rent/screens/car_review/widget/progress_indicator_and_rating.dart';
import 'package:auto_access/features/rent/screens/car_review/widget/rating_star.dart';
import 'package:auto_access/features/rent/screens/car_review/widget/review_details_container.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utility/constants/sizes.dart';
import '../../controllers/dummy_data.dart';

class CarReviewScreen extends StatelessWidget {
  const CarReviewScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Appbar
      appBar: const RAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Reviews List
              const Text("Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: RSizes.spaceBtwItems),

              /// Overall Car Ratings
              const OverallCarRating(),
              const RRatingBarIndicator(rating: 3.5),
              const Text("50"),
              const SizedBox(height: RSizes.spaceBtwSections),

              /// User Reviews List
              ListView.separated(
                shrinkWrap: true,
                itemCount: DummyData.carReviews.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: RSizes.spaceBtwSections),
                itemBuilder: (_, index) => UserReviewCard(carReview: DummyData.carReviews[index]),
              )
            ],
          ),
        ),
      ),
    );
  }
}