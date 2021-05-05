#import "Nuttery.h"

@implementation Nuttery

-(id) init {
    return [super init];
}

+(Nuttery*) sharedInstance {
    static Nuttery *instance = nil;

    if (instance == nil) {
        instance = [[Nuttery alloc] init];
    }
    return instance;
}

-(int) nutsPerMouthful {
    return 1;
}

@end


