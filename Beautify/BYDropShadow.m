//
//  BYDropShadow.m
//  Beautify
//
//  Created by Daniel Allsop on 24/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYDropShadow.h"

@implementation BYDropShadow

-(id)initWithColor:(UIColor*)color andHeight:(float)height{
    if (self = [super init]) {
        self.color = color;
        self.height = height;
    }
    return self;
}

@end