//
//  RootViewController.m
//  Test2
//
//  Created by okera on 10/12/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()
- (void)buttonStatusBarPush:(id)sender;
- (void)buttonToolBarPush:(id)sender;
- (void)buttonNaviBarPush:(id)sender;
- (UIBarButtonItem *)barButtonSystemItem:(UIBarButtonSystemItem)systemItem;
- (UIButton *)buildButton:(NSString *)title selector:(SEL)selector frame:(CGRect)frame;
- (void)switchStatusBar:(id)sender;
- (void)switchNaviBar:(id)sender;
- (void)switchToolBar:(id)sender;
- (void)rectLog;
@end


@implementation RootViewController

- (void)dealloc {
	[labelStatusBar_ release];
	[labelNaviBar_ release];
	[labelToolBar_ release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	
	//// ナビゲーションバー
	self.navigationItem.title = @"Height: 44px";
	self.view.backgroundColor = [UIColor redColor];
	[self.navigationController setToolbarHidden:NO];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	self.navigationController.navigationBar.translucent = NO;
	
	
	//// タブバー
	self.navigationController.toolbar.barStyle = UIBarStyleDefault;
	self.navigationController.toolbar.translucent = NO;
	
	
	//// 透過のON/OFF
	translucentStatusBar_ = NO;
	translucentToolBar_   = NO;
	translucentNaviBar_   = NO;
	

	//// ラベルの配置・設定
	NSInteger centerX = self.view.bounds.size.width / 4;
	
	NSInteger labelWidth = 70;
	NSInteger labelHeight = 30;
	NSInteger startLableY = 50;
	
	labelStatusBar_ = [[UILabel alloc] init];
	labelStatusBar_.text = @"NO";
	labelStatusBar_.frame = CGRectMake( centerX - labelWidth/2, 
									    startLableY, 
									    labelWidth, 
 									    labelHeight );
	labelStatusBar_.lineBreakMode = UILineBreakModeCharacterWrap;
	labelStatusBar_.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:labelStatusBar_];
	
	
	labelNaviBar_   = [[UILabel alloc] init];
	labelNaviBar_.text = @"NO";
	labelNaviBar_.frame = CGRectMake( centerX*2 - labelWidth/2, 
									    startLableY, 
									    labelWidth, 
 									    labelHeight );
	labelNaviBar_.lineBreakMode = UILineBreakModeCharacterWrap;
	labelNaviBar_.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:labelNaviBar_];
	
	
	
	labelToolBar_   = [[UILabel alloc] init];
	labelToolBar_.text = @"NO";
	labelToolBar_.frame = CGRectMake( centerX*3 - labelWidth/2, 
									  startLableY, 
									  labelWidth, 
 									  labelHeight );
	labelToolBar_.lineBreakMode = UILineBreakModeCharacterWrap;
	labelToolBar_.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:labelToolBar_];
	
	
	
	//// ボタンの設置・設定
	NSInteger buttonWidth  = 80;
	NSInteger buttonHeight = 70;
	NSInteger buttonBottomPadding = 10;
	NSInteger startButtonY = 90;
	
	NSArray *titles = [NSArray arrayWithObjects:
					   @"statusBar",
					   @"naviBar",
					   @"toolBar",
					   @"statusBar\nnaviBar",
					   @"naviBar\ntoolBar",
					   @"toolBar\nstatusBar",nil];
	

	NSArray *selectors = [NSArray arrayWithObjects:
						  @"buttonStatusBarPush:",
						  @"buttonNaviBarPush:",
						  @"buttonToolBarPush:",
						  @"buttonStatusBarAndNaviBarPush:",
						  @"buttonNaviBarAndToolbarPush:",
						  @"buttonToolBarAndStatusBarPush:",
						  nil
						  ];

	for ( int i = 0; i < [titles count]; i++ ) {
		int row = i % 3 + 1;
		int col = i / 3;
		[self.view addSubview:
		 [self buildButton:[titles objectAtIndex:i]
				  selector:NSSelectorFromString([selectors objectAtIndex:i])
					 frame:CGRectMake( centerX * row - buttonWidth/2,
									   startButtonY + (buttonHeight + buttonBottomPadding) * col,
									   buttonWidth,
									   buttonHeight )
		  ]
		 ];
	}
	
	// ３つ全て同時にオン/オフ
	[self.view addSubview:
	 [self buildButton:@"statusBar\nnaviBar\ntoolBar"
			  selector:@selector(buttonStatusBarAndNaviBarAndToolBarPush:)
				 frame:CGRectMake( centerX * 2 - buttonWidth/2,
								   startButtonY + ( buttonHeight + buttonBottomPadding) * 2, 
								   buttonWidth,
								   buttonHeight )
	  ]
	 ];


	//// タブバーの高さを表示
	UIBarButtonItem *button = [[[UIBarButtonItem alloc] 
								initWithTitle:@"Hieght:44px"
								style:UIBarButtonItemStylePlain
								target:nil
								action:nil] autorelease];
	[self setToolbarItems:[NSArray arrayWithObjects:
						   [self barButtonSystemItem:UIBarButtonSystemItemFlexibleSpace],
						   button,
						   [self barButtonSystemItem:UIBarButtonSystemItemFlexibleSpace],						   
						   nil]];
	
}



