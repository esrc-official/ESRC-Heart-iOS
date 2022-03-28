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

@interface EsrcSDK_Heart_Wrapper : NSObject

+ (bool) EsrcSDK_Heart_InitRemoteHRTask: (bool) enableRemoteHR param2: (bool) enableHRV;
+ (bool) EsrcSDK_Heart_ReleaseRemoteHRTask;
+ (void) EsrcSDK_Heart_FeedRemoteHRTask: (UIImage *) face param2: (bool *) isUpdateOnHR param3: (double *) progressRatioOnHR param4: (double *) hr param5: (bool *) isUpdateOnHRV param6: (double *) progressRatioOnHRV param7: (double *) hrv;

+ (bool) EsrcSDK_Heart_InitEngagementRecognitionTask;
+ (bool) EsrcSDK_Heart_ReleaseEngagementRecognitionTask;
+ (void) EsrcSDK_Heart_FeedEngagementRecognitionTimeDomainTask: (double) hr param2: (int *) score param3: (double *) probs param4: (int *) engagement;
+ (void) EsrcSDK_Heart_FeedEngagementRecognitionFrequencyDomainTask: (double *) hrv param2: (int *) score param3: (double *) probs param4: (int *) engagement;

@end

#endif /* EsrcSDK_Heart_Wrapper_h */
