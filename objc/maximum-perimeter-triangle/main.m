#import <Foundation/Foundation.h>
#import <objc/Object.h>
#import <objc/objc.h>

@interface NSString (NumberFromString)
- (NSNumber *) numberFromString:(NSNumberFormatter *)formatter;
@end

@implementation NSString (NumberFromString)
- (NSNumber *) numberFromString:(NSNumberFormatter *)formatter {
    NSNumber *number = [formatter numberFromString:self];

    if (number == nil) {
        [NSException raise:@"Bad Input" format:@"%@", self];
    }

    return number;
}
@end

@interface NSString (ArrayFromString)
- (NSArray *) arrayFromString;
@end

@implementation NSString (ArrayFromString)
- (NSArray *) arrayFromString {
    return [self componentsSeparatedByString:@" "];
}
@end

@interface Solution:NSObject
- (NSArray *) maximumPerimeterTriangle:(NSArray *)sticks;
@end

@implementation Solution
// Complete the maximumPerimeterTriangle function below.
- (NSArray *) maximumPerimeterTriangle:(NSArray *)sticks {
    NSMutableArray* sortedSticks = [sticks mutableCopy];
    [sortedSticks sortUsingSelector:@selector(compare:)];

    NSInteger last = -1;
    for (NSInteger i = 2; i < sortedSticks.count; i++) {
        NSInteger a = [sortedSticks[i - 2] integerValue];
        NSInteger b = [sortedSticks[i - 1] integerValue];
        NSInteger c = [sortedSticks[i - 0] integerValue];

        if (a + b > c) {
            last = i;
        }
    }

    NSArray *result = nil;
    if (last == -1) {
        result = @[@-1];
    } else {
        result = @[sortedSticks[last - 2], sortedSticks[last - 1], sortedSticks[last - 0]];
    }

    return result;
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSString *stdout = [[[NSProcessInfo processInfo] environment] objectForKey:@"OUTPUT_PATH"];
        [[NSFileManager defaultManager] createFileAtPath:stdout contents:nil attributes:nil];
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:stdout];

        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

        NSData *availableInputData = [[NSFileHandle fileHandleWithStandardInput] availableData];
        NSString *availableInputString = [[NSString alloc] initWithData:availableInputData encoding:NSUTF8StringEncoding];
        NSArray *availableInputArray = [availableInputString componentsSeparatedByString:@"\n"];

        NSUInteger currentInputLine = 0;

        NSNumber *n = [[availableInputArray objectAtIndex:currentInputLine] numberFromString:numberFormatter];
        currentInputLine += 1;

        NSArray *sticksTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *sticksTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        [sticksTemp enumerateObjectsUsingBlock:^(NSString *sticksItem, NSUInteger idx, BOOL *stop) {
            [sticksTempMutable addObject:[sticksItem numberFromString:numberFormatter]];
        }];

        NSArray *sticks = [sticksTempMutable copy];

        NSArray *result = [[[Solution alloc] init] maximumPerimeterTriangle:sticks];

        [fileHandle writeData:[[result componentsJoinedByString:@" "] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

