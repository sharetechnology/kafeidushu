//
//  Created by Eric Yang on 13-5-29.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#define IS_IPAD UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds ].size.height

#define ARRAR_COUNT(x)  (sizeof(x) / sizeof(x[0]))


#define Alert2(messageText) \
{\
UIAlertView * alert = [[[UIAlertView alloc]\
initWithTitle:nil \
message:messageText \
delegate:nil \
cancelButtonTitle:@"ok" \
otherButtonTitles:nil]autorelease];\
\
[alert show];\
alert = nil;\
}\
\

