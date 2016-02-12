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

static BITLogHandler currentLogHandler = ^(BITLogMessageProvider messageProvider, BITLogLevel logLevel, const char *file, const char *function, NSUInteger line) {
  if (messageProvider) {
    if (_currentLogLevel < logLevel) {
      return;
    }
    NSLog((@"[HockeySDK] %s/%lu %@"), function, line, messageProvider());
  }

};

+ (void)setLogHandler:(BITLogHandler)logHandler {
  currentLogHandler = logHandler;
}

+ (void)logMessage:(BITLogMessageProvider)messageProvider level:(BITLogLevel)loglevel file:(const char *)file function:(const char *)function line:(int)line {
  if (currentLogHandler) {
    currentLogHandler(messageProvider, loglevel, file, function, line);
  }
}

@end
