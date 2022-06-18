import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/presentation/widgets/show_alert_dialog.dart';
import 'package:flutter_steps_tracker/features/bottom_navbar/data/models/reward_model.dart';

class RewardsItem extends StatelessWidget {
  final RewardModel reward;

  const RewardsItem({
    Key? key,
    required this.reward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          // color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: reward.imageUrl,
                  fit: BoxFit.cover,
                  height: 80,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        reward.name,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: reward.description,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextSpan(
                              text: ' ${reward.points} Points!',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => showAlertDialog(
                            context,
                            title: 'QR Code',
                            contentWidget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: reward.qrCode,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Scan the QR Code and the points will be taken',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            defaultActionText: 'Done',
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          child: Text(
                            'Earn',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.blue,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
