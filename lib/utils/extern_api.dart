import 'dart:io';

import 'package:app_rhyme/types/music_container.dart';
import 'package:app_rhyme/utils/global_vars.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:app_rhyme/src/rust/api/http_helper.dart' as http;

// 用来给外置音乐api使用
class HttpHelper {
  Future<String> sendRequest(String method, Map<String, String> headers,
      String url, String payload) async {
    return await http.sendRequest(
        method: method, headers: headers, url: url, payload: payload);
  }
}

// 创建一个桥接类，以支持 dart_eval 库的桥接功能。
class $HttpHelper extends HttpHelper with $Bridge {
  // 使用 dart_eval 库的运行时和参数构造一个 $HttpHelper 实例。
  static $HttpHelper $construct(
      Runtime runtime, $Value? target, List<$Value?> args) {
    // 这里不需要构造参数，因为 HttpHelper 没有成员变量。
    return $HttpHelper();
  }

  // 定义类型引用，指向包中的 HttpHelper 类型。
  static const $type = BridgeTypeRef(
      BridgeTypeSpec('package:http_helper/helper.dart', 'HttpHelper'));

  // 定义类声明，包括方法等。
  static const $declaration = BridgeClassDef(BridgeClassType($type),
      constructors: {
        '': BridgeConstructorDef(BridgeFunctionDef(
            returns: BridgeTypeAnnotation($type), params: [], namedParams: []))
      },
      methods: {
        'sendRequest': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(
                    CoreTypes.future, [BridgeTypeRef(CoreTypes.string)])),
                params: [
                  BridgeParameter(
                      'method',
                      BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
                      false),
                  BridgeParameter(
                      'headers',
                      BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.map, [
                        BridgeTypeRef(CoreTypes.string),
                        BridgeTypeRef(CoreTypes.string)
                      ])),
                      false),
                  BridgeParameter(
                      'url',
                      BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
                      false),
                  BridgeParameter(
                      'payload',
                      BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
                      false),
                ],
                namedParams: []),
            isStatic: false)
      },
      getters: {},
      setters: {},
      fields: {},
      bridge: true);

  @override
  $Value? $bridgeGet(String identifier) {
    switch (identifier) {
      case 'sendRequest':
        return $Function((Runtime rt, $Value? target, List<$Value?> args) {
          // 将 _Map<$Value, $Value> 转换为 Map<String, String>
          var headers = <String, String>{};
          var dartEvalMap = args[1] as $Map<$Value, $Value>;
          dartEvalMap.forEach((key, value) {
            headers[key.$value] = value.$value;
          });
          // 调用原始 HttpHelper 类的 sendRequest 方法，并处理返回的 Future。
          return $Future.wrap(super
              .sendRequest(
                  args[0]!.$value, headers, args[2]!.$value, args[3]!.$value)
              .then((response) => $String(response)));
        });
    }
    throw UnimplementedError();
  }

  @override
  void $bridgeSet(String identifier, $Value value) {}
}

class ExternApiEvaler {
  late Runtime runTime;
  ExternApiEvaler(String path) {
    final compile = Compiler();
    compile.defineBridgeClasses([$HttpHelper.$declaration]);
    var file = File(path);
    final bytecode = file.readAsBytesSync().buffer.asByteData();
    runTime = Runtime(bytecode);

    runTime.registerBridgeFunc('package:http_helper/helper.dart', "HttpHelper.",
        $HttpHelper.$construct,
        isBridge: true);
  }

  Future<PlayInfo?> getMusicPlayInfo(
    String source,
    String extra,
  ) async {
    try {
      var resultFuture = runTime.executeLib("package:api/main.dart",
          "getMusicPlayInfo", [$String(source), $String(extra)]) as Future;
      dynamic result = await resultFuture;
      if (result.runtimeType != $null) {
        return PlayInfo.fromObject(result.$reified);
      } else {
        globalTalker.error("[ExternEvaler] Get Result Null.");
        return null;
      }
    } catch (e) {
      globalTalker.error("[ExternEvaler] $e");
      return null;
    }
  }
}
