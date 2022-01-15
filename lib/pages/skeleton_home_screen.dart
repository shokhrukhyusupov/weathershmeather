import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../styles.dart';

class SkeletonHomeScreen extends StatelessWidget {
  const SkeletonHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    SkeletonAvatar(style: kSkeletonAppbarStyle),
                    SizedBox(width: 20),
                    SkeletonAvatar(style: kSkeletonAppbarStyle),
                  ],
                ),
                const SkeletonAvatar(style: kSkeletonAppbarStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SkeletonLine(
                      style: SkeletonLineStyle(
                    width: 150,
                    height: 14,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  )),
                  SizedBox(height: 10),
                  SkeletonLine(
                      style: SkeletonLineStyle(
                    width: 130,
                    height: 10,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  )),
                ],
              ),
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: 87,
                  width: 150,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 198,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: 55,
                        width: 55,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 5),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: 25,
                        height: 6,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: 55,
                        width: 55,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 5),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: 35,
                        height: 6,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: 55,
                        width: 55,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 5),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: 40,
                        height: 6,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SkeletonLine(
                    style: SkeletonLineStyle(
                  height: 20,
                  width: 80,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                )),
                SkeletonLine(
                    style: SkeletonLineStyle(
                  height: 14,
                  width: 120,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, i) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 60,
                      borderRadius: BorderRadius.all(
                        Radius.circular(28),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
