//
//  ToDoListViewController.m
//  WorkToDo
//
//  Created by by on 13-11-23.
//  Copyright (c) 2013年 pipaw. All rights reserved.
//

#import "ToDoListViewController.h"
#import "DSLCalendarView.h"

@interface ToDoListViewController ()<DSLCalendarViewDelegate>

@property (nonatomic, strong) DSLCalendarView *calendarView;

@end

@implementation ToDoListViewController

@synthesize calendarView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarView = [[DSLCalendarView alloc] initWithFrame:CGRectMake(0, 20, 320, 330)];
    self.calendarView.delegate = self;
    
    [self.view  addSubview:self.calendarView];
    
    
}


#pragma mark - DSLCalendarViewDelegate methods

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    if (range != nil) {
        NSLog( @"Selected %d/%d - %d/%d", range.startDay.day, range.startDay.month, range.endDay.day, range.endDay.month);
    }
    else {
        NSLog( @"No selection" );
    }
}

- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    if (NO) { // Only select a single day
        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
    }
    else if (NO) { // Don't allow selections before today
        NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
        
        NSDateComponents *startDate = range.startDay;
        NSDateComponents *endDate = range.endDay;
        
        if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
            return nil;
        }
        else {
            if ([self day:startDate isBeforeDay:today]) {
                startDate = [today copy];
            }
            if ([self day:endDate isBeforeDay:today]) {
                endDate = [today copy];
            }
            
            return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
        }
    }
    
    return range;
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
