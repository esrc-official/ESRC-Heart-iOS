//
//  EsrcSDK_Heart_Wrapper.h
//  ESRC-Heart-SDK-iOS
//
//  Created by Hyunwoo Lee on 27/05/2021.
//  Copyright © 2021 ESRC. All rights reserved.
//

#ifndef EsrcSDK_Heart_Wrapper_h
#define EsrcSDK_Heart_Wrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * ESRC Heart wrapper class.
 */
@interface EsrcSDK_Heart_Wrapper : NSObject

/**
 * Initializes remote hr task.
 *
 * @param enableRemoteHR Whether estimate remote hr or not.
 * @param enableHRV Whether analyze HRV or not.
 * @return Returns true if the initialization succeeded. Otherwise, false.
 */
+ (bool) EsrcSDK_Heart_InitRemoteHRTask: (bool) enableRemoteHR param2: (bool) enableHRV;

/**
 * Releases remote hr task.
 *
 * @return Returns true if the release succeeded. Otherwise, false.
 */
+ (bool) EsrcSDK_Heart_ReleaseRemoteHRTask;

/**
 * Estimates remote hr and analyzes HRV from face image.
 *
 * @param bboxFrame data for bounding box of detected face.
 * @param isUpdateOnHR Whether estimate remote hr or not.
 * @param progressRatioOnHR Progress on remote hr.
 * @param hr Estimated remote hr.
 * @param snr Signal to noise ratio.
 * @param isUpdateOnHRV Whether analyze HRV or not.
 * @param progressRatioOnHRV Progress on HRV.
 * @param hrv Analyzed HRV.
 * @param ppiCount PPI count.
 */
+ (void) EsrcSDK_Heart_FeedRemoteHRTask: (UIImage *) bboxFrame param2: (bool *) isUpdateOnHR param3: (double *) progressRatioOnHR param4: (double *) hr param5: (double *) snr param6: (bool *) isUpdateOnHRV param7: (double *) progressRatioOnHRV param8: (double *) hrv param9: (int *) ppiCount;

/**
 * Initializes engagement recognition task.
 *
 * @return Returns true if the initialization succeeded. Otherwise, false.
 */
+ (bool) EsrcSDK_Heart_InitEngagementRecognitionTask;

/**
 * Releases engagement recognition task.
 *
 * @return Returns true if the release succeeded. Otherwise, false.
 */
+ (bool) EsrcSDK_Heart_ReleaseEngagementRecognitionTask;

/**
 * Recognizes engagement from heart rate (Time domain).
 *
 * @param hr Heart rate.
 * @param score Score of engagement.
 * @param probs Probabilities of engagement.
 * @param emotion Emotion of engagement.
 */
+ (void) EsrcSDK_Heart_FeedEngagementRecognitionTimeDomainTask: (double) hr param2: (int *) score param3: (double *) probs param4: (int *) emotion;

/**
 * Recognizes engagement from HRV (Frequency domain).
 *
 * @param hrv HRV.
 * @param score Score of engagement.
 * @param probs Probabilities of engagement.
 * @param emotion Emotion of engagement.
 */
+ (void) EsrcSDK_Heart_FeedEngagementRecognitionFrequencyDomainTask: (double *) hrv param2: (int *) score param3: (double *) probs param4: (int *) emotion;

@end

#endif /* EsrcSDK_Heart_Wrapper_h */
