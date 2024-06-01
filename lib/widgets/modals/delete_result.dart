import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeleteSuccess extends StatelessWidget {
  const DeleteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      insetPadding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: const Color.fromRGBO(215, 252, 112, 1),
        ),
        height: 330,
        width: 290,
        child:  Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/images/oke.svg',
                semanticsLabel: 'Success Image',
                height: 140,
                width: 140,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Delete Success",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),
              ),
               const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {Navigator.pop(context);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize:
                        const Size(250, 60), // Width unconstrained, height 40
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  child: const Text(
                        'Close',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                ),
            ],
          ),
        ),
      ),
    );
  }
}
