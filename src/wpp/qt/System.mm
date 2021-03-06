#include "System.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

namespace wpp
{
namespace qt
{

void System::initDeviceId()
{
	NSUUID *identifierForVendor = [[UIDevice currentDevice] identifierForVendor];
	NSString *deviceId = [identifierForVendor UUIDString];
	QString deviceIdQString( [deviceId UTF8String] );

	this->deviceId = deviceIdQString;
	emit this->deviceIdChanged();
}

int System::getIOSVersion()
{

	NSArray *comp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];

	return [[comp objectAtIndex:0] intValue];
}

void System::enableAutoScreenOrientation(bool enable)
{
	__IMPLEMENTATION_DETAIL_ENABLE_AUTO_ROTATE = enable;
}

void System::registerApplePushNotificationService()
{
	UIApplication *application = [UIApplication sharedApplication];
	if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
		UIUserNotificationType userNotificationTypes =
				(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);

		[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:userNotificationTypes
																						categories:nil]];
		[application registerForRemoteNotifications]; // you can also set here for local notification.
	} else {
		UIUserNotificationType userNotificationTypes =
				(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge);

		[application registerForRemoteNotificationTypes:userNotificationTypes];
	}
/*
        if ( [[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)] )
        {
                UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                                                                                UIUserNotificationTypeBadge |
                                                                                                                UIUserNotificationTypeSound);
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes

                     categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
                [[UIApplication sharedApplication] registerForRemoteNotifications];

        }
        else
        {
                [[UIApplication sharedApplication] registerForRemoteNotificationTyes:
                        (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
        }

*/
}

void System::addToImageGallery(const QString& imageFullPath)
{
//http://stackoverflow.com/questions/12609301/how-to-save-the-image-on-iphone-in-the-gallery

	NSString *imagePath = imageFullPath.toNSString();

	NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
	UIImage* image = [UIImage imageWithData:data];

	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

}//namespace qt
}//namespace wpp

