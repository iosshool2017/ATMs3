//
//  ATMList.m
//  ATMMap
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ATMList.h"
#import "CustomAnnotation.h"
#import <Foundation/Foundation.h>

@interface ATMList()
@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@end

@implementation ATMList

-(instancetype)init{
    self = [super init];
    if(self){
      
        
        for(int i=0;i<10;i++)
        {
            CustomAnnotation *item = [[CustomAnnotation alloc] init];
            item.mytitle=[NSString stringWithFormat:@"bank%d",i];
            item.coordinate = CLLocationCoordinate2DMake(37.770+0.01*i, -122.4709);
            [self.mapAnnotations addObject:item];
        }
    }
    return self;
}

-(NSArray *)getAnnotations{
    return self.mapAnnotations;
}
- (void) downloadItems: (CLLocation*)mylocation withCompletionHandler:(void (^)(void))completionHandler{
    self.mapAnnotations = [[NSMutableArray alloc] init];

    NSString *openNow =@"opennow";
    NSString *key =@"AIzaSyD9Mb_3ap4WoW-p2sWewz83G9JuAeB7JlQ";
    //@"AIzaSyBhK49NlVTaBtYtzo0mupr-CxGE0q9IiyI";
                   // AIzaSyBhK49NlVTaBtYtzo0mupr-CxGE0q9IiyI
    //AIzaSyD9Mb_3ap4WoW-p2sWewz83G9JuAeB7JlQ
    NSURL* url=[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&keyword=atm&rankby=distance&%@&key=%@",mylocation.coordinate.latitude,mylocation.coordinate.longitude,openNow,key]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"network error %@",error.userInfo);
        }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if(!json){
            NSLog(@"NSJSONSerialization error %@",error);
        }else{
            if (json[@"error_message"]){
                NSLog(@"error %@",json[@"error_message"]);
            }else{
                for (NSDictionary *dictionary in json[@"results"]) {
                    //[newItems addObject:[SLVATMModel atmWithDictionary:dict]];
                    CustomAnnotation *item = [[CustomAnnotation alloc] init];
                    item.mytitle=dictionary[@"name"];
                    //item.adress = dictionary[@"vicinity"];
                    item.coordinate = CLLocationCoordinate2DMake(37.770, -122.4709);
                    [self.mapAnnotations addObject:item];
                    
                    NSDictionary *coordinate = dictionary[@"geometry"][@"location"];
                    NSString *lat_s=coordinate[@"lat"];
                    double lat_bank=lat_s.doubleValue;
                    NSString *lng_s=coordinate[@"lng"];
                    double lng_bank=lng_s.doubleValue;
                    item.coordinate=CLLocationCoordinate2DMake(lat_bank,lng_bank);
                    [self.mapAnnotations addObject:item];
                }
            
                            completionHandler();
            }
        }
        
    }];
    
    [task resume];

    
    
}

@end
