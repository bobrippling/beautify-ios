//
//  BYViewControllerConfig.h
//  Beautify
//
//  Created by Chris Grant on 06/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYStyle.h"
#import "BYBackgroundImage.h"
#import "BYGradient.h"

@interface BYViewControllerStyle : BYStyle

@property UIColor *backgroundColor;

@property BYBackgroundImage *backgroundImage;

@property BYGradient *backgroundGradient;

+(BYViewControllerStyle*)defaultStyle;

@end