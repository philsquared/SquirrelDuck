//
//  TBCSingletonInjector.m
//
//  Created by Phil Nash on 08/07/2013.
//  Copyright (c) 2013 Two Blue Cubes Ltd. All rights reserved.
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

// To use this class:
//
// 1. You'll need a class to act as a "fake" version of the singleton you
//    you want to take control of.
// 2. Instantiate an instance of your fake and set it up.
// 3. Call the class method, injectSingleton:intoClass:forSelector:withBlock
//    With the class and method that returns the singleton instance (e.g.
//    [NSUserDefaults class] and @selector(standardUserDefaults), the fake
//    instance, and the code to execute while the singleton is injected.

#import "TBCSingletonInjector.h"

#include <objc/runtime.h>

static id g_injectedSingleton;

@implementation TBCSingletonInjector

+(id) injectedSingleton {
    return g_injectedSingleton;
}

+(void) injectSingleton: (id) injectedSingleton
              intoClass: (Class) originalClass
            forSelector: (SEL)originalSelector
              withBlock: (void (^)(void) ) code {

    Method originalMethod = class_getClassMethod( originalClass, originalSelector );
    Method replacedMethod = class_getClassMethod( [TBCSingletonInjector class], @selector(injectedSingleton)  );

    g_injectedSingleton = injectedSingleton;
    method_exchangeImplementations( originalMethod,  replacedMethod );

    @try {
        code();
    }
    @finally {
        g_injectedSingleton = nil;
        method_exchangeImplementations( originalMethod,  replacedMethod );
    }
}

@end
