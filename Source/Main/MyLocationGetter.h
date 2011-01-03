#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// GPS
#define GPSLocationDidFix @"GPSLocationDidFix"
#define GPSLocationDidStop @"GPSLocationDidStop"

@interface MyLocationGetter : NSObject <CLLocationManagerDelegate> {
	
	CLLocationManager *locationManager;
}

@property (nonatomic, readonly) CLLocationManager *locationManager;

- (void)startUpdates;
- (void)stopUpdates;

@end
