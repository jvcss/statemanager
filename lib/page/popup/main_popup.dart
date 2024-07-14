
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/page/dialogs/delete_dialog.dart';
import 'package:statemanager/page/dialogs/logout_dialog.dart';

enum MenuAction { logout, delete, help }

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (action) async {
        switch (action) {
          case MenuAction.logout:
            final shouldLogOut = await showLogoutDialog(context);
            if (shouldLogOut == true && context.mounted) {
              context.read<AppBloc>().add(const AppEventLogout());
            }
            break;
          case MenuAction.delete:
            final shouldDelete = await showDialogDeleteAccout(context);
            if (shouldDelete == true && context.mounted) {
              context.read<AppBloc>().add(const AppEventDeleteAccount());
            }
            break;
          case MenuAction.help:
            //showHelpDialog(context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: MenuAction.logout,
          child: Text('Logout'),
        ),
        const PopupMenuItem(
          value: MenuAction.delete,
          child: Text('Delete Account'),
        ),
        const PopupMenuItem(
          value: MenuAction.help,
          child: Text('Help'),
        ),
      ],
    );
  }
}