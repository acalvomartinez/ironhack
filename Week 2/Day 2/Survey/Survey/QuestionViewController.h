//
//  QuestionViewController.h
//  Survey
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SurveyDataSource;

@interface QuestionViewController : UIViewController



- (instancetype)initWithDataSource:(SurveyDataSource *)dataSource;

@end
