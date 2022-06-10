import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '/constants/app_colors.dart';
import '/constants/app_images.dart';
import '/controllers/authentication_controller.dart';
import '/controllers/test_controller.dart';
import '/modules/login/views/login_view.dart';
import '/modules/register/views/register_view.dart';
import 'test_view.dart';

class TestCategoriesView extends StatelessWidget {
  const TestCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authentication = context.watch<AuthenticationController>();

    if (!authentication.isLoggedIn) {
      return Material(
        color: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          appBar: AppBar(
            title: const Text('Choose A Online Test Category'),
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.lock_closed_outline,
                      size: 60.0,
                      color: AppColors.red,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'To access the page you need to be login. '
                      'Please login if you already a register user or '
                      'register if you are not registered.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginView(),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: AppColors.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 0.0,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterView(),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.transparent,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 0.0,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    final test = context.watch<TestController>();
    final gridWidth = (MediaQuery.of(context).size.width / 2.0) - 24.0;
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Choose A Online Test Category'),
        ),
        body: test.isLoadingCategories
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => test.getTestCategories(),
                child: GridView.builder(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 80.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: gridWidth / (gridWidth + 60.0),
                  ),
                  itemBuilder: (_, index) {
                    final category = test.categories[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TestView(
                              category: category,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: CachedNetworkImage(
                                  imageUrl: category.image ?? '',
                                  fit: BoxFit.fitWidth,
                                  placeholder: (_, __) {
                                    return Icon(
                                      Ionicons.image_outline,
                                      color: AppColors.grey,
                                    );
                                  },
                                  errorWidget: (_, __, ___) {
                                    return Image.asset(
                                      AppImages.icon,
                                      fit: BoxFit.fitWidth,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    category.name ?? '',
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: test.categories.length,
                ),
              ),
      ),
    );
  }
}
