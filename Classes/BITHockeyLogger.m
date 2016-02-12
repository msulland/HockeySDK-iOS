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

static BITLogHandler currentLogHandler = ^(BITLogLevel logLevel, const char *file, const char *function, NSUInteger line, NSString *message) {
  if (message) {
    if (_currentLogLevel < logLevel) {
      return;
    }
    NSLog((@"[HockeySDK] %s/%lu %@"), function, line, message);
  }

};

+ (void)setLogHandler:(BITLogHandler)logHandler {
  currentLogHandler = logHandler;
}

+ (void)logLevel:(BITLogLevel)loglevel file:(const char *)file function:(const char *)function line:(int)line message:(NSString *)message, ... {
  if (currentLogHandler) {
    va_list args;
    va_start(args, message);
    LogHandler(loglevel, file, function, line, [[NSString alloc] initWithFormat:message arguments:args]);
    va_end(args);
  }
}

@end
