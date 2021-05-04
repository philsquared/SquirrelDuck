//
//  TBCSingletonInjector.h
//
//  Created by Phil Nash on 08/07/2013.
//  Copyright (c) 2013 Two Blue Cubes Ltd. All rights reserved.
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
 
#import <Foundation/Foundation.h>

@interface TBCSingletonInjector : NSObject {}

+(void) injectSingleton: (id) injectedSingleton
              intoClass: (Class) originalClass
            forSelector: (SEL)originalSelector
              withBlock: (void (^)(void) ) code;

@end
