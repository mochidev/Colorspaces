//
//  ViewController.m
//  Colorspaces
//
//  Created by Dimitri Bouniol on 2/3/18.
//  Copyright © 2018 Mochi Development, Inc. All rights reserved.
//

#import "ViewController.h"
#import "ColorView.h"

@interface ViewController () {
    NSArray<NSNumber *> *brightnessMappings;
}

@property (nonatomic, weak) IBOutlet ColorView *colorView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)updateBrightness:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    brightnessMappings = @[@(0.1),
                           @(0.25),
                           @(0.5),
                           @(1),
                           @(1.1),
                           @(1.2),
                           @(1.3),
                           @(1.4),
                           @(1.5),
                           @(1.6),
                           @(1.7),
                           @(1.8),
                           @(1.9),
                           @(2)];
    
    [_segmentedControl removeAllSegments];
    NSInteger currentSegmentIndex = 0;
    NSInteger selectedSegment = 0;
    for (NSNumber *value in brightnessMappings) {
        [_segmentedControl insertSegmentWithTitle:[NSString stringWithFormat:@"%.0f%%", value.doubleValue*100] atIndex:currentSegmentIndex animated:NO];
        if (value.doubleValue == 1.) selectedSegment = currentSegmentIndex;
        currentSegmentIndex++;
    }
    
    _segmentedControl.selectedSegmentIndex = selectedSegment;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateBrightness:(id)sender
{
    _colorView.brightness = [brightnessMappings objectAtIndex:_segmentedControl.selectedSegmentIndex].doubleValue;
}

@end
