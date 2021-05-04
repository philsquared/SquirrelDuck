#import "Nuttery.h"

@implementation Nuttery

-(id) init {
    return [super init];
}

+(Nuttery*) sharedInstance {
    static Nuttery *sharedInstance = nil;

    if (sharedInstance == nil) {
        sharedInstance = [[Nuttery alloc] init];
    }
    return sharedInstance;
}

-(int) nutsPerMouthful {
    return 1;
}

@end


