//
//  NVZoomBounceButton.m
//  NVZoomBounceButtonSample
//
//  Created by Nhuanvd on 10/8/15.
//  Copyright © 2015 Vu Duc Nhuan. All rights reserved.
//

#import "NVZoomBounceButton.h"

@interface NVZoomBounceButton () {
    float zoonInScale;
    BOOL touchedInside;
}

@property (strong, nonatomic) UIView *zoomView;
@property (strong, nonatomic) UILabel *zoomLabel;
@property (strong, nonatomic) UIImageView *zoomImageView;
@property (strong, nonatomic) NSMutableArray *paddingConstraints;

@end

@implementation NVZoomBounceButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Getter/Setter
- (UIView *)zoomView {
    if (!_zoomView) {
        _zoomView = [[UIView alloc] initWithFrame:self.bounds];
        _zoomView.translatesAutoresizingMaskIntoConstraints = NO;
        _zoomView.backgroundColor = [UIColor whiteColor];
    }
    return _zoomView;
}

- (UIImageView *)zoomImageView {
    if (!_zoomImageView) {
        _zoomImageView = [[UIImageView alloc] init];
        _zoomImageView.contentMode = UIViewContentModeCenter;
        _zoomImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _zoomImageView;
}

- (UILabel *)zoomLabel {
    if (!_zoomLabel) {
        _zoomLabel = [[UILabel alloc] init];
        _zoomLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _zoomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _zoomLabel;
}

- (void)setRoundedCorner:(BOOL)roundedCorner {
    _roundedCorner = roundedCorner;
    if (roundedCorner) {
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.zoomView.layer.cornerRadius = self.zoomView.bounds.size.width/2;
    } else {
        self.layer.cornerRadius = 0;
        self.zoomView.layer.cornerRadius = 0;
    }
}

- (void)setZoomViewPadding:(int)zoomViewPadding {
    if (zoomViewPadding == _zoomViewPadding) {
        return;
    }
    _zoomViewPadding = zoomViewPadding;
    for (NSLayoutConstraint *constraint in _paddingConstraints) {
        constraint.constant = zoomViewPadding;
    }
    [self.zoomView setNeedsLayout];
    [self.zoomView layoutIfNeeded];
    if (_roundedCorner) {
        [self setRoundedCorner:_roundedCorner];
    }
}

- (void)setZoomViewColor:(UIColor *)zoomViewColor {
    self.zoomView.backgroundColor = zoomViewColor;
}

- (UIColor *)zoomViewColor {
    return self.zoomView.backgroundColor;
}

#pragma mark Override
- (void)setTintColor:(UIColor *)tintColor {
    self.zoomLabel.textColor = tintColor;
    self.zoomImageView.tintColor = tintColor;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    UIImage *temp = image;
    if (image && self.tintColor) {
        temp = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    self.zoomImageView.image = temp;
    self.zoomImageView.hidden = NO;
    self.zoomLabel.hidden = YES;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    self.zoomLabel.text = title;
    self.zoomLabel.hidden = NO;
    self.zoomImageView.hidden = YES;
}

#pragma mark - Init
- (void) commonInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [super setTitle:@"" forState:UIControlStateNormal];
    [super setImage:nil forState:UIControlStateNormal];
    self.titleLabel.hidden = YES;
    self.imageView.hidden = YES;

    [self.zoomView addSubview:self.zoomLabel];
    [self.zoomView addSubview:self.zoomImageView];
    [self addSubview:self.zoomView];
    [self setupConstraints];

    self.roundedCorner = YES;
    self.zoomViewPadding = 10;
    zoonInScale = 0.5;
}

- (void)setupConstraints {
    NSDictionary *views = @{@"zoomView": self.zoomView, @"zoomLabel": self.zoomLabel, @"zoomImageView": self.zoomImageView};
    _paddingConstraints = [NSMutableArray new];
    [_paddingConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[zoomView]-(0)-|" options:0 metrics:nil views:views]];
    [_paddingConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[zoomView]-(0)-|" options:0 metrics:nil views:views]];
    [self addConstraints:_paddingConstraints];

    [self.zoomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[zoomLabel]-(5)-|" options:0 metrics:nil views:views]];
    [self.zoomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[zoomLabel]-(5)-|" options:0 metrics:nil views:views]];
    
    [self.zoomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[zoomImageView]-(5)-|" options:0 metrics:nil views:views]];
    [self.zoomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[zoomImageView]-(5)-|" options:0 metrics:nil views:views]];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Override touch handle
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchedInside = YES;

    [self.superview bringSubviewToFront:self];
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"transform"];
    ba.fillMode = kCAFillModeForwards;
    ba.removedOnCompletion = NO;
    ba.duration = 0.3;
    ba.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(zoonInScale, zoonInScale, 1)];
    [self.zoomView.layer addAnimation:ba forKey:nil];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        if (!touchedInside) {
            [self sendActionsForControlEvents:UIControlEventTouchDragEnter];
        }
        touchedInside = YES;
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    } else {
        if (touchedInside) {
            [self sendActionsForControlEvents:UIControlEventTouchDragExit];
        }
        touchedInside = NO;
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    float extraScale = self.bounds.size.width/(zoonInScale*self.zoomView.bounds.size.width);
    CABasicAnimation* animExtra = [CABasicAnimation animationWithKeyPath:@"transform"];
    animExtra.fillMode = kCAFillModeForwards;
    animExtra.removedOnCompletion = NO;
    animExtra.duration = 0.3;
    animExtra.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(extraScale, extraScale, 1)];
    
    CABasicAnimation* anim2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim2.fillMode = kCAFillModeForwards;
    anim2.removedOnCompletion = NO;
    anim2.duration = 0.3;
    anim2.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
        [self.zoomView.layer addAnimation:animExtra forKey:nil];

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
            [self.zoomView.layer addAnimation:anim2 forKey:nil];
        } completion:^(BOOL finished) {
            CGPoint location = [[touches anyObject] locationInView:self];
            if (CGRectContainsPoint(self.bounds, location)) {
                [self sendActionsForControlEvents:UIControlEventTouchUpInside];
            } else {
                [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
            }
        }];
    }];
}

@end
