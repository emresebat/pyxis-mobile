import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/edit_new_place_controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/models/list_item.dart';
import 'package:plateau/bootstrap/helpers.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class EditNewPlacePage extends NyStatefulWidget<EditNewPlaceController> {
  static RouteView path = ("/edit-new-place", (_) => EditNewPlacePage());

  EditNewPlacePage({super.key}) : super(child: () => _EditNewPlacePageState());
}

class _EditNewPlacePageState extends NyPage<EditNewPlacePage> {
  static const String pageCode = "P3 ";
  Place? _place;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () async {
        var placeId = widget.data() as String;
        var result = await widget.controller.getPlace(placeId);
        setState(() {
          _place = result;
        });
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit New Place"),
          centerTitle: true,
          actions: [Text(pageCode).titleSmall(color: Colors.white)]),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: _place != null
            ? Container(
                padding: const EdgeInsets.all(25),
                child: NyListView.separated(
                  child: (BuildContext context, dynamic data) {
                    var listItem = (data as ListItem);
                    if (listItem.displayWidget != null) {
                      return listItem.displayWidget!;
                    }
                    return ListTile(
                      title: Text(listItem.title).titleMedium(),
                      trailing: Text(listItem.detail ?? '').titleMedium(),
                      onTap: () {
                        if (listItem.pushToWidget == null) {
                          return;
                        }
                        pushTo(listItem.pushToWidget!);
                      },
                    );
                  },
                  data: () {
                    return [
                      ListItem(
                        'Title',
                        displayWidget: Text(_place!.name).titleLarge(),
                      ),
                      ListItem(
                        'Image',
                        displayWidget: SizedBox(
                            height: 250,
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(ImagePlaceholder.get(
                                    _place?.thumbnailUrl, 50, 50,
                                    text: _place?.name)))),
                      ),
                      ListItem(
                        'Map',
                        detail: '${_place?.lat}, ${_place?.lng}',
                      ),
                      ListItem(
                        'Service',
                        detail: 'Add Service',
                      ),
                      ListItem('Edit',
                          displayWidget: Button.primary(
                              text: "Done", onPressed: () async {})),
                    ];
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ))
            : Container(),
      ),
    );
  }
}
