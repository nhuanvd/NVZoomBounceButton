//
//  ViewController.m
//  NVZoomBounceButtonSample
//
//  Created by Nhuanvd on 10/8/15.
//  Copyright © 2015 Vu Duc Nhuan. All rights reserved.
//

#import "ViewController.h"
#import "NVZoomBounceButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NVZoomBounceButton *demoBtn;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.demoBtn.tintColor = [UIColor redColor];
    self.demoBtn.zoomViewColor = [UIColor whiteColor];
    self.demoBtn.backgroundColor = [UIColor grayColor];
    
    self.demoBtn.roundedCorner = YES;
    self.demoBtn.zoomViewPadding = 25;
    [self.demoBtn setTitle:@"Gogo" forState:UIControlStateNormal];
    [self.demoBtn setImage:[UIImage imageNamed:@"icEdit"] forState:UIControlStateNormal];
}

- (IBAction)touchUpInside:(id)sender {
    NSLog(@"touchUpInside");
}
- (IBAction)touchUpOutside:(id)sender {
    NSLog(@"touchUpOutside");
}
- (IBAction)touchCancel:(id)sender {
    NSLog(@"touchCancel");
}
- (IBAction)touchDown:(id)sender {
    NSLog(@"touchDown");
}
- (IBAction)touchDownRepeat:(id)sender {
    NSLog(@"touchDownRepeat");
}
- (IBAction)touchDragEnter:(id)sender {
    NSLog(@"touchDragEnter");
}
- (IBAction)touchDragExit:(id)sender {
    NSLog(@"touchDragExit");
}
- (IBAction)touchDragInside:(id)sender {
    NSLog(@"touchDragInside");
}
- (IBAction)touchDragOutside:(id)sender {
    NSLog(@"touchDragOutside");
}
- (IBAction)didEndOnExit:(id)sender {
    NSLog(@"didEndOnExit");
}

@end
