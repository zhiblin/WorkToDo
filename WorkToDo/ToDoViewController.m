//
//  ToDoViewController.m
//  WorkToDo
//
//  Created by by on 13-11-23.
//  Copyright (c) 2013年 pipaw. All rights reserved.
//

#import "ToDoViewController.h"
#import "ToDoListViewController.h"
#import "ToDosViewController.h"

@interface ToDoViewController ()

@property (nonatomic, strong) UIButton *donebutton;

@end

@implementation ToDoViewController


@synthesize donebutton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    donebutton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [donebutton setFrame:CGRectMake(80, 200, 160, 160)];
    [donebutton setTitle:[NSString stringWithFormat:@"打卡"] forState:UIControlStateNormal];
    [donebutton addTarget:self action:@selector(punch) forControlEvents:UIControlEventTouchUpInside];
    [donebutton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:donebutton];
    
    UIButton *info = [UIButton buttonWithType:UIButtonTypeCustom];
    [info setFrame:CGRectMake(10, 30, 30, 30)];
    [info setTitle:[NSString stringWithFormat:@"T"] forState:UIControlStateNormal];
    [info addTarget:self action:@selector(tolist) forControlEvents:UIControlEventTouchUpInside];
    [info setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:info];
    
    UIButton *list = [UIButton buttonWithType:UIButtonTypeCustom];
    [list setFrame:CGRectMake(50, 30, 30, 30)];
    [list setTitle:[NSString stringWithFormat:@"TS"] forState:UIControlStateNormal];
    [list addTarget:self action:@selector(tolists) forControlEvents:UIControlEventTouchUpInside];
    [list setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:list];
    
    
//    NSString *localDate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
//    NSLog(@"date with local timezone is: %@",[[NSDate date] descriptionWithLocale:[NSLocale systemLocale]]);
//    NSString *dategmt = [NSDate date];
//    
//    NSLog(@"%@----%@",localDate,dategmt);
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setAMSymbol:@"AM"];
//    [dateFormatter setPMSymbol:@"PM"];
//    [dateFormatter setDateFormat:@"hh"];
//    
//    NSDate *date = [NSDate date];
//    NSString * s = [dateFormatter stringFromDate:date] ;
//    NSLog(@"s--%@",s);
//    NSString *mydatestr=@"12:00:00";
//    NSDate *mydate=[dateFormatter dateFromString:mydatestr];
//    switch ([[NSDate date] compare:mydate]) {
//    case NSOrderedSame:
//        NSLog(@"same");
//        break;
//    case NSOrderedAscending:
//        NSLog(@"dateday is earlier than mydate");
//        break;
//    case NSOrderedDescending:
//        NSLog(@"dateday is later than mydate");
//        break;
//    default:
//        NSLog(@"Bad date");
//        break;
//    }
    
}

-(void)tolist{
    
    ToDoListViewController *to = [[ToDoListViewController alloc] init];
    
    [self presentViewController:to animated:YES completion:nil];
    
}

-(void)tolists{
    
    ToDosViewController *to = [[ToDosViewController alloc] init];
    
    [self presentViewController:to animated:YES completion:nil];
    
}

-(void)punch{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setAMSymbol:@"AM"];
    [dateFormatter setPMSymbol:@"PM"];
    [dateFormatter setDateFormat:@"hh"];
    
    NSDate *date = [NSDate date];
    NSString * s = [dateFormatter stringFromDate:date];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = delegate.managedObjectContext;
    
    Work *w= [NSEntityDescription insertNewObjectForEntityForName:@"Work" inManagedObjectContext:managedObjectContext];
    
    w.dodate = [NSDate date];
    w.donedate = [NSDate date];
    if ([s intValue] <= 12) {
        
        w.dotext = [NSString stringWithFormat:@"上班签到成功"];
    }
    else{
        
         w.dotext = [NSString stringWithFormat:@"下班签退成功"];
        
    }
   
    NSError *savingError = nil;
    if ([managedObjectContext save:&savingError]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"签到记录失败" delegate:self cancelButtonTitle:@"重来" otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
