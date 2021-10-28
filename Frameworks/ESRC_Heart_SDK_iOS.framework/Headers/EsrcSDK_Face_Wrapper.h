//
//  EsrcCV_Face_Wrapper.h
//  ESRC-Heart-SDK-iOS
//
//  Created by Hyunwoo Lee on 27/05/2021.
//  Copyright © 2021 ESRC. All rights reserved.
//

#ifndef EsrcSDK_Face_Wrapper_h
#define EsrcSDK_Face_Wrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EsrcSDK_Face_Wrapper : NSObject

+ (bool) EsrcSDK_Face_InitFaceDetectionTask: (NSString *) protoPath param2: (NSString *) caffePath;
+ (bool) EsrcSDK_Face_ReleaseFaceDetectionTask;
+ (void) EsrcSDK_Face_FeedFaceDetectionTask: (UIImage *) frame param2: (UIImage **) faceFrame param3: (int *) face param4: (bool *) isDetect param5: (double *) conf;

@end

#endif /* EsrcSDK_Face_Wrapper_h */
