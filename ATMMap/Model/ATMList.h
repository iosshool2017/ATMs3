//
//  ATMList.h
//  ATMMap
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomAnnotation.h"

@interface ATMList : NSObject
-(NSArray *)getAnnotations;
- (void) downloadItems: (CLLocation*)mylocation withCompletionHandler:(void (^)(void))completionHandler;
@end
