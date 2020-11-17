import 'package:flutter/cupertino.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';

class DetailPostDescription extends StatefulWidget {
  const DetailPostDescription({
    Key key,
    @required PostDetailDto currentPost,
  })  : _currentPost = currentPost,
        super(key: key);

  final PostDetailDto _currentPost;

  @override
  _DetailPostDescriptionState createState() => _DetailPostDescriptionState();
}

class _DetailPostDescriptionState extends State<DetailPostDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget._currentPost == null ? 0 : 10),
      height: double.infinity,
      margin: EdgeInsets.only(right: 5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colors.accentColor,
      ),
      child: widget._currentPost == null
          ? AnimatedOpacity(
              opacity: 0.6,
              duration: Duration(milliseconds: 500),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: colors.smoothLabelColor,
                ),
                padding: EdgeInsets.all(5),
                child: PlatformProgress(
                  isAnimating: true,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posted on',
                    style: TextStyle(
                      fontFamily: fonts.primaryFF,
                      color: colors.labelColor,
                      fontWeight: fonts.medium,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget._currentPost.description,
                    style: const TextStyle(
                      fontFamily: fonts.primaryFF,
                      color: colors.labelColor,
                      fontWeight: fonts.light,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
