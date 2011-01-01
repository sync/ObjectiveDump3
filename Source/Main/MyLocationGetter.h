#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// GPS
#define ShouldStopGPSLocationFix @"ShouldStopGPSLocationFix"
#define GPSLocationDidFix @"GPSLocationDidFix"

@interface MyLocationGetter : NSObject <CLLocationManagerDelegate> {
	
	CLLocationManager *locationManager;
}

@property (nonatomic, readonly) CLLocationManager *locationManager;

- (void)startUpdates;
- (void)stopUpdates;

@end
