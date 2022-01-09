import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_request_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_request_model.dart';
import 'package:bikolayders/services/purchase_lesson_get_hours_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/date_time_with_label.dart';
import 'package:bikolayders/core/widgets/hour_button.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/cubits/purchase_lesson/purchase_lesson_cubit.dart';
import 'package:bikolayders/models/searchLesson/search_lesson_response_model.dart';
import 'package:bikolayders/services/purchase_lesson_service.dart';

class PurchaseLessonPage extends StatefulWidget {
  final SearchLessonResponseData? data;
  const PurchaseLessonPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PurchaseLessonPage> createState() => _PurchaseLessonPageState();
}

class _PurchaseLessonPageState extends State<PurchaseLessonPage> {
  var service = PurchaseLessonService(Dio());

  List<String> selectedHours = [];
  List<String>? busyHours = [];
  DateTime? selectedDate = DateTime(0);
  List<HourButtonWidget> allHourButtons = [];
  bool isLoading = true;

  @override
  void initState() {
    selectedDate = DateTime.now();
    Future.microtask(() => generateButtons());
    super.initState();
    // if (!AuthController.isAuth || AuthController.isUserTeacher) {
    //   Future.microtask(() => Navigator.pushNamed(context, '/'));
    // }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  Future getBusyHours() async {
    busyHours = [];
    var f = DateFormat("yyyy-MM-dd");
    var d = f.format(selectedDate!);
    var service = PurchaseLessonGetHoursService(Dio());
    final response = await service
        .getHours(PurchaseLessonGetHoursRequestModel(d, widget.data?.id ?? -1));
    if (response?.success == true) {
      busyHours = response?.data;
    }
  }

  Future generateButtons() async {
    isLoading = true;
    allHourButtons.clear();
    allHourButtons = List.generate(
      24,
      (index) => HourButtonWidget(
        onPressed: () {
          setState(() {
            var state = allHourButtons[index].state;
            var lblText = allHourButtons[index].lblText;
            switch (state) {
              case HourButtonState.disabled:
                return;
              case HourButtonState.enabled:
                allHourButtons[index].state = HourButtonState.selected;
                if (!selectedHours.contains(lblText)) {
                  selectedHours.add(lblText);
                }
                break;
              case HourButtonState.selected:
                allHourButtons[index].state = HourButtonState.enabled;
                if (selectedHours.contains(lblText)) {
                  selectedHours.remove(lblText);
                }
                break;
              default:
            }
            if (state == HourButtonState.disabled) return;
            if (state == HourButtonState.enabled) {
            } else if (state == HourButtonState.selected) {}
            allHourButtons[index].state = state == HourButtonState.enabled
                ? HourButtonState.selected
                : HourButtonState.enabled;
          });
        },
        state: HourButtonState.enabled,
        lblText: "${NumberFormat("00").format(index)}:00",
      ),
    );
    await checkAvailableHours();
  }

  Future checkAvailableHours() async {
    await getBusyHours();
    selectedHours.clear();
    var now = DateTime.now();
    for (int i = 0; i < allHourButtons.length; i++) {
      int time = int.parse(allHourButtons[i].lblText.replaceAll(":00", ""));
      var b = false;
      for (int j = 0; j < widget.data!.detail!.length; j++) {
        if (widget.data!.detail![j].hour == allHourButtons[i].lblText) {
          b = true;
          break;
        }
      }
      if (busyHours != null && b) {
        b = !busyHours!.contains(allHourButtons[i].lblText);
      }
      if (selectedDate?.day == now.day) {
        allHourButtons[i].state = time > now.hour && b
            ? HourButtonState.enabled
            : HourButtonState.disabled;
      } else {
        allHourButtons[i].state = selectedDate != null && b
            ? HourButtonState.enabled
            : HourButtonState.disabled;
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PurchaseLessonCubit(
        service: service,
      ),
      child: BlocBuilder<PurchaseLessonCubit, PurchaseLessonState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, PurchaseLessonState state) =>
      Scaffold(
        backgroundColor: Styles.colorD,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
            decoration: BoxDecoration(
              color: Styles.colorE,
              border: Border(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: PoppinsText(
                      fntSize: 32,
                      fntWeight: FontWeight.bold,
                      text: widget.data?.name ?? "",
                      txtColor: Colors.white,
                      shadow: Shadow(
                        offset: Offset(-2, 4),
                        color: Colors.black.setAlpha(128),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Styles.colorD,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 60,
                      right: 50,
                      left: 50,
                    ),
                    decoration: BoxDecoration(
                      color: Styles.colorC,
                      border: Border(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: DateTimeWithLabel(
                                selectedDate: selectedDate ?? DateTime.now(),
                                onChanged: (date) {
                                  setState(() {
                                    selectedDate = date;
                                    generateButtons();
                                  });
                                },
                                lblText: "Ders Tarihi",
                              ),
                            ),
                            Visibility(
                              visible: !isLoading,
                              child: Center(
                                child: ResponsiveGridRow(
                                  children: List.generate(
                                    isLoading ? 0 : 24,
                                    (index) => ResponsiveGridCol(
                                      lg: 2,
                                      xs: 6,
                                      md: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: allHourButtons[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 60,
                    left: 60,
                    bottom: 30,
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: PoppinsText(
                            fntSize: 16,
                            fntWeight: FontWeight.bold,
                            text: "Dersi Veren: ${widget.data?.user?.name}",
                            txtColor: Styles.textColorA,
                          ),
                        ),
                        Row(
                          children: [
                            PoppinsText(
                              fntSize: 16,
                              fntWeight: FontWeight.normal,
                              text:
                                  "Toplam : ${selectedHours.length * widget.data!.price!} ₺",
                              txtColor: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: MaterialButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  if (isLoading) return;
                                  isLoading = true;
                                  var f = DateFormat("yyyy-MM-dd");
                                  var d = f.format(selectedDate!);
                                  context
                                      .read<PurchaseLessonCubit>()
                                      .purchaseLesson(
                                        PurchaseLessonRequestModel(
                                            date: d,
                                            hours: selectedHours,
                                            id: widget.data?.id),
                                      )
                                      .then(
                                    (value) {
                                      setState(() {
                                        isLoading = false;
                                        Navigator.pushNamed(
                                            context, "/lessonSearchPage");
                                      });
                                    },
                                  );
                                },
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: const [
                                        WidgetSpan(
                                            child: PoppinsText(
                                                fntSize: 16,
                                                fntWeight: FontWeight.bold,
                                                text: "Satın Al ")),
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.shopping_basket_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
