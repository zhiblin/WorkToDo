//
//  Work.h
//  WorkToDo
//
//  Created by by on 13-11-23.
//  Copyright (c) 2013年 pipaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Work : NSManagedObject

@property (nonatomic, retain) NSString * dotext;
@property (nonatomic, retain) NSDate * dodate;
@property (nonatomic, retain) NSDate * donedate;

@end
