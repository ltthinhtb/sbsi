package com.example.sbsi

import android.content.Intent
import com.vnptit.idg.sdk.activity.VnptIdentityActivity
import com.vnptit.idg.sdk.activity.VnptOcrActivity
import com.vnptit.idg.sdk.activity.VnptPortraitActivity
import com.vnptit.idg.sdk.utils.KeyIntentConstants
import com.vnptit.idg.sdk.utils.KeyResultConstants.*
import com.vnptit.idg.sdk.utils.SDKEnum
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONObject


class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.vnpt.ekyc/sdk"
    private val ACCESS_TOKEN =
        "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkYmU0ZmRlZC05YjZhLTQwZDktZTA1My02MjE5OWYwYWExMWQiLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoieHVhbnBuQHNic2kudm4iLCJzY29wZSI6WyJyZWFkIl0sImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0IiwibmFtZSI6Inh1YW5wbkBzYnNpLnZuIiwidXVpZF9hY2NvdW50IjoiZGJlNGZkZWQtOWI2YS00MGQ5LWUwNTMtNjIxOTlmMGFhMTFkIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiJdLCJqdGkiOiI2MWYzMTQ1My00MzUwLTRiOTUtOGY5Zi0wYzhjNDlhY2EwMWIiLCJjbGllbnRfaWQiOiJhZG1pbmFwcCJ9.z0kL1obupUWjyUCMCLz7qjWLaT-hEE7j4sokDLxUZl1UP7AW9sWGPsTCOrICdJOEcNwqWXNCYLDi8xtlk7OQiWlpJhmQu3sBdxyNRaO8oQoiVRpa5agWKBxBdCTkjRVwYKo-nKAT-eUxdpZtYCaZaGl0ZCNz6i24dnXHSBT6v1Q7WKN1UAkasDehVvNP-Ke4XnVXPUDAGLKZkV_9rb8apkbrGYEsQIAjIdBKLeJZPoOM5V3ADYvglNKrANCy6is0jc2-TfgQ4JbDs5jC6Z0qvcfSexvF1sjccyiA7kFlYCouznSfyUpDX4wFMKQyPQ6QFuACP0-1aFCw3C4U55uNbQ"
    private val TOKEN_ID = "dbe4ff86-d763-3bcb-e053-62199f0a9b08"
    private val TOKEN_KEY =
        "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIbU3eVRT3GHbhc+2rEaCWVRCg+Dm4sJtMSIbgD6lZome5EHAiyWknZPQZvOeFfa09bCJC3vAXHJnjkzrum+TOkCAwEAAQ=="


    private lateinit var _result: MethodChannel.Result


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            _result = result
            when (call.method) {
                "startEKYC" -> {
                    startEKYC()
                }
                "frontEKYC" -> {
                    getOrcFront()
                }
                "rearEKYC" -> {
                    val hashFront = call.argument<String>("hash")
                    getPortrait(hashFront)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    private fun getOrcFront() {
        val intent = Intent(this, VnptOcrActivity::class.java)
        intent.putExtra(KeyIntentConstants.ACCESS_TOKEN, ACCESS_TOKEN)
        intent.putExtra(KeyIntentConstants.TOKEN_ID, TOKEN_ID)
        intent.putExtra(KeyIntentConstants.TOKEN_KEY, TOKEN_KEY)
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            SDKEnum.DocumentTypeEnum.IDENTITY_CARD.value
        )
        intent.putExtra(KeyIntentConstants.SELECT_DOCUMENT, false)
        intent.putExtra(KeyIntentConstants.VERSION_SDK, SDKEnum.VersionSDKEnum.ADVANCED.value)
        intent.putExtra(KeyIntentConstants.SHOW_RESULT, false)
        intent.putExtra(KeyIntentConstants.SHOW_DIALOG_SUPPORT, false)
        intent.putExtra(KeyIntentConstants.CAMERA_FOR_PORTRAIT, SDKEnum.CameraTypeEnum.FRONT.value)
        intent.putExtra(KeyIntentConstants.CHECK_LIVENESS_CARD, false)
        intent.putExtra(KeyIntentConstants.CHANGE_THEME, true)
        //intent.putExtra(KeyIntentConstants.LOGO, "logo.jpg")
        intent.putExtra(KeyIntentConstants.VALIDATE_POSTCODE, true)
        intent.putExtra(KeyIntentConstants.LANGUAGE, SDKEnum.LanguageEnum.VIETNAMESE.value)
        startActivityForResult(intent, 1234)
    }

    private fun startEKYC() {
        val intent = Intent(this, VnptIdentityActivity::class.java)
        intent.putExtra(KeyIntentConstants.ACCESS_TOKEN, ACCESS_TOKEN)
        intent.putExtra(KeyIntentConstants.TOKEN_ID, TOKEN_ID)
        intent.putExtra(KeyIntentConstants.TOKEN_KEY, TOKEN_KEY)
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            SDKEnum.DocumentTypeEnum.IDENTITY_CARD.value
        )
        intent.putExtra(KeyIntentConstants.SELECT_DOCUMENT, false)
        intent.putExtra(KeyIntentConstants.VERSION_SDK, SDKEnum.VersionSDKEnum.ADVANCED.value)
        intent.putExtra(KeyIntentConstants.SHOW_RESULT, false)
        intent.putExtra(KeyIntentConstants.SHOW_DIALOG_SUPPORT, true)
        intent.putExtra(KeyIntentConstants.CAMERA_FOR_PORTRAIT, SDKEnum.CameraTypeEnum.FRONT.value)
        intent.putExtra(KeyIntentConstants.CHECK_LIVENESS_CARD, true)
        intent.putExtra(KeyIntentConstants.ENABLE_GOT_IT, true)
        intent.putExtra(KeyIntentConstants.LIVENESS_ADVANCED, true)
        intent.putExtra(KeyIntentConstants.LIVENESS_FACE, true)
        intent.putExtra(KeyIntentConstants.CHECK_MASKED_FACE, true)

        intent.putExtra(KeyIntentConstants.CHANGE_THEME, true)
        //intent.putExtra(KeyIntentConstants.LOGO, "logo.jpg")
        intent.putExtra(KeyIntentConstants.VALIDATE_POSTCODE, true)
        intent.putExtra(KeyIntentConstants.LANGUAGE, SDKEnum.LanguageEnum.VIETNAMESE.value)
        startActivityForResult(intent, 111)
    }


    private fun getPortrait(hashFront: String?) {
        val intent = Intent(this, VnptPortraitActivity::class.java)
        intent.putExtra(KeyIntentConstants.ACCESS_TOKEN, ACCESS_TOKEN)
        intent.putExtra(KeyIntentConstants.TOKEN_ID, TOKEN_ID)
        intent.putExtra(KeyIntentConstants.TOKEN_KEY, TOKEN_KEY)
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            SDKEnum.DocumentTypeEnum.IDENTITY_CARD.value
        )
        intent.putExtra(KeyIntentConstants.SELECT_DOCUMENT, false)
        intent.putExtra(KeyIntentConstants.VERSION_SDK, SDKEnum.VersionSDKEnum.STANDARD.value)
        intent.putExtra(KeyIntentConstants.SHOW_RESULT, false)
        intent.putExtra(KeyIntentConstants.SHOW_DIALOG_SUPPORT, false)
        intent.putExtra(KeyIntentConstants.CAMERA_FOR_PORTRAIT, SDKEnum.CameraTypeEnum.FRONT.value)
        intent.putExtra(KeyIntentConstants.CHECK_LIVENESS_CARD, true)
        intent.putExtra(KeyIntentConstants.CHANGE_THEME, true)
        intent.putExtra(KeyIntentConstants.HASH_IMAGE_COMPARE, hashFront)
        intent.putExtra(KeyIntentConstants.LANGUAGE, SDKEnum.LanguageEnum.VIETNAMESE.value)
        startActivityForResult(intent, 1024)
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK && data != null) {
            if (requestCode == 1234) {
                val hashFront: String? = data.getStringExtra(HASH_FRONT)
                _result.success(hashFront.toString())
            }
            if (requestCode == 1024) {
                val strDataCompare: String? = data.getStringExtra(COMPARE_RESULT)
                _result.success(strDataCompare.toString())
            }
            if (requestCode == 111) {
                val strDataInfo = data.getStringExtra(INFO_RESULT)
                val imageFront = data.getStringExtra(FRONT_IMAGE)
                val imageRear = data.getStringExtra(REAR_IMAGE)
                val imagePortrait = data.getStringExtra(PORTRAIT_FAR_IMAGE)
                val netWorkProblem = data.getStringExtra(NETWORK_PROBLEM)
                val jsonCompareFace = data.getStringExtra(COMPARE_RESULT)
                val jsonLivenessFace = data.getStringExtra(LIVENESS_RESULT)
                val jsonCheckMask = data.getStringExtra(MASKED_FACE_RESULT)
                val verifyFace = data.getStringExtra(ENCODE_RESULT)
                val jsonLivenessFontCard = data.getStringExtra(LIVENESS_CARD_FRONT_RESULT)
                val jsonLivenessRearCard = data.getStringExtra(LIVENESS_CARD_REAR_RESULT)
                println("link ảnh mặt $imagePortrait")
                val hashMap: HashMap<String, Any?> = hashMapOf()
                hashMap["jsonInfo"] = strDataInfo
                hashMap["imageFront"] = imageFront
                hashMap["imageBack"] = imageRear
                hashMap["imageFace"] = imagePortrait
                hashMap["netWorkProblem"] = netWorkProblem
                hashMap["jsonCompareFace"] = jsonCompareFace
                hashMap["jsonLivenessFace"] = jsonLivenessFace
                hashMap["jsonCheckMask"] = jsonCheckMask
                hashMap["verifyFace"] = verifyFace
                hashMap["jsonLivenessFontCard"] = jsonLivenessFontCard
                hashMap["jsonLivenessRearCard"] = jsonLivenessRearCard
                val str = JSONObject(hashMap).toString()
                _result.success(str)
            }
        } else {
            _result.error("Lỗi", "Lỗi", null)
        }
    }


}



