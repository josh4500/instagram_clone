import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/sizing.dart';
import 'package:instagram_clone/features/settings/presentation/widget/personal_info_tile_button.dart';

class PersonalInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Personal information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'Provide your personal information, even if the account is used for a business, a pet or something else. This won\'t be part of your public profile.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  YMargin(8),
                  PersonalInfoTileButton(
                    onTap: () {},
                    title: 'Email address',
                    subTitle: 'amaterasu@gmail.com',
                  ),
                  Divider(),
                  YMargin(8),
                  PersonalInfoTileButton(
                    onTap: () {},
                    title: 'Phone number',
                    subTitle: '+23491664520',
                  ),
                  Divider(),
                  YMargin(8),
                  PersonalInfoTileButton(
                    onTap: () {},
                    title: 'Date of birth',
                    subTitle: '12 Aug 2021',
                    trailing: 'Update on Facebook',
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
