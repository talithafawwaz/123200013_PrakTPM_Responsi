import 'package:responsi_123200013/view/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:responsi_123200013/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart'; //untuk menyimpan data pengguna secara lokal
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController =
      TextEditingController(); // mengontrol inputan pada TextField.
  final _passwordController = TextEditingController();

  String valueUsername = ""; // menyimpan nilai inputan
  String valuePassword = "";
  String username = ""; //menyimpan nilai yang akan digunakan untuk validasi
  String password = "";
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
              "Sign In",
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
              obscureText: isPasswordVisible
                  ? false
                  : true, //mengatur apakah teks yang dimasukkan dalam TextField akan tersembunyi atau tidak
              style: const TextStyle(color: Colors.grey, fontSize: 14.5),
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
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_usernameController.text != '' &&
                      _passwordController.text != '') {
                    getCredential();
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Sign In Failed"),
                            content:
                                const Text("Username atau password kosong"),
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
                  "Sign In",
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
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
                child: Text("Sign Up"),
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

  getCredential() async {
    //untuk mendapatkan kredensial pengguna dari SharedPreferences dan melakukan validasi.
    // Jika kredensial yang dimasukkan sesuai, status pengguna diatur menjadi true dan pengguna akan diarahkan ke halaman utama (HomePage).
    // Jika kredensial yang dimasukkan tidak sesuai, dialog peringatan akan ditampilkan.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      bool status = sharedPreferences.getBool(
          "status")!; //Mengambil nilai boolean dengan kunci "status" dari SharedPreferences
      print(status);
      if (status == false) {
        //pengguna belum login atau status login sebelumnya adalah false
        setState(() {
          //Mengambil nilai string dari SharedPreferences kemudian disimpan di var masing"
          username = sharedPreferences.getString("username")!;
          password = sharedPreferences.getString("password")!;
        });
        if (username == _usernameController.text &&
            password == _passwordController.text) {
          setState(() {
            sharedPreferences.setBool("status", true);
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Sign In Failed"),
                  content: const Text("Username or Password is wrong"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Close"))
                  ],
                );
              });
        }
      } else {
        // inputan username dan password akan dihapus.
        _usernameController.clear();
        _passwordController.clear();
      }
    });
  }
}
