import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';

import '../../../providers/profile_picture.provider.dart';

class ProfilePictureUploadWidget extends StatelessWidget {
  final String userId;

  const ProfilePictureUploadWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePictureProvider>(
      builder:
          (context, provider, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(provider, context),
              // SizedBox(height: 16),
              // _buildUploadButtons(context),
            ],
          ),
    );
  }

  Widget _buildProfileImage(
    ProfilePictureProvider provider,
    BuildContext context,
  ) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: ClipOval(
            child:
                provider.isUploading
                    ? Center(child: CircularProgressIndicator())
                    : provider.profilePictureUrl != null
                    ? Image.network(
                      provider.profilePictureUrl!,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder:
                          (context, error, stackTrace) => _buildPlaceholder(),
                    )
                    : _buildPlaceholder(),
          ),
        ),
        if (!provider.isUploading)
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.white, size: 20),
                onPressed: () => _showImageSourceDialog(context),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Icon(Icons.person, size: 80, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildUploadButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Camera'),
            onPressed:
                Provider.of<ProfilePictureProvider>(context).isUploading
                    ? null
                    : () => _pickImage(context, ImageSource.camera),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.photo_library),
            label: Text('Gallery'),
            onPressed:
                Provider.of<ProfilePictureProvider>(context).isUploading
                    ? null
                    : () => _pickImage(context, ImageSource.gallery),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Choose Image Source'),
            backgroundColor: TColors.white,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.camera);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  _pickImage(context, ImageSource.gallery);
                },
                child: Text('Gallery'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
          ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      try {
        if (context.mounted) {
          await Provider.of<ProfilePictureProvider>(
            context,
            listen: false,
          ).uploadProfilePicture(file, userId);

          Flushbar(
            title: "Success",
            message: "Image Uploaded!",
            duration: Duration(seconds: 3),
            backgroundColor: TColors.success,
            flushbarStyle: FlushbarStyle.FLOATING,
            borderRadius: BorderRadius.circular(8.0),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            icon: Lottie.asset(TImages.animatedSuccess, repeat: false),
          ).show(context);
        }
      } catch (e) {
        if (context.mounted) {
          Flushbar(
            title: "Error",
            message: 'An error occurred!',
            duration: Duration(seconds: 3),
            animationDuration: Duration(milliseconds: 590),
            backgroundColor: TColors.error,
            flushbarStyle: FlushbarStyle.FLOATING,
            borderRadius: BorderRadius.circular(8.0),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            icon: Lottie.asset(TImages.animatedError, repeat: false),
          ).show(context);
        }
      }
    }
  }
}
