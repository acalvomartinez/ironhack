//
//  QuestionViewController.m
//  Survey
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "QuestionViewController.h"

#import "SurveyDataSource.h"

static NSUInteger const padding = 100;

@interface QuestionViewController ()

@property (nonatomic, strong) SurveyDataSource *dataSource;

@property (nonatomic, strong) UISwitch *option1Switch;
@property (nonatomic, strong) UISwitch *option2Switch;
@property (nonatomic, strong) UISwitch *option3Switch;

@property (nonatomic, strong) UILabel *option1Label;
@property (nonatomic, strong) UILabel *option2Label;
@property (nonatomic, strong) UILabel *option3Label;

@property (nonatomic) NSUInteger questionIndex;


@end

@implementation QuestionViewController


- (instancetype)initWithDataSource:(SurveyDataSource *)dataSource {
    if (self = [super init]) {
        _dataSource = dataSource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildOptions];
    [self buildNextButton];
    [self addSwitchTargetAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = [self.dataSource titleForQuestion:self.questionIndex];
}

- (void)buildOptions {
    
    self.questionIndex = [self.navigationController.viewControllers indexOfObject:self];
    
    NSArray *options = [self.dataSource optionsforQuestion:self.questionIndex];
    
    UIView *optionView1 = [self buildOptionWithLabel:self.option1Label
                                                text:options[0]
                                           andSwitch:self.option1Switch
                                          underFrame:CGRectZero];
    UIView *optionView2 = [self buildOptionWithLabel:self.option2Label
                                                text:options[1]
                                           andSwitch:self.option2Switch
                                          underFrame:optionView1.frame];
    UIView *optionView3 = [self buildOptionWithLabel:self.option3Label
                                                text:options[2]
                                           andSwitch:self.option3Switch
                                          underFrame:optionView2.frame];
}

- (UIView *)buildOptionWithLabel:(UILabel *)label text:(NSString *)text andSwitch:(UISwitch *)optionSwitch underFrame:(CGRect)upperFrame {
    
    CGFloat yPosition;
    if (CGRectEqualToRect(upperFrame, CGRectZero)) {
        yPosition = 100;
    } else {
        yPosition = upperFrame.origin.y + upperFrame.size.height + 8;
    }
    
    CGFloat width = self.view.frame.size.width - 2*padding;
    
    UIView *groupView = [[UIView alloc]initWithFrame:CGRectMake(padding, yPosition, width, 31)];
    
    [groupView addSubview:optionSwitch];
    
    label.text = text;
    label.frame = CGRectMake( optionSwitch.frame.origin.x + optionSwitch.frame.size.width + 20, 0, 200, 31);
    
    [groupView addSubview:label];
    
    [self.view addSubview:groupView];
    
    return groupView;
}

- (void)buildNextButton {
    
    
    if (![self.dataSource isLastQuestion:self.questionIndex]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Next" forState:UIControlStateNormal];
        button.frame = CGRectMake((self.view.frame.size.width/2) - 50, (self.view.frame.size.height/2) - 100 , 100, 40);
        
        [button addTarget:self action:@selector(loadNextSurvey) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
}

- (void)addSwitchTargetAction {
    [self.option1Switch addTarget:self action:@selector(didMarkAnswer:) forControlEvents:UIControlEventValueChanged];
    [self.option2Switch addTarget:self action:@selector(didMarkAnswer:) forControlEvents:UIControlEventValueChanged];
    [self.option3Switch addTarget:self action:@selector(didMarkAnswer:) forControlEvents:UIControlEventValueChanged];
}

- (void)didMarkAnswer:(UISwitch *)optionSwitch {
    NSUInteger questionNumber = 0;
    
    if (optionSwitch == self.option2Switch) {
        questionNumber = 1;
    } else if (optionSwitch == self.option3Switch) {
        questionNumber = 2;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didAnswer" object:self userInfo:@{@"question":@(questionNumber)}];
}

- (void)loadNextSurvey {
    QuestionViewController *nextQuestionViewController = [[QuestionViewController alloc] initWithDataSource:self.dataSource];
    [self.navigationController pushViewController:nextQuestionViewController animated:YES];
}

- (UISwitch *)option1Switch {
    if (!_option1Switch) {
        _option1Switch = [UISwitch new];
    }
    return _option1Switch;
}

- (UISwitch *)option2Switch {
    if (!_option2Switch) {
        _option2Switch = [UISwitch new];
    }
    return _option2Switch;
}

- (UISwitch *)option3Switch {
    if (!_option3Switch) {
        _option3Switch = [UISwitch new];
    }
    return _option3Switch;
}

- (UILabel *)option1Label {
    if (!_option1Label) {
        _option1Label = [UILabel new];
    }
    return _option1Label;
}


- (UILabel *)option2Label {
    if (!_option2Label) {
        _option2Label = [UILabel new];
    }
    return _option2Label;
}

- (UILabel *)option3Label {
    if (!_option3Label) {
        _option3Label = [UILabel new];
    }
    return _option3Label;
}


@end
