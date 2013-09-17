//
//  BYViewControllerRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYViewControllerRenderer.h"
#import "BYViewControllerStyle.h"
#import "BYTheme.h"
#import "BYGradient.h"
#import "BYGradientLayer.h"
#import "BYNineBoxedImage_Private.h"
#import "BYStyleRenderer_Private.h"

@implementation BYViewControllerRenderer {
    UIImageView* _backgroundImageView;
    BYGradientLayer* _backgroundGradientLayer;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        [self setup:view theme:theme];
    }
    return self;
}

-(void)setup:(UIViewController*)viewController theme:(BYTheme*)theme {
    // Create the background image and gradient views
    _backgroundImageView = [[UIImageView alloc] initWithFrame:viewController.view.bounds];
   
    // Add to the view]
    [viewController.view addSubview:_backgroundImageView];
    [viewController.view sendSubviewToBack:_backgroundImageView];

    // Hide until required
    _backgroundImageView.hidden = YES;
    
    _backgroundGradientLayer = [[BYGradientLayer alloc] initWithRenderer:self];
    [_backgroundGradientLayer setFrame:viewController.view.bounds];
    [viewController.view.layer insertSublayer:_backgroundGradientLayer atIndex:0];
    [_backgroundGradientLayer setNeedsDisplay];
    
    [self configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.viewControllerStyle) {
        return theme.viewControllerStyle;
    }
    return [BYViewControllerStyle defaultStyle];
}

-(void)configureFromStyle {
    UIViewController* vc = (UIViewController*)self.adaptedView;
    BYViewControllerStyle* style = self.style;
    
    if ([vc class] == [UINavigationController class]){
        for (UIViewController* vcs in ((UINavigationController*)vc).viewControllers) {
            [self redrawViewController:vcs style:style];
        }
    }
    else {
        [self redrawViewController:vc style:style];
    }
}

-(void)redrawViewController:(UIViewController*)vc style:(BYViewControllerStyle*)style {
    BYGradient *backgroundGradient = [self propertyValueForNameWithCurrentState:@"backgroundGradient"];
    BYNineBoxedImage *backgroundImage = [self propertyValueForNameWithCurrentState:@"backgroundImage"];
    UIColor *backgroundColor = [self propertyValueForNameWithCurrentState:@"backgroundColor"];
        
    if (backgroundImage == nil) {
        // Hide the background image view
        _backgroundImageView.hidden = YES;
    }
    else {
        // Update the background image
        _backgroundImageView.hidden = NO;
        _backgroundImageView.frame = vc.view.bounds;
        _backgroundImageView.image = [style.backgroundImage createNineBoxedImage];
    }
    
    if (backgroundColor == nil) {
        // Clear the background color for the main view
        vc.view.backgroundColor = [UIColor clearColor];
    }
    else {
        // Render a color if we have one
        vc.view.backgroundColor = backgroundColor;
    }
   
    if (backgroundGradient.stops.count == 0) {
        // Hide the background gradient view
        _backgroundGradientLayer.hidden = YES;
    }
    else {
        // Render a gradient if we have one
        _backgroundGradientLayer.hidden = NO;
        _backgroundGradientLayer.frame = vc.view.bounds;
        [_backgroundGradientLayer setNeedsDisplay];
    }
}

#pragma mark - Style property setters

-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state {
    [self setPropertyValue:backgroundColor forName:@"backgroundColor" forState:state];
}

-(void)setBackgroundGradient:(BYGradient*)backgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:backgroundGradient forName:@"backgroundGradient" forState:state];
}

-(void)setBackgroundImage:(BYNineBoxedImage*)backgroundImage forState:(UIControlState)state {
    [self setPropertyValue:backgroundImage forName:@"backgroundImage" forState:state];
}

@end