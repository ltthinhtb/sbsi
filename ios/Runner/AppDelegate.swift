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
      SaveData.shared().sdAuthorization = "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkYmU0ZmRlZC05YjZhLTQwZDktZTA1My02MjE5OWYwYWExMWQiLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoieHVhbnBuQHNic2kudm4iLCJzY29wZSI6WyJyZWFkIl0sImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0IiwibmFtZSI6Inh1YW5wbkBzYnNpLnZuIiwidXVpZF9hY2NvdW50IjoiZGJlNGZkZWQtOWI2YS00MGQ5LWUwNTMtNjIxOTlmMGFhMTFkIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiJdLCJqdGkiOiI2MWYzMTQ1My00MzUwLTRiOTUtOGY5Zi0wYzhjNDlhY2EwMWIiLCJjbGllbnRfaWQiOiJhZG1pbmFwcCJ9.z0kL1obupUWjyUCMCLz7qjWLaT-hEE7j4sokDLxUZl1UP7AW9sWGPsTCOrICdJOEcNwqWXNCYLDi8xtlk7OQiWlpJhmQu3sBdxyNRaO8oQoiVRpa5agWKBxBdCTkjRVwYKo-nKAT-eUxdpZtYCaZaGl0ZCNz6i24dnXHSBT6v1Q7WKN1UAkasDehVvNP-Ke4XnVXPUDAGLKZkV_9rb8apkbrGYEsQIAjIdBKLeJZPoOM5V3ADYvglNKrANCy6is0jc2-TfgQ4JbDs5jC6Z0qvcfSexvF1sjccyiA7kFlYCouznSfyUpDX4wFMKQyPQ6QFuACP0-1aFCw3C4U55uNbQ"
      
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
