import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mevolve/custom_widgets/buttons/cancel_button.dart';
import 'package:mevolve/mevolve_calendar/date_picker_controller.dart';
import 'package:mevolve/mevolve_calendar/models/date_picker_preset.dart';
import 'package:provider/provider.dart';

class PresetsWidget extends StatelessWidget {
  final List<Preset>? presets;

  const PresetsWidget(this.presets, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    return presets == null
        ? Container()
        : Padding(
            padding: EdgeInsets.only(bottom: 25.0.h),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: presets!.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 174 / 35,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemBuilder: (context, index) {
                final presetItem = presets![index];
                return ValueListenableBuilder(
                  valueListenable: datePickerController.selectedPreset,
                  builder: (context, selectedIndex, child) =>
                      (selectedIndex != null && selectedIndex == index)
                          ? ElevatedButton(
                              onPressed: () {},
                              child: FittedBox(child: Text(presetItem.title)))
                          : CancelButton(
                              onPressed: () {
                                datePickerController.selectedPreset.value =
                                    index;
                                datePickerController.selectDateWithDuration(
                                    presetItem.durationInDays);
                              },
                              child: FittedBox(child: Text(presetItem.title))),
                );
              },
            ),
          );
  }
}