#pragma mark -
#pragma mark Builder

- (UIBarButtonItem *)barButtonSystemItem:(UIBarButtonSystemItem)systemItem {
	UIBarButtonItem *button = 
		[[[UIBarButtonItem alloc] 
		  initWithBarButtonSystemItem:systemItem
		  target:nil
		  action:nil] autorelease];
	return button;
}


- (UIButton *)buildButton:(NSString *)title 
				 selector:(SEL)selector
					frame:(CGRect)frame 
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = frame;
	[button setTitle:title
			forState:UIControlStateNormal];
	[button addTarget:self
			   action:selector
	 forControlEvents:UIControlEventTouchUpInside];
	button.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
	button.titleLabel.textAlignment = UITextAlignmentCenter;
	
	return button;
}


#pragma mark -
#pragma mark ButtonSelector

- (void)buttonStatusBarPush:(UIButton*)sender {
	[self switchStatusBar:sender];
	[self rectLog];
}

- (void)buttonNaviBarPush:(UIButton*)sender {
	[self switchNaviBar:sender];
	[self rectLog];
}

- (void)buttonToolBarPush:(UIButton*)sender {
	[self switchToolBar:sender];
	[self rectLog];
}

- (void)buttonStatusBarAndNaviBarPush:(id)sender {
	[self switchStatusBar:sender];
	[self switchNaviBar:sender];
	[self rectLog];
}

- (void)buttonNaviBarAndToolbarPush:(id)sender {
	[self switchNaviBar:sender];
	[self switchToolBar:sender];
	[self rectLog];
}

- (void)buttonToolBarAndStatusBarPush:(id)sender {
	[self switchToolBar:sender];
	[self switchStatusBar:sender];
	[self rectLog];
}

- (void)buttonStatusBarAndNaviBarAndToolBarPush:(id)sender {
	[self switchStatusBar:sender];
	[self switchNaviBar:sender];
	[self switchToolBar:sender];
	[self rectLog];
}



#pragma mark -
#pragma mark switchTranslucent

- (void)switchStatusBar:(id)sender {
	translucentStatusBar_ = !translucentStatusBar_;
	
	[UIApplication sharedApplication].statusBarStyle = 
		translucentStatusBar_ 
		? UIStatusBarStyleBlackTranslucent 
		: UIStatusBarStyleDefault;
	
	labelStatusBar_.text = translucentStatusBar_ ? @"YES" : @"NO";
}

- (void)switchNaviBar:(id)sender {
	translucentNaviBar_ = !translucentNaviBar_;
	
	self.navigationController.navigationBar.barStyle = 
		translucentNaviBar_ 
		? UIBarStyleBlack
		: UIBarStyleDefault;
	
	self.navigationController.navigationBar.translucent = translucentNaviBar_;
	
	labelNaviBar_.text = translucentNaviBar_ ? @"YES" : @"NO";
}


- (void)switchToolBar:(id)sender {
	translucentToolBar_ = !translucentToolBar_;
	
	self.navigationController.toolbar.barStyle = 
		translucentToolBar_ 
		? UIBarStyleBlack
		: UIBarStyleDefault;

	self.navigationController.toolbar.translucent = translucentStatusBar_;
	
	labelToolBar_.text = translucentToolBar_ ? @"YES" : @"NO";
}


- (void)rectLog {
	DNSLogRect(self.view.superview.superview.frame);
	DNSLogRect(self.view.superview.frame);
	DNSLogRect(self.view.bounds);
}


@end
