//
//  GameScene.h
//  UnkoYoke
//
//  Created by 松前 健太郎 on 11/10/08.
//  Copyright 2011年 kenmaz.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Panda.h"
#import "Unko.h"

@interface GameScene : CCLayer {
    Panda* player;
    
    CCArray* unkos;
    
    CGPoint touchOrigin;
    CGPoint touchStop;
    int speed;
    
    float unkoFrequency;
    float totalUnkoCounts;
    
    float elapsed;
}
+(id) scene;

@end
