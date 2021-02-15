import 'package:carimakan/ui/components/bases/shrink_column.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback openGallery;
  final VoidCallback openCamera;

  const ImagePickerDialog({Key key, this.openGallery, this.openCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.m),
        ),
        padding: const EdgeInsets.fromLTRB(Gap.zero, Gap.m, Gap.zero, Gap.m),
        child: ShrinkColumn.start(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Gap.m),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Choose Your Profile Picture",
                      style: TypoStyle.titleBlack500),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        color: ProjectColor.black1,
                      )),
                ],
              ),
            ),
            SizedBox(height: Gap.m),
            OptionItem(
                title: "Open Camera",
                onTap: () {
                  Navigator.of(context).pop();
                  openCamera();
                }),
            SizedBox(height: Gap.xs),
            OptionItem(
                title: "Open Gallery",
                onTap: () {
                  Navigator.of(context).pop();
                  openGallery();
                }),
          ],
        ),
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OptionItem({Key key, this.onTap, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(Gap.m, Gap.s, Gap.m, Gap.s),
        child: Text(title, style: TypoStyle.mainBlack),
      ),
    );
  }
}
