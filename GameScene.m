//
//  GameScene.m
//  UnkoYoke
//
//  Created by 松前 健太郎 on 11/10/08.
//  Copyright 2011年 kenmaz.net. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

+(id) scene {
    CCScene* scene = [CCScene node];
    CCLayer* layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init {
    if ((self = [super init])) {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
        self.isTouchEnabled = YES;
        
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(128, 255, 128, 255)];
        [self addChild:colorLayer];
        
        player = [Panda panda];
        [self addChild:player];
        player.scale = 0.3f;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        float imageHeight = player.boundingBox.size.height;
        player.position = CGPointMake(screenSize.width / 2, (imageHeight / 2) + 50.0f);
        
        unkoFrequency = 3.0f;
        unkos = [[CCArray alloc] init];

        [self scheduleUpdate];
    }
    return self;
}


-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [unkos release];
    [super dealloc];
}

- (void)updateUnkoCount {
    [self removeChildByTag:100 cleanup:YES];
    
    NSString* str = [NSString stringWithFormat:@"Unko Count : %.0f", totalUnkoCounts];
    CCLabelTTF* gameoverLabel = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:32];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    gameoverLabel.position = ccp(screenSize.width / 2, screenSize.height - 32.0f);
    
    [self addChild:gameoverLabel z:0 tag:100];
}

- (void)showGameOver {
    [self unscheduleUpdate];
    
    CCLabelTTF* gameoverLabel = [CCLabelTTF labelWithString:@"GameOver" fontName:@"Marker Felt" fontSize:64];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    gameoverLabel.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:gameoverLabel];
}

-(void) update:(ccTime)delta {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    elapsed += delta;
    if (elapsed >= unkoFrequency) {
        elapsed = 0;
        
        CCSprite* sprite = [CCSprite spriteWithFile:@"pink_unko.png"];
        sprite.scale = 0.2f + 0.4f * CCRANDOM_0_1();
        CGSize unkoSize = sprite.boundingBox.size;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        float x = CCRANDOM_0_1() * screenSize.width;
        sprite.position = CGPointMake(x, screenSize.height + (unkoSize.height / 2));
        CCLOG(@"add unko : %@", sprite);
        [self addChild:sprite];
        
        float unkoSpeed = 1.0f + 2.0f * CCRANDOM_0_1();
        CGPoint dist = CGPointMake(sprite.position.x, -1.0f * (unkoSize.height / 2));
        CCMoveTo* moveTo = [CCMoveTo actionWithDuration:unkoSpeed position:dist];
        [sprite runAction:moveTo];
        
        [unkos addObject:sprite];
        totalUnkoCounts += 1;
        
        if (totalUnkoCounts > 40) {
            unkoFrequency = 0.5f;
        } else if (totalUnkoCounts > 30) {
            unkoFrequency = 1.0f;
        } else if (totalUnkoCounts > 20) {
            unkoFrequency = 1.5f;
        } else if (totalUnkoCounts > 10) {
            unkoFrequency = 2.0f;
        }
        [self updateUnkoCount];
    }

    
    //TODO:場外のunkoを削除
    
    //衝突検知
    float playerWidth = player.boundingBox.size.width;
    for (CCSprite* unko in unkos) {
        float unkoWidth = unko.boundingBox.size.width;
        float maxDistance = playerWidth * 0.4f + unkoWidth * 0.4f;
        float distance = ccpDistance(player.position, unko.position);
        if (maxDistance >= distance) {
            [self showGameOver];
        }
    }
}


#pragma @protocol CCTargetedTouchDelegate <NSObject>

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CCLOG(@"began");
    UITouch* touch = [touches anyObject];
    touchOrigin = [touch locationInView:[touch view]];
    touchOrigin = [[CCDirector sharedDirector] convertToGL:touchOrigin];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint prevPos = touchOrigin;
    touchOrigin = [touch locationInView:[touch view]];
    touchOrigin = [[CCDirector sharedDirector] convertToGL:touchOrigin];
    CGPoint pos = player.position;
    pos.x += touchOrigin.x - prevPos.x;
    player.position = pos;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

/*
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CCLOG(@"began");
    UITouch* touch = [touches anyObject];
    
    CGPoint touchPos = [touch locationInView:[touch view]];
    touchPos = [[CCDirector sharedDirector] convertToGL:touchPos];
    
    CGPoint pos = player.position;
    if (touchPos.x < pos.x) {
        speed = -1;
    } else if (pos.x < touchPos.x) {
        speed = 1;
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    speed = 0;
}
*/
@end
