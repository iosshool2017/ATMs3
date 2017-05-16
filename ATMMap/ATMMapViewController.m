//
//  ATMMapViewController.m
//  ATMMap
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ATMMapViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "ATMList.h"

@interface ATMMapViewController () <MKMapViewDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, copy) NSArray *mapAnnotations;

@end

@implementation ATMMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.yellowColor;
    self.title=@"ATMMap";
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 37.786996;
    newRegion.center.longitude = -122.440100;
    newRegion.span.latitudeDelta = 0.2;
    newRegion.span.longitudeDelta = 0.2;
    
    _mapView=[MKMapView new];
    
    [self.mapView setRegion:newRegion animated:YES];
    
    
    self.view=_mapView;
    
    CLLocationDegrees lat=37.770;
    CLLocationDegrees lng=-122.4709;
    
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lng] ;
    
    ATMList *list = [[ATMList alloc] init];
    
    __weak typeof(self) weakself = self;
    [list downloadItems:location withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapAnnotations = [list getAnnotations];
            //[weakself.tableView reloadData];
                [weakself.mapView addAnnotations:self.mapAnnotations];
        });
    }];
    
    self.mapAnnotations = [list getAnnotations];
    
    
    
          [self.mapView removeAnnotations:self.mapView.annotations];
    
    // add all the custom annotations
    [self.mapView addAnnotations:self.mapAnnotations];

    
    [self.mapView setRegion:newRegion animated:YES];
    

    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setCenter :(NSInteger)AnnotationNumber
{
    CustomAnnotation *Annotation=self.mapAnnotations[AnnotationNumber];
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = Annotation.coordinate.latitude;
    newRegion.center.longitude = Annotation.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.2;
    newRegion.span.longitudeDelta = 0.2;
    
    [self.mapView setRegion:newRegion animated:YES];
    [self.mapView selectAnnotation:Annotation animated:YES];
}



@end
