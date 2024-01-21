import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
          
      // 작성된 코드 영역 시작
      
      // MethodChannel 연결
      let controller = window?.rootViewController as! FlutterViewController
      // flutter와 통신하기 위해 EventChannel 생성
      let randomNumberChannel = FlutterEventChannel(name: "random_number_channel", binaryMessenger: controller.binaryMessenger)
      //  Handler 작성
      let randomNumberStreamHandler = RandomNumberStreamHandler()

      // setStreamHandler 사용해서 Handler 세팅
      randomNumberChannel.setStreamHandler(randomNumberStreamHandler)
      // 작성된 코드 영역 끝
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class RandomNumberStreamHandler: NSObject, FlutterStreamHandler{
    var sink: FlutterEventSink?
    var timer: Timer?

    // Stream 을 받기위해 sink 사용
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendNewRandomNumber), userInfo: nil, repeats: true)
        return nil
    }
    
    @objc func sendNewRandomNumber() {
        guard let sink = sink else { return }
        
        let randomNumber = Int.random(in: 1..<10)
        sink(randomNumber)
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        timer?.invalidate()
        return nil
    }
}