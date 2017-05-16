//
//  CommonAnnotation.m
//  ATMMap
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView =
    [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([CustomAnnotation class])];
    if (returnedAnnotationView == nil)
    {
        returnedAnnotationView =
        [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                        reuseIdentifier:NSStringFromClass([CustomAnnotation class])];
        
        ((MKPinAnnotationView *)returnedAnnotationView).pinTintColor = [MKPinAnnotationView purplePinColor];
        ((MKPinAnnotationView *)returnedAnnotationView).animatesDrop = YES;
        ((MKPinAnnotationView *)returnedAnnotationView).canShowCallout = YES;
    }
    
    return returnedAnnotationView;
    
}
// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return _mytitle;
}

// optional
- (NSString *)subtitle
{
    return _mysubtitle;
}

@end
