//
//  CommonAnnotation.h
//  ATMMap
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>


@property (nonatomic, readwrite) NSString *mytitle;
@property (nonatomic, strong) NSString *mysubtitle;
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation;

@end
