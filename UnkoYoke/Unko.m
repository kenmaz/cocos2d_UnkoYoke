//
//  Unko.m
//  UnkoYoke
//
//  Created by 松前 健太郎 on 11/10/10.
//  Copyright 2011年 kenmaz.net. All rights reserved.
//

#import "Unko.h"


@implementation Unko

+(id) unko {
    return [[[Unko alloc] initWithFile:@"pink_unko.png"] autorelease];
}

@end
