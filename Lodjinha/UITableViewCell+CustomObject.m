//
//  UITableViewCell+CustomObject.m
//  Pokedex
//
//  Created by Tiago Felisoni Furlanetto on 05/09/13.
//  Copyright (c) 2013 Tiago Furlanetto. All rights reserved.
//

#import "UITableViewCell+CustomObject.h"

#import <objc/runtime.h>

static char kCustomObject;

@implementation UITableViewCell (CustomObject)

@dynamic customObject;

- (void)setCustomObject:(id)customObject
{
    objc_setAssociatedObject(self, &kCustomObject, customObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)customObject
{
    return objc_getAssociatedObject(self, &kCustomObject);
}

@end
