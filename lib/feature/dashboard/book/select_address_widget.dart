import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sabay_ka/common/constant/fonts.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/common/utils/size_utils.dart';

class SelectAddressWidget extends StatefulWidget {
  const SelectAddressWidget({super.key, required this.initPosition});

  final GeoPoint initPosition;

  @override
  State<StatefulWidget> createState() => _SelectAddressWidgetState();
}

class _SelectAddressWidgetState extends State<SelectAddressWidget> {
  late TextEditingController textEditingController = TextEditingController();
  late PickerMapController controller = PickerMapController(
    initPosition: widget.initPosition, 
  );

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(textOnChanged);
  }

  void textOnChanged() {
    controller.setSearchableText(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(textOnChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      pickerConfig: const CustomPickerLocationConfig(
        zoomOption: ZoomOption(
          initZoom: 19,
        ),
      ),
      controller: controller,
      showDefaultMarkerPickWidget: true,
      topWidgetPicker: Padding(
        padding: const EdgeInsets.only(
          top: 56,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60.hp,
                    decoration: BoxDecoration(
                      color: CustomTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: CustomTheme.gray,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        left: CustomTheme.symmetricHozPadding, right: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: TextField(
                          style: const TextStyle(
                            fontFamily: Fonts.poppin,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: CustomTheme.lightTextColor,
                          ),
                          controller: textEditingController,
                          onEditingComplete: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            suffix: ValueListenableBuilder<TextEditingValue>(
                              valueListenable: textEditingController,
                              builder: (ctx, text, child) {
                                if (text.text.isNotEmpty) {
                                  return child!;
                                }
                                return const SizedBox.shrink();
                              },
                              child: InkWell(
                                focusNode: FocusNode(),
                                onTap: () {
                                  textEditingController.clear();
                                  controller.setSearchableText("");
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            focusColor: Colors.black,
                            filled: true,
                            hintText: "Search address",
                            fillColor: Colors.white,
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const TopSearchWidget()
          ],
        ),
      ),
      bottomWidgetPicker: Positioned(
        bottom: 12,
        right: 8,
        child: FloatingActionButton(
          onPressed: () async {
            GeoPoint p = await controller.selectAdvancedPositionPicker();
            if (!context.mounted) return;
            Navigator.pop(context, p);
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class TopSearchWidget extends StatefulWidget {
  const TopSearchWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TopSearchWidgetState();
}

class _TopSearchWidgetState extends State<TopSearchWidget> {
  late PickerMapController controller;
  ValueNotifier<GeoPoint?> notifierGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> notifierAutoCompletion = ValueNotifier(false);

  late StreamController<List<SearchInfo>> streamSuggestion = StreamController();
  late Future<List<SearchInfo>> _futureSuggestionAddress;
  String oldText = "";
  Timer? _timerToStartSuggestionReq;
  final Key streamKey = const Key("streamAddressSug");

  @override
  void initState() {
    super.initState();
    controller = CustomPickerLocation.of(context);
    controller.searchableText.addListener(onSearchableTextChanged);
  }

  void onSearchableTextChanged() async {
    final v = controller.searchableText.value;
    if (v.length > 3 && oldText != v) {
      oldText = v;
      if (_timerToStartSuggestionReq != null &&
          _timerToStartSuggestionReq!.isActive) {
        _timerToStartSuggestionReq!.cancel();
      }
      _timerToStartSuggestionReq =
          Timer.periodic(const Duration(seconds: 3), (timer) async {
        await suggestionProcessing(v);
        timer.cancel();
      });
    }
    if (v.isEmpty) {
      await reInitStream();
    }
  }

  Future reInitStream() async {
    notifierAutoCompletion.value = false;
    await streamSuggestion.close();
    setState(() {
      streamSuggestion = StreamController();
    });
  }

  Future<void> suggestionProcessing(String addr) async {
    notifierAutoCompletion.value = true;
    _futureSuggestionAddress = addressSuggestion(
      addr,
      limitInformation: 5,
      locale: 'en_PH'
    );
    _futureSuggestionAddress.then((value) {
      streamSuggestion.sink.add(value);
    });
  }

  @override
  void dispose() {
    controller.searchableText.removeListener(onSearchableTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifierAutoCompletion,
      builder: (ctx, isVisible, child) {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: isVisible ? MediaQuery.of(context).size.height / 4 : 0,
          child: Card(
            child: child!,
          ),
        );
      },
      child: StreamBuilder<List<SearchInfo>>(
        stream: streamSuggestion.stream,
        key: streamKey,
        builder: (ctx, snap) {
          if (snap.hasData) {
            return ListView.builder(
              itemExtent: 50.0,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                    snap.data![index].address.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  onTap: () async {
                    /// go to location selected by address
                    controller.goToLocation(
                      snap.data![index].point!,
                    );

                    /// hide suggestion card
                    notifierAutoCompletion.value = false;
                    await reInitStream();
                    if (!context.mounted) return;
                    FocusScope.of(context).requestFocus(
                      FocusNode(),
                    );
                  },
                );
              },
              itemCount: snap.data!.length,
            );
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Card(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
