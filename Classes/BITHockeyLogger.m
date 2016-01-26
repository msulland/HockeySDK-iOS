#import "BITHockeyLogger.h"
#import "HockeySDK.h"

@implementation BITHockeyLogger

static BITLogLevel _currentLogLevel = BITLogLevelWarning;

+ (BITLogLevel)currentLogLevel {
  return _currentLogLevel;
}

+ (void)setCurrentLogLevel:(BITLogLevel)currentLogLevel {
  _currentLogLevel = currentLogLevel;
}

+ (void)logLevel:(BITLogLevel)loglevel function:(const char *)function line:(int)line message:(NSString *)message, ... {
  va_list args;
  if (message) {
    va_start(args, message);
    if (self.currentLogLevel < loglevel) {
      return;
    }
    NSLog((@"[HockeySDK] %s/%d %@"), function, line, [[NSString alloc] initWithFormat:message arguments:args]);
    va_end(args);
  }
}

@end
