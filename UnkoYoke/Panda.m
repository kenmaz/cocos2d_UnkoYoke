//
//  Panda.m
//  UnkoYoke
//
//  Created by 松前 健太郎 on 11/10/09.
//  Copyright 2011年 kenmaz.net. All rights reserved.
//

#import "Panda.h"


@implementation Panda

+(id) panda {
    Panda* panda = [[[Panda alloc] initWithPandaImage] autorelease];
    return panda;
}


- (id)initWithPandaImage {
    if ((self = [super initWithFile:@"panda_1.png"])) {
        
        NSMutableArray* frames = [NSMutableArray arrayWithCapacity:2];
        for (int i = 0; i < 2; i++) {
            NSString* filename = [NSString stringWithFormat:@"panda_%d.png", i + 1];
            CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:filename];
            
            CGSize texSize = [texture contentSize];
            CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
            CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
            [frames addObject:frame];
        }
        CCAnimation* anime = [[[CCAnimation alloc] initWithFrames:frames delay:0.5f] autorelease];
        
        CCAnimate* animate = [CCAnimate actionWithAnimation:anime];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
        [self runAction:repeat];
    }
    return self;
}

@end
