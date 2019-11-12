package com.example.flutter_plugin_sigmob;

import android.app.Activity;
import android.widget.Toast;

import com.sigmob.windad.WindAdError;
import com.sigmob.windad.WindAdOptions;
import com.sigmob.windad.WindAds;
import com.sigmob.windad.WindAgeRestictedUserStatus;
import com.sigmob.windad.WindConsentStatus;
import com.sigmob.windad.rewardedVideo.WindRewardInfo;
import com.sigmob.windad.rewardedVideo.WindRewardedVideoAd;
import com.sigmob.windad.rewardedVideo.WindRewardedVideoAdListener;
import com.sigmob.windad.rewardedVideo.WindVideoAdRequest;

//广告工具类
public class AdUtil {


    private static Activity mContext;

    public static void setContext(final Activity mContext){
        AdUtil.mContext = mContext;
    }

    public static void init(final String appId, final String apiKey){
        WindAds ads = WindAds.sharedAds();

        //enable or disable debug log ouput
//        ads.setDebugEnable(BuildConfig.DEBUG);

        /*  欧盟 GDPR 支持
         **  WindConsentStatus 值说明:
         **     UNKNOW("0"),  //未知,默认值，根据服务器判断是否在欧盟区，若在欧盟区则判断为拒绝GDPR授权
         **     ACCEPT("1"),  //用户同意GDPR授权
         **     DENIED("2");  //用户拒绝GDPR授权
         */

        ads.setUserGDPRConsentStatus(WindConsentStatus.ACCEPT);

        /*   OCPPA 支持
         *    WindAgeRestictedUserStatus
         *            WindAgeRestrictedStatusUNKNOWN 未知，默认值
         *            WindAgeRestrictedStatusNO 不限制
         *            WindAgeRestrictedStatusYES 有限制
         *    setUserAge 设置用户年龄
         */
        ads.setIsAgeRestrictedUser(WindAgeRestictedUserStatus.WindAgeRestrictedStatusNO);
        //ads.setUserAge(18);

        // start SDK Init with Options（非聚合）
        //ads.startWithOptions(mAct, new WindAdOptions(YOU_APP_ID, YOU_APP_KEY));

        // start SDK Init with Options（聚合,必须传入actvity，否则聚合部分平台无法加载广告）
        ads.startWithOptions(mContext, new WindAdOptions(appId, apiKey));
    }

    public static void loadVideo(String pid){
        final WindRewardedVideoAd windRewardedVideoAd = WindRewardedVideoAd.sharedInstance();

        windRewardedVideoAd.setWindRewardedVideoAdListener(new WindRewardedVideoAdListener() {

            //仅sigmob渠道有回调，聚合其他平台无次回调
            @Override
            public void onVideoAdPreLoadSuccess(String placementId) {
                //Toast.makeText(mContext, "激励视频广告数据返回成功", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("didSuccess", null);
                }
            }
            //仅sigmob渠道有回调，聚合其他平台无次回调
            @Override
            public void onVideoAdPreLoadFail(String placementId) {
//                Toast.makeText(mContext, "激励视频广告数据返回失败", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("didFail", null);
                }
            }

            @Override
            public void onVideoAdLoadSuccess(String placementId) {
//                Toast.makeText(mContext, "激励视频广告缓存加载成功", Toast.LENGTH_SHORT).show();
//                WindVideoAdRequest request = new WindVideoAdRequest(PLACEMENT_ID,"",true,null);
//                windRewardedVideoAd.show(mContext, request);
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("loadSuccess", null);
                }
            }

            @Override
            public void onVideoAdPlayStart(String placementId) {
//                Toast.makeText(mContext, "激励视频广告播放开始", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("playStart", null);
                }
            }

            @Override
            public void onVideoAdPlayEnd(String s) {
//                Toast.makeText(mContext, "激励视频广告播放结束", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("playEnd", null);
                }
            }

            @Override
            public void onVideoAdClicked(String placementId) {
//                Toast.makeText(mContext, "激励视频广告CTA点击事件监听", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("clicked", null);
                }

            }

            //WindRewardInfo中isComplete方法返回是否完整播放
            @Override
            public void onVideoAdClosed(WindRewardInfo windRewardInfo, String placementId) {
//                if(windRewardInfo.isComplete()){
//                    Toast.makeText(mContext, "激励视频广告完整播放，给予奖励", Toast.LENGTH_SHORT).show();
//                }else{
//                    Toast.makeText(mContext, "激励视频广告关闭", Toast.LENGTH_SHORT).show();
//                }
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("closed", null);
                }
            }

            /**
             * 加载广告错误回调
             * WindAdError 激励视频错误内容
             * placementId 广告位
             */
            @Override
            public void onVideoAdLoadError(WindAdError windAdError, String placementId) {
//                Toast.makeText(mContext, "激励视频广告错误", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("didError", null);
                }
            }


            /**
             * 播放错误回调
             * WindAdError 激励视频错误内容
             * placementId 广告位
             */
            @Override
            public void onVideoAdPlayError(WindAdError windAdError, String placementId) {
//                Toast.makeText(mContext, "激励视频广告错误", Toast.LENGTH_SHORT).show();
                if (FlutterPluginSigmobPlugin.channel!=null){
                    FlutterPluginSigmobPlugin.channel.invokeMethod("playError", null);
                }
            }

        });

        boolean needReward = true;
        //placementId 必填
        WindVideoAdRequest request = new WindVideoAdRequest(pid,"",needReward,null);
        windRewardedVideoAd.loadAd(request);
    }

    public static void showVideo(String pid){
        final WindRewardedVideoAd windRewardedVideoAd = WindRewardedVideoAd.sharedInstance();
        WindVideoAdRequest request = new WindVideoAdRequest(pid,"",true,null);
        windRewardedVideoAd.show(mContext, request);
    }
}
