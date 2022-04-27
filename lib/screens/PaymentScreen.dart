import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class PaymentScreen extends StatefulWidget {
  String? sender_mail;
  String? receiver_mail;
  PaymentScreen(this.sender_mail,this.receiver_mail);


  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? Amount;
  TextEditingController Amt=new TextEditingController();
  late Razorpay _razorpay;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    UploadPaymentData();
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!, timeInSecForIosWeb: 4);
  }
  UploadPaymentData() async{

      String username = 'Bufe_Work';
      String password = 'Bufe_Work@123';
      String basicAuth =
          'Basic '+ base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);
      try {
        var requestBody={
          "sender_mail":widget.sender_mail,
          "reciever_mail":widget.receiver_mail,
          "Amount":Amt.text,
          "Date":DateTime.now().toString()
        };
        var response = await http.post(Uri.parse("https://Bufework.com/Api/object/Payment.php"),
            headers: <String, String>{'authorization': basicAuth},
            body: json.encode(requestBody));
        dynamic res = json.decode(response.body.toString());
        print(res);
        //final res= await json.decode(json.encode(response.body.toString()));
        if (response.statusCode == 200) {
          print(res);
          // print(res["body"].length);
          //print();
          if (res["status"]== true) {

            Fluttertoast.showToast(
                msg: res["message"]);


          } else {
            Fluttertoast.showToast(
                msg: res["message"]);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Something Goes Wrong");
        }
      }catch(e){
        Fluttertoast.showToast(msg: "Something goes Wrong");
      }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
  }
  void openCheckout() async {
    var options = {
      'key': 'rzp_test_XM0DX6CGHvt0PQ',
      'amount': int.parse(Amount!)*100,
      'name': 'Employee',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setState(() {
      Amt.text=28800.toString();
    });
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text("Enter the amount that you like to pay"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField (
          controller: Amt,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: 'Enter the Amount You would like to pay',
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
          onChanged: (value){
            setState(() {
              Amount=value;
            });
          },
    ),
      ),
          ElevatedButton(onPressed: (){
            openCheckout();
          }, child: Text("Pay"))
    ],
      ),
    );
  }
}
