//
//  ViewController.m
//  AutoLayoutPlayground
//
//  Created by Ricardo Pereira on 20/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self doLayout06];
}

- (void)doLayout01
{
    [self.view removeConstraints:self.view.constraints];

    NSDictionary *variables = NSDictionaryOfVariableBindings(_viewDetail, _imageViewBackground);

    //For all
    NSArray *constraints;

    constraints = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[_imageViewBackground]-0-|" options:0 metrics:nil views:variables];

    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-0-[_imageViewBackground]-0-|" options:0 metrics:nil views:variables]];

    [self.view addConstraints:constraints];

    // Detail view
    [_viewDetail setTranslatesAutoresizingMaskIntoConstraints:NO];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageViewBackground]-(<=1)-[_viewDetail(200)]"options:NSLayoutFormatAlignAllCenterX metrics:nil views:variables];
    [self.view addConstraints:constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageViewBackground]-(<=1)-[_viewDetail(200)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:variables];
    [self.view addConstraints:constraints];
}

- (void)doLayout02
{
    // Tentativa de centrar a viewDetail assumindo 200x200
    [self.view removeConstraints:self.view.constraints];

    NSDictionary *variables = NSDictionaryOfVariableBindings(_viewDetail, _imageViewBackground);

    NSDictionary *metrics = @{@"margin": @60.0};

    //For all
    NSArray *constraints;

    constraints = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[_imageViewBackground]-0-|" options:0 metrics:metrics views:variables];

    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-0-[_imageViewBackground]-0-|" options:0 metrics:metrics views:variables]];

    // Detail view
    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-margin-[_viewDetail]-margin-|" options:0 metrics:metrics views:variables]];

    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat: @"V:[_viewDetail(==200)]" options:0 metrics:metrics views:variables]];

    [self.view addConstraints:constraints];
}

- (void)doLayout03
{
    [self.view removeConstraints:self.view.constraints];

    UIView *superview = self.view;

    //For all
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView" : _imageViewBackground}]];

    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView" : _imageViewBackground}]];


    //[_viewDetail setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:_viewDetail
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:_viewDetail
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
}

- (void)doLayout04
{
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=20)-[view(==200)]-(>=20)-|"
                                            options: NSLayoutFormatAlignAllCenterX | NSLayoutFormatAlignAllCenterY
                                            metrics:nil
                                              views:@{@"view" : _viewDetail}];

    [self.view addConstraints:constraints];
}

- (void)doLayout05
{
    [self.view removeConstraints:self.view.constraints];

    UIView *superview = self.view;

    //For all
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView" : _imageViewBackground}]];

    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView" : _imageViewBackground}]];


    UIView *spacer1 = [UIView new];
    spacer1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:spacer1];

    UIView *spacer2 = [UIView new];
    spacer2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:spacer2];

    _viewDetail.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-60-[_viewDetail]-60-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_viewDetail)]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[spacer1][_viewDetail][spacer2(==spacer1)]|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_viewDetail, spacer1, spacer2)]];
}

- (void)doLayout06
{
    // Using Masonry
    [self.view removeConstraints:self.view.constraints];

    UIView *superview = self.view;

    [_imageViewBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    [_viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@200);
        make.centerX.equalTo(_imageViewBackground.mas_centerX);
        make.centerY.equalTo(_imageViewBackground.mas_centerY);
    }];
}

- (void)doLayout07
{
    [self.view removeConstraints:self.view.constraints];

    UIView *superview = self.view;

    // For all
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView" : _imageViewBackground}]];

    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView" : _imageViewBackground}]];


    UIEdgeInsets padding = UIEdgeInsetsMake(60, 60, 60, 60);

    [superview addConstraints:@[

                                //_viewDetail constraints
                                [NSLayoutConstraint constraintWithItem:_viewDetail
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:superview
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:padding.top],

                                [NSLayoutConstraint constraintWithItem:_viewDetail
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:superview
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:padding.left],

                                [NSLayoutConstraint constraintWithItem:_viewDetail
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:superview
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:-padding.bottom],
                                
                                [NSLayoutConstraint constraintWithItem:_viewDetail
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:superview
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:-padding.right],
                                
                                ]];
}

@end
