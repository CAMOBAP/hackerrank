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
- (NSNumber *) toys:(NSArray *)w;
@end

@implementation Solution

// Complete the toys function below.
- (NSNumber *) toys:(NSArray *)weights {
    NSMutableArray* sortedWeight = [weights mutableCopy];
    [sortedWeight sortUsingSelector:@selector(compare:)];

    NSInteger result = 1;
    NSInteger a = [sortedWeight[0] integerValue];
    for (NSUInteger i = 0; i < [sortedWeight count]; i++) {
        if ([sortedWeight[i] integerValue] <= a + 4) {

        } else {
            a = [sortedWeight[i] integerValue];
            result++;
        }
    }

    return [NSNumber numberWithUnsignedInteger:result];
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

        NSArray *wTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *wTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        [wTemp enumerateObjectsUsingBlock:^(NSString *wItem, NSUInteger idx, BOOL *stop) {
            [wTempMutable addObject:[wItem numberFromString:numberFormatter]];
        }];

        NSArray *w = [wTempMutable copy];

        NSNumber *result = [[[Solution alloc] init] toys:w];

        [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

