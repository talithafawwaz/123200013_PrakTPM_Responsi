import 'package:responsi_123200013/view/auth/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController =
      TextEditingController(); // mengontrol inputan pada TextField.
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool isPasswordVisible = false; //mengontrol visibilitas teks pada password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.grey, fontSize: 14.5),
              decoration: InputDecoration(
                  prefixIconConstraints: const BoxConstraints(minWidth: 45),
                  prefixIcon: const Icon(
                    Icons.alternate_email_outlined,
                    color: Colors.grey,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  hintText: 'Enter Email',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.5),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.grey, fontSize: 14.5),
              obscureText: isPasswordVisible
                  ? false
                  : true, //kondisi apakah password akan disembunyikan/tidak
              decoration: InputDecoration(
                  prefixIconConstraints: const BoxConstraints(minWidth: 45),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 22,
                  ),
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 45, maxWidth: 46),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                      size: 22,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Enter Password',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.5),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.grey, fontSize: 14.5),
              decoration: InputDecoration(
                  prefixIconConstraints: const BoxConstraints(minWidth: 45),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  hintText: 'Enter Name',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.5),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_usernameController.text != '' &&
                      _passwordController.text != '') {
                    _register(false);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Sign Up Failed"),
                            content: const Text("Masih ada yang kosong"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Close",
                                      style: TextStyle(color: Colors.grey)))
                            ],
                          );
                        });
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('or',
                style: TextStyle(color: Colors.black, fontSize: 13)),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text("Sign In"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //mendaftarkan pengguna baru dan menyimpan informasi pengguna ke dalam SharedPreferences
  _register(bool value) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); //mendapatkan instansi dr sharedpref
    bool status = value;
    prefs.setBool('status', status);
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);
    prefs.setString('name', _nameController.text);
    prefs
        .commit(); //mengonfirmasi dan menyimpan perubahan ke dalam SharedPreferences

    //mencetak nilai dari sharedpreference
    print(prefs.getString('username'));
    print(prefs.getString('password'));
    print(prefs.getString('name'));
    print(prefs.getBool('status'));
  }
}
