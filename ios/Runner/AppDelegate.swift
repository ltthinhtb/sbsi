import UIKit
import Flutter
import FinalSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,ICEkycCameraDelegate {
    var flutterResult: FlutterResult?
    var flutterMethodCall: FlutterMethodCall?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      SaveData.shared().sdTokenId = "dbe4ff86-d763-3bcb-e053-62199f0a9b08"
      SaveData.shared().sdTokenKey = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIbU3eVRT3GHbhc+2rEaCWVRCg+Dm4sJtMSIbgD6lZome5EHAiyWknZPQZvOeFfa09bCJC3vAXHJnjkzrum+TOkCAwEAAQ=="
      SaveData.shared().sdAuthorization = "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkYmU0ZmRlZC05YjZhLTQwZDktZTA1My02MjE5OWYwYWExMWQiLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoieHVhbnBuQHNic2kudm4iLCJzY29wZSI6WyJyZWFkIl0sImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0IiwibmFtZSI6Inh1YW5wbkBzYnNpLnZuIiwidXVpZF9hY2NvdW50IjoiZGJlNGZkZWQtOWI2YS00MGQ5LWUwNTMtNjIxOTlmMGFhMTFkIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiJdLCJqdGkiOiJmYzU4MDM4ZS0xYjE5LTQzZjAtYTJkMC0xNGIwNTgyYjdlMGMiLCJjbGllbnRfaWQiOiJhZG1pbmFwcCJ9.gv9GIcxuJjXwQ0eWVw0IvgnTRnhH3IHrPQicW4RereLSpK6piyAKRJcfOQCZ87hCh_I-GIuKXyAh2Wes4EJiRFTKNUPSGkZFM7ZeFAVQAUy2XXo8yid7pOGZbYshDu8P_p1PvcMQ8zhe-8_y9QsH0v7bQJ22bMM3GDX1gX5UfWYKXLuZMTa5QYAlRBXExCUzXERh2Xenz9vXHDtDR26By_yhpEIjxR9gfyND5Py96ec0C4o8-ClmvnoT6TV69VFgeK3TLwYKjjuxaXVl06lGbVAe3lPxZFtaBUanUeWbtEdf4k3AV4FJPaPQGGvzJQd89VO6oGFx_p_cBtTgYcP_Uw"
      
      let controller : FlutterViewController = window.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(
        name: "com.vnpt.ekyc/sdk", binaryMessenger: controller.binaryMessenger)
      channel.setMethodCallHandler({
          (call:FlutterMethodCall,result:@escaping  FlutterResult) -> Void in
          self.flutterResult = result
          DispatchQueue.main.async {
                          self.startEKYC(controller)
                      }
          
      })
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func startEKYC(_ controller:UIViewController) {
            
        let objCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController
            
            objCamera.isVersion = Pro
        objCamera.isVersionProOval = true
            objCamera.flowType = full
            objCamera.isType = cmt
            objCamera.cameraDelegate = self
            objCamera.stepNow = stepFront
            objCamera.isShowResult = false
            objCamera.isShowHelp = true
            objCamera.isShowTrademark = true
            objCamera.isCheckLivenessCard = true
            objCamera.isCheckMaskFace = true
            objCamera.isAddFace = true
        objCamera.isCompare = true;
            objCamera.isCheckLivenessFace = true
            objCamera.languageApplication = "vi"
            objCamera.isValidatePostcode = true
            objCamera.isSkipVoiceVideo = true
            objCamera.modalPresentationStyle = .fullScreen
            objCamera.modalTransitionStyle = .coverVertical
            controller.present(objCamera, animated: true, completion: nil)
        }
        
        func getInformationCard() -> String {
            let frontImage = SaveData.shared().imageFront as UIImage
            let backImage = SaveData.shared().imageBack as UIImage
            let faceFront = SaveData.shared().imageFaceFar as UIImage
            let fontData = frontImage.jpegData(compressionQuality: 1)
            let backData = backImage.jpegData(compressionQuality: 1)
            let faceData = faceFront.jpegData(compressionQuality: 1)
            
            print("JsonCompareFace: \(SaveData.shared().jsonCompareFace)")

            let milesToPoint = [
                "jsonInfo" :SaveData.shared().jsonInfo,
                "imageFront" : fontData?.base64EncodedString(options: .endLineWithLineFeed) ?? "",
                "imageBack" : backData?.base64EncodedString(options: .endLineWithLineFeed) ?? "",
                "imageFace" : faceData?.base64EncodedString(options: .endLineWithLineFeed) ?? "",
                "netWorkProblem" : SaveData.shared().networkProblem,
                "jsonCompareFace" : SaveData.shared().jsonCompareFace,
                "jsonLivenessFace" : SaveData.shared().jsonLivenessFace,
                "jsonCheckMask" : SaveData.shared().jsonCheckMask,
                "verifyFace" : SaveData.shared().jsonVerifyFace,
                "jsonLivenessFontCard" : SaveData.shared().jsonCheckLivenessFrontCard,
                "jsonLivenessRearCard" : SaveData.shared().jsonCheckLivenessBackCard
            ] as [String : Any]
            let jsonData = try! JSONSerialization.data(withJSONObject: milesToPoint, options:.prettyPrinted)
            let decoded = String(data: jsonData, encoding: .utf8)!
            return decoded
        }
        
        
        func getResult() {
            DispatchQueue.main.async {
                self.flutterResult!(self.getInformationCard())
            }
            
        }
}
