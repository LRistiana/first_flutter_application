import "package:dio/dio.dart";
import "package:first_flutter_application/utils/theme/color_theme.dart";
import "package:first_flutter_application/widgets/panel/dashboard_panel.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_svg/svg.dart";
import "package:get_storage/get_storage.dart";
import "package:logger/logger.dart";
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DasboardPageState();
}
class _DasboardPageState extends State<DashboardPage> {
  final myStorage = GetStorage();
  void goLogOut() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('https://mobileapis.manpits.xyz/api/logout',
              options: Options(
                headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
              ));
      Logger().i(response);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/signIn');
        myStorage.remove('token');
      } else if (response.statusCode == 406) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/signIn');
        myStorage.remove('token');
      }
    } on DioException catch (e) {
      Logger().e(e);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/signIn');
      myStorage.remove('token');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi, Guest !",
                    style: TextStyle(
                        color: GeneralColor.lightColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      goLogOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GeneralColor.lightColor,
                      foregroundColor: BackgroundColor.primaryBackgroundColor,
                      minimumSize: const Size(50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.zero, // Optional: to remove padding
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0), // Optional: to add padding
                      child: Icon(
                        Icons.person,
                        color: GeneralColor.darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SearchInput(),
              const SizedBox(height: 16),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText("Welcome",
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Saving ur money\nfor better future",
                          style: TextStyle(
                              color: GeneralColor.lightColor, fontSize: 12)),
                    ],
                  ),
                  SvgPicture.asset(
                    "lib/images/coin.svg",
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
        const DashboardPanel(),
      ],
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            BackgroundColor.iconBacgroundColor, // Mengatur warna latar belakang
        borderRadius: BorderRadius.circular(50), // Membuat sudut bulat
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 24), // Menambahkan padding horizontal
      child: const TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: GeneralColor.darkColor), // Mengatur warna teks hint
          hintText: 'Search...', // Menampilkan teks hint
          border: InputBorder.none, // Menghapus border
          icon: Icon(Icons.search), // Menampilkan ikon search di sisi kiri
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return GradientColor.primaryGradientRevert.createShader(bounds);
      },
      child: Text(
        text,
        style: style.copyWith(
            color: Colors.white), // Optional: You can adjust the text color
      ),
    );
  }
}
