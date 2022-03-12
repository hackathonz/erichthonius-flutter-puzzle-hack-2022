import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kActionTextButtonsPadding = EdgeInsets.symmetric(
  horizontal: 12.0,
);

class PhotoCropView extends StatelessWidget {
  const PhotoCropView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final cropEditorGlobalKey = LabeledGlobalKey<ExtendedImageEditorState>(
      'photo_crop_editor',
    );

    final actionBarSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height * 0.08,
    );

    final avatarBloc = context.read<AvatarBloc>();

    final photoCropBloc = context.read<PhotoCropBloc>();

    final photoToCrop = ExtendedMemoryImageProvider(
      photoCropBloc.photoBytes,
    );

    return BlocListener<PhotoCropBloc, PhotoCropState>(
      listener: (context, state) {
        if (state is PhotoCropCancel) {
          _onPhotoCropCancelStateReact(context);
        } else if (state is PhotoCropSuccess) {
          _onPhotoCropSuccessStateReact(context, state, avatarBloc);
        }
      },
      child: Container(
        color: cropViewBackgroundColor,
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ExtendedImage(
                  image: photoToCrop,
                  mode: ExtendedImageMode.editor,
                  fit: BoxFit.contain,
                  extendedImageEditorKey: cropEditorGlobalKey,
                  initEditorConfigHandler: (state) {
                    return EditorConfig(
                      lineColor: Colors.transparent,
                      cornerColor: cropViewCornerColor,
                      initCropRectType: InitCropRectType.layoutRect,
                      cropAspectRatio: CropAspectRatios.ratio1_1,
                      editorMaskColorHandler: (context, pointerDown) {
                        return pointerDown
                            ? cropViewMaskColorDisabled
                            : cropViewMaskColorPressed;
                      },
                    );
                  },
                ),
              ),
              Container(
                child: Stack(
                  children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: _kActionTextButtonsPadding,
                          child: SwapItTextButton(
                            text: localizations.cancel,
                            onPressed: () {
                              photoCropBloc.add(
                                CancelPhotoCropStarted(),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: _kActionTextButtonsPadding,
                          child: SwapItTextButton(
                            text: localizations.done,
                            onPressed: () {
                              photoCropBloc.add(
                                PerformPhotoCropStarted(
                                  photoBytes: cropEditorGlobalKey
                                      .currentState!.rawImageData,
                                  rotation: cropEditorGlobalKey
                                      .currentState!.editAction!.rotateRadian,
                                  section: cropEditorGlobalKey.currentState!
                                      .getCropRect()!,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left:
                                actionBarSize.width / 2 - kIconPrimarySize / 2,
                          ),
                          child: GestureDetector(
                            child: Container(
                              color: Colors.transparent,
                              height: actionBarSize.height,
                              child: const Icon(
                                SwapItIcons.rotate,
                                color: iconBaseColor,
                              ),
                            ),
                            onTap: () {
                              cropEditorGlobalKey.currentState?.rotate(
                                right: true,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                width: actionBarSize.width,
                height: actionBarSize.height,
                color: cropViewActionsBaseColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPhotoCropCancelStateReact(final BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onPhotoCropSuccessStateReact(
    final BuildContext context,
    final PhotoCropSuccess state,
    final AvatarBloc avatarBloc,
  ) {
    Navigator.of(context).pop();

    avatarBloc.add(
      NewPersonalPhotoSelected(
        photoBytes: state.photoBytes,
      ),
    );
  }
}
