//
//  EsrcSDK_Face_Wrapper.h
//  ESRC-SDK-iOS
//
//  Created by Hyunwoo Lee on 27/05/2021.
//  Copyright © 2021 ESRC. All rights reserved.
//

#ifndef EsrcSDK_Face_Wrapper_h
#define EsrcSDK_Face_Wrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * ESRC Face wrapper class.
 */
@interface EsrcSDK_Face_Wrapper : NSObject

/**
 * Initializes face detection task.
 *
 * @param protoPath Path of prototxt.
 * @param caffePath Path of caffemodel.
 * @return Returns true if the initialization succeeded. Otherwise, false.
 */
+ (bool) EsrcSDK_Face_InitFaceDetectionTask: (NSString *) protoPath param2: (NSString *) caffePath;

/**
 * Releases face detection task.
 *
 * @return Returns true if the release succeeded. Otherwise, false.
 */
+ (bool) EsrcSDK_Face_ReleaseFaceDetectionTask;

/**
 * Detects face from frame image.
 *
 * @param frame Frame data.
 * @param isDetect Whether face is detected or not.
 * @param bboxArray Bounding box array of detected face.
 * @param bboxFrame Frame data for bounding box of detected face.
 * @param conf Confidence level of detected face.
 */
+ (void) EsrcSDK_Face_FeedFaceDetectionTask: (UIImage *) frame param2: (bool *) isDetect param3: (int *) bboxArray param4: (UIImage **) bboxFrame param5: (double *) conf;

@end

#endif /* EsrcSDK_Face_Wrapper_h */
