import 'package:flutter/material.dart';
import 'package:flutter_trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:flutter_trust_wallet_core/trust_wallet_core_ffi.dart';

// import 'package:first_app/base_example.dart';
import 'package:convert/convert.dart';
import 'package:flutter_trust_wallet_core/protobuf/bitcoin.pb.dart' as Bitcoin;
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:flutter_trust_wallet_core/protobuf/Solana.pb.dart' as Solana;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Wallet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String mnemonic =
      "horror select baby exile convince sunset outside vehicle write decade powder energy";

  late HDWallet wallet;

  @override
  HDWallet initState() {
    FlutterTrustWalletCore.init();
    super.initState();

    wallet = HDWallet.createWithMnemonic(mnemonic);

    print("Wallet Mnemonic: " + wallet.mnemonic());
    // print("-------------------------");
    // print("Zcash Address: " +
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeZcash));
    // print("Litecoin Address: " +
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeLitecoin));
    // print("Ethereum Address: " +
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum));
    // print("Solana Address: " +
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana));
    // print("Stellar Address: " +
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeStellar));

    // int coin = TWCoinType.TWCoinTypeZcash;
    // final addressZec = wallet.getAddressForCoin(coin);
    // print(addressZec);
    // const toAddress = "t1RTNMRyJhc1UgfvrTSqFP46C5xuyxjJGeR";
    // const changeAddress = "t1RTNMRyJhc1UgfvrTSqFP46C5xuyxjJGeR";
    // final secretPrivateKeyBtc = wallet.getKeyForCoin(coin);
    // final signingInput = Bitcoin.SigningInput(
    //   amount: $fixnum.Int64.parseInt('37000'),
    //   hashType: BitcoinScript.hashTypeForCoin(coin),
    //   toAddress: toAddress,
    //   changeAddress: changeAddress,
    //   byteFee: $fixnum.Int64.parseInt('10'),
    //   coinType: coin,
    //   utxo: [
    //     Bitcoin.UnspentTransaction(
    //       amount: $fixnum.Int64.parseInt('20000'),
    //       outPoint: Bitcoin.OutPoint(
    //         hash: hex
    //             .decode(
    //                 '1b23757cdc023b3ac9f033522abb9f845815b65cce1e25411e8ad950899c0e71')
    //             .reversed
    //             .toList(),
    //         index: 0,
    //         sequence: 4294967295,
    //       ),
    //       script: BitcoinScript.lockScriptForAddress(addressZec, coin)
    //           .data()
    //           .toList(),
    //     ),
    //     Bitcoin.UnspentTransaction(
    //       amount: $fixnum.Int64.parseInt('20000'),
    //       outPoint: Bitcoin.OutPoint(
    //         hash: hex
    //             .decode(
    //                 '7611002ff116fad20ef12ad30010a07d5b25edf37209504dd42a6a4c5c27aa75')
    //             .reversed
    //             .toList(),
    //         index: 0,
    //         sequence: 4294967295,
    //       ),
    //       script: BitcoinScript.lockScriptForAddress(addressZec, coin)
    //           .data()
    //           .toList(),
    //     ),
    //   ],
    //   privateKey: [
    //     secretPrivateKeyBtc.data().toList(),
    //   ],
    // );
    // final transactionPlan = Bitcoin.TransactionPlan.fromBuffer(
    //     AnySigner.signerPlan(signingInput.writeToBuffer(), coin).toList());
    // // logger.d(
    // //     'availableAmount: ${transactionPlan.availableAmount} amount: ${transactionPlan.amount} fee: ${transactionPlan.fee} change: ${transactionPlan.change}');
    // print(
    //     'availableAmount: ${transactionPlan.availableAmount} amount: ${transactionPlan.amount} fee: ${transactionPlan.fee} change: ${transactionPlan.change}');
    // signingInput.plan = transactionPlan;
    // signingInput.amount = transactionPlan.amount;
    // final sign = AnySigner.sign(signingInput.writeToBuffer(), coin);
    // final signingOutput = Bitcoin.SigningOutput.fromBuffer(sign);
    // print(hex.encode(signingOutput.encoded));
    // logger.d(hex.encode(signingOutput.encoded));

    int coin = TWCoinType.TWCoinTypeSolana;
    final addressSol = wallet.getAddressForCoin(coin);
    const toAddress = "3fTR8GGL2mniGyHtd3Qy2KDVhZ9LHbW59rCc7A3RtBWk";
    final secretPrivateKeySol = wallet.getKeyForCoin(coin);
    const blockHash = "4NNbEToEfcexW1wuKpe5gfA3ntqEC6CzC3u4QD96wkCJ";
    final tx = Solana.Transfer(
        recipient: toAddress, value: $fixnum.Int64.parseInt('2000'));
    final signingInput = Solana.SigningInput(
        privateKey: secretPrivateKeySol.data().toList(),
        recentBlockhash: blockHash,
        transferTransaction: tx);
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coin);
    final signingOutput = Solana.SigningOutput.fromBuffer(sign);
    print("Solana Sender Address: $addressSol");
    print("Solana Receiver Address: $toAddress");
    print("Address PrivateKey: " + secretPrivateKeySol.data().toString());
    print("BlockHash: $blockHash");
    print("Amount: 2000");
    print("-------------------------\nEncoded signingOutput: " +
        signingOutput.encoded);

    return wallet;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String zcash = wallet.getAddressForCoin(TWCoinType.TWCoinTypeZcash);
    String litecoin = wallet.getAddressForCoin(TWCoinType.TWCoinTypeLitecoin);
    String ethereum = wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
    String solana = wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
    String stellar = wallet.getAddressForCoin(TWCoinType.TWCoinTypeStellar);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mnemonic:\n$mnemonic',
            ),
            Text(
              '\Zcash:\n$zcash',
              // style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\nLitecoin:\n$litecoin',
              // style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\nEthereum:\n$ethereum',
              // style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\nSolana:\n$solana',
              // style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\nStellar:\n$stellar',
              // style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_call),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
