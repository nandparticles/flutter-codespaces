import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangayomi/modules/more/about/providers/check_for_update.dart';
import 'package:mangayomi/modules/more/about/providers/get_package_info.dart';
import 'package:mangayomi/modules/widgets/progress_center.dart';
import 'package:mangayomi/providers/l10n_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = l10nLocalizations(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(l10n!.about),
        ),
        body: ref.watch(getPackageInfoProvider).when(
              data: (data) => SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Image.asset(
                        "assets/app_icons/icon.png",
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                    Column(
                      children: [
                        const Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text('Version'),
                          subtitle: Text(
                            'Beta (${data.version})',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            ref.read(checkForUpdateProvider(
                                context: context, manualUpdate: true));
                          },
                          title: Text(l10n.check_for_update),
                        ),
                        // ListTile(
                        //   onTap: () {},
                        //   title: const Text("What's news"),
                        // ),
                        // ListTile(
                        //   onTap: () {},
                        //   title: const Text('Help translation'),
                        // ),
                        // ListTile(
                        //   onTap: () {},
                        //   title: const Text('Privacy policy'),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _launchInBrowser(Uri.parse(
                                      'https://github.com/kodjodevf/mangayomi'));
                                },
                                icon: const Icon(FontAwesomeIcons.github)),
                            IconButton(
                                onPressed: () {
                                  _launchInBrowser(Uri.parse(
                                      'https://discord.com/invite/EjfBuYahsP'));
                                },
                                icon: const Icon(FontAwesomeIcons.discord))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              error: (error, stackTrace) => ErrorWidget(error),
              loading: () => const ProgressCenter(),
            ));
  }
}

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}
