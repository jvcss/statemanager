import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart' /* imports */
    show
        HookWidget,
        useMemoized;
import 'package:image_picker/image_picker.dart' /* imports */
    show
        ImagePicker,
        ImageSource;
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/bloc/app/app_extensions.dart';
import 'package:statemanager/page/popup/main_popup.dart';
import 'package:statemanager/page/storage_image/storage_image_page.dart';

class PhotoGalleryPage extends HookWidget {
  const PhotoGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final imagesRefs = context.watch<AppBloc>().state.firebaseReferences ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (image == null) {
                return;
              }
              if (context.mounted) {
                context.read<AppBloc>().add(
                      AppEventUploadImage(filePathToUpload: image.path),
                    );
              }
            },
            icon: const Icon(Icons.upload_file_outlined),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: imagesRefs.map((img) => StorageImagePage(ref: img)).toList(),
      ),
    );
  }
}
