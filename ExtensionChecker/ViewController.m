//
//  ViewController.m
//  ExtensionChecker
//
//  Created by 宗太郎 松本 on 12/03/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic) NSInteger okCount;
@property (nonatomic) NSInteger ngCount;
@property (nonatomic, strong) NSTimer* testTimer;

- (void)runTest:(id)userInfo;
- (void)updateStat;

@end

@implementation ViewController

@synthesize startDate;
@synthesize okCount;
@synthesize ngCount;
@synthesize testTimer;

@synthesize URLTextField;
@synthesize statusLabel;
@synthesize statTextView;
@synthesize errorsTextView;
@synthesize timeoutLabel;
@synthesize timeoutStepper;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	[self setURLTextField:nil];
	[self setStatusLabel:nil];
	[self setStatTextView:nil];
	[self setErrorsTextView:nil];
    [self setTimeoutLabel:nil];
    [self setTimeoutStepper:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self startButtonTap:nil];
	
	self.testTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(runTest:) userInfo:nil repeats:YES];
	
	self.statusLabel.text = @"Starting ......";
	self.statTextView.text = @"";
	self.errorsTextView.text = @"";
	
	self.timeoutStepper.value = 3;
	self.timeoutLabel.text = @"3";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)runTest:(id)userInfo {
	NSURL* url = [NSURL URLWithString:self.URLTextField.text];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setTimeoutInterval:self.timeoutStepper.value];
	
	self.statusLabel.text = @"Sending Request...";
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError * error) {
		if (error) {
			self.ngCount = self.ngCount + 1;
			self.statusLabel.text = @"Test Failure!!!!!";
			self.errorsTextView.text = [NSString stringWithFormat:@"%@\n%@\n----\n\n%@",
										[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle],
										[error description], self.errorsTextView.text];
		} else {
			self.okCount = self.okCount + 1;
			self.statusLabel.text = @"Test success!";
		}
		[self updateStat];
	}];
}

-(void)updateStat {
	NSMutableString* text = [NSMutableString string];
	
	[text appendFormat:@"Started at %@\n", [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle]];
	[text appendFormat:@"Test success:\t%d\n", self.okCount];
	[text appendFormat:@"Test failed:\t%d\n", self.ngCount];
	[text appendFormat:@"Test success ratio:\t%f\n", (float)self.okCount/(float)(self.okCount + self.ngCount)];
	
	self.statTextView.text = text;
}

- (IBAction)startButtonTap:(id)sender {
	self.startDate = [NSDate date];
	self.okCount = 0;
	self.ngCount = 0;
}

- (IBAction)timeoutStepperChanged:(id)sender {
	self.timeoutLabel.text = [NSString stringWithFormat:@"%d", (NSInteger)self.timeoutStepper.value];
}

@end
