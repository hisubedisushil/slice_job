import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

import '/constants/app_colors.dart';

String passwordKey = 'password';
String rePasswordKey = 're-password';

final removeRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class RemoveAccountScreen extends ConsumerStatefulWidget {
  const RemoveAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RemoveAccountScreen> createState() =>
      _RemoveAccountScreenState();
}

class _RemoveAccountScreenState extends ConsumerState<RemoveAccountScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      ref.read(removeRef.notifier).removeAccount(
            formValue[passwordKey],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      removeRef,
      (previous, next) {
        if (next is BaseLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpacer(20.h),
                    const CircularProgressIndicator(),
                    verticalSpacer(20.h),
                    const Text('Removing account...'),
                    verticalSpacer(20.h),
                  ],
                ),
              );
            },
          );
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            final data = next.data as String;
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  data,
                ),
              ),
            );
          }
          if (next is BaseError) {
            final err = next.data as Failure;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  err.reason,
                ),
              ),
            );
          }
        }
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Remove Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpacer(15.h),
                    SliceJobPasswordField(
                      fieldKey: passwordKey,
                      hint: 'New Password',
                      errorText: 'Password must have at least 6 characters.',
                      isDense: true,
                    ),
                    verticalSpacer(15.h),
                    SliceJobPasswordField(
                      fieldKey: rePasswordKey,
                      hint: 'Re-type New Password',
                      autoValidation: true,
                      validator: (p0) {
                        final input = (p0 ?? '').trim();
                        if (input.isEmpty || input.length < 5) {
                          return 'Password must have at least 6 characters.';
                        }
                        final originalPassword =
                            (formKey.currentState?.fields[passwordKey]?.value ??
                                    '')
                                .toString()
                                .trim();
                        final isDuplicate = input == originalPassword;

                        if (isDuplicate) {
                          return null;
                        } else {
                          return 'Passwords doesn\'t match!';
                        }
                      },
                      isDense: true,
                    ),
                    verticalSpacer(15.h),
                    Row(
                      children: [
                        Container(
                          height: 56.0,
                          width: 56.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.red,
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Ionicons.arrow_back,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: MaterialButton(
                            onPressed: _submit,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: AppColors.primary,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            minWidth: double.infinity,
                            height: 56.0,
                            elevation: 0.0,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
