//
//  SecondViewController.m
//  NVZoomBounceButtonSample
//
//  Created by Nhuanvd on 10/17/15.
//  Copyright © 2015 Vu Duc Nhuan. All rights reserved.
//

#import "SecondViewController.h"
#import "NVZoomBounceButton.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet NVZoomBounceButton *backBtn;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backBtn.tintColor = [UIColor blueColor];
    self.backBtn.zoomViewColor = [UIColor whiteColor];
    self.backBtn.backgroundColor = [UIColor grayColor];
    
    [self.backBtn setTitle:@"Back" forState:UIControlStateNormal];
}

- (IBAction)touchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
