//
//  ViewController.h
//  ExtensionChecker
//
//  Created by 宗太郎 松本 on 12/03/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextView *statTextView;
@property (weak, nonatomic) IBOutlet UITextView *errorsTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeoutLabel;
@property (weak, nonatomic) IBOutlet UIStepper *timeoutStepper;

- (IBAction)startButtonTap:(id)sender;
- (IBAction)timeoutStepperChanged:(id)sender;

@end
