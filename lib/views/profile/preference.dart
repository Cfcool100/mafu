import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/section_title.dart';

class Preference extends StatefulWidget {
  const Preference({super.key});
  static String id = '/profile/preference';

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> with RestorationMixin {
  RestorableBool switchValueA = RestorableBool(false);
  RestorableBool switchValueB = RestorableBool(false);

  @override
  String get restorationId => 'switch_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(switchValueA, 'switch_value1');
    registerForRestoration(switchValueB, 'switch_value2');
  }

  @override
  void dispose() {
    switchValueA.dispose();
    switchValueB.dispose();
    super.dispose();
  }

  // bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Gap(30),
              const SectionTitle(title: 'Préférences'),
              const Gap(50),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SwitchListTile(
                      value: switchValueA.value,
                      onChanged: (value) {
                        setState(() {
                          switchValueA.value = value;
                        });
                      },
                      title: Text(
                        'Recevoir les notifications par mail',
                        style: AppTheme.textBlackH6
                            .copyWith(decoration: TextDecoration.none),
                      ),
                      activeTrackColor: Colors.green,
                      inactiveTrackColor: Colors.grey.shade800,
                      thumbColor: const MaterialStatePropertyAll(Colors.white),
                    ),
                    SwitchListTile(
                      value: switchValueB.value,
                      onChanged: (value) {
                        setState(() {
                          switchValueB.value = value;
                        });
                      },
                      title: Text(
                        'Toujours activer la localisation',
                        style: AppTheme.textBlackH6
                            .copyWith(decoration: TextDecoration.none),
                      ),
                      activeTrackColor: Colors.green,
                      inactiveTrackColor: Colors.grey.shade800,
                      thumbColor: const MaterialStatePropertyAll(Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
