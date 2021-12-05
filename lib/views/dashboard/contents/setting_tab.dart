import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mario_provider/repositories/shared_references/shared_references.dart';
import 'package:mario_provider/utils/common_fun.dart';
import 'package:mario_provider/views/change_password/change_password.dart';
import 'package:mario_provider/views/documents/documents.dart';
import 'package:mario_provider/views/login_register/login_register.dart';
import 'package:mario_provider/views/notifications/notifications.dart';
import 'package:mario_provider/views/policies/policies.dart';
import 'package:mario_provider/views/profile/profile.dart';
import 'package:mario_provider/views/services/services.dart';
import 'package:mario_provider/views/wallet/wallet.dart';
import 'package:mario_provider/common/base.dart';

class SettingTab extends StatelessWidget {
  final Map<String, dynamic> userModel;
  SettingTab(this.userModel);

  @override
  Widget build(BuildContext context) {
    return ProfilePage(this.userModel);
  }
}

class ProfilePage extends StatelessWidget {
  // final ProviderUserProfile providerUserProfile;

  // const ProfilePage({Key key, this.providerUserProfile}) : super(key: key);
  final Map<String, dynamic> userModel;
  ProfilePage(this.userModel);

  @override
  Widget build(BuildContext context) {
    print(this.userModel);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StripContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey.shade200,
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: this.userModel['picture'] ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.person,
                            size: 75,
                          ),
                          width: 75,
                          height: 75,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getFullName(this.userModel['first_name'],
                            this.userModel['last_name']),
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 16,
                          color: const Color(0xff2a2a2b),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        this.userModel['email'],
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 11,
                          color: const Color(0xff7c7d7e),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        this.userModel['mobile'],
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 11,
                          color: const Color(0xff7c7d7e),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          SettingOptions(
            title: "ACCOUNT",
            listOfTiles: [
              SelectionCard(
                title: 'Services',
                // svgIcon: payment,
                iconData: Icons.room_service,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Services())),
              ),
              SelectionCard(
                title: 'Profile',
                // svgIcon: payment,
                iconData: Icons.person,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(this.userModel))),
              ),
              SelectionCard(
                title: 'Documents',
                // svgIcon: payment,
                iconData: Icons.document_scanner_outlined,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Documents())),
              ),
              SelectionCard(
                title: 'Report Issue',
                // svgIcon: payment,
                iconData: Icons.report_problem,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Documents())),
              ),
              SelectionCard(
                title: 'Notifications',
                // svgIcon: notification,
                iconData: Icons.notifications,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage())),
                // context.router.push(NotificationRoute()),
              ),
              SelectionCard(
                title: 'Wallet',
                // svgIcon: notification,
                iconData: Icons.account_balance_wallet,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WalletPage())),
                // context.router.push(WalletRoute()),
              ),
              SelectionCard(
                title: 'Password',
                // svgIcon: notification,
                iconData: Icons.lock_clock,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage())),
                // context.router.push(ChangePasswordRoute()),
              ),
            ],
          ),
          SettingOptions(
            title: "HELP & LEGAL",
            listOfTiles: [
              SelectionCard(
                title: 'Help',
                // svgIcon: payment,
                iconData: Icons.call,
                onTap: () => null,
                // context.router.push(HelpRoute()),
              ),
              SelectionCard(
                title: 'Policies',
                // svgIcon: notification,
                iconData: Icons.policy_rounded,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Policies())),
                // context.router.push(Policies()),
              ),
            ],
          ),
          SettingOptions(
            title: null,
            listOfTiles: [
              SelectionCard(
                title: 'Logout',
                // svgIcon: payment,
                iconData: Icons.logout,
                onTap: () => logout(context),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  logout(BuildContext context) async {
    final SharedReferences _references = new SharedReferences();
    await _references.removeAccessToken();
    await _references.removeUserId();
    await _references.removeCurrency();
    await _references.removeStatus();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginRegisterPage()),
        (route) => false);
  }
}

class SettingOptions extends StatelessWidget {
  final String title;
  final List<Widget> listOfTiles;

  const SettingOptions({Key key, this.title, this.listOfTiles})
      : assert(listOfTiles != null && listOfTiles.length != 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: StripContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title == null
                  ? Container()
                  : Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 11,
                        color: const Color(0xff4a4b4d),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
              title == null ? Container() : SizedBox(height: 8),
              Column(
                  children: listOfTiles.map((v) {
                return Column(
                  children: [
                    v,
                    Divider(
                      height: 1,
                      color: Colors.grey.shade400,
                    ),
                  ],
                );
              }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
