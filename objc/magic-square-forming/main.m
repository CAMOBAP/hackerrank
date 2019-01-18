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
- (NSNumber *) formingMagicSquare:(NSArray<NSArray<NSNumber *> *> *)s;
@end

@implementation Solution

- (NSInteger) minimalDistanceBetween:(NSArray<NSNumber *> *)reference and:(NSArray<NSNumber *> *)array {
    NSInteger result = NSIntegerMax;

    if (reference.count != array.count) {
        return result;
    }

    for (short i = reference[0].integerValue % 2; i < reference.count; i += 2) {
        NSInteger currentResult = 0;
        for (short j = 0; j < array.count; j++) {
            short ri = (i + j) < array.count ? i + j : i + j - array.count;
            currentResult += abs((short)(reference[ri].integerValue - array[j].integerValue));
        }

        if (currentResult < result) {
            result = currentResult;
        }
    }

    return result;
}

// Complete the formingMagicSquare function below.
- (NSNumber *) formingMagicSquare:(NSArray<NSArray<NSNumber *> *> *)s {
    // 5 always in center
    NSInteger score = abs((short)s[1][1].integerValue - 5);

    // check rest https://mindyourdecisions.com/blog/2015/11/08/how-many-3x3-magic-squares-are-there-sunday-puzzle/
    NSArray<NSNumber *> *ring = @[s[0][0], s[0][1], s[0][2], s[1][2], s[2][2], s[2][1], s[2][0], s[1][0]];
    NSArray<NSNumber *> *pattern = @[@8, @1, @6, @7, @2, @9, @4, @3];
    
    NSInteger result1 = [self minimalDistanceBetween:pattern and:ring];
    NSInteger result2 = [self minimalDistanceBetween:[[pattern reverseObjectEnumerator] allObjects] and:ring];

    score += result1 > result2 ? result2 : result1;
    
    return [NSNumber numberWithInteger:score];
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

        NSArray *sTemp = [[availableInputArray subarrayWithRange:NSMakeRange(currentInputLine, 3)] valueForKey:@"arrayFromString"];
        currentInputLine += 3;

        for (id sRow in sTemp) {
            if ([sRow count] != 3) {
                [NSException raise:@"Bad Input" format:@"%@", [sRow componentsJoinedByString:@", "]];
            }
        }

        NSMutableArray *sTempMutable = [NSMutableArray arrayWithCapacity:3];

        for (id sTempRow in sTemp) {
            NSMutableArray *sTempRowMutable = [NSMutableArray arrayWithCapacity:3];

            [sTempRow enumerateObjectsUsingBlock:^(NSString *sItem, NSUInteger idx, BOOL *stop) {
                [sTempRowMutable addObject:[sItem numberFromString:numberFormatter]];
            }];

            [sTempMutable addObject:[sTempRowMutable copy]];
        }

        NSArray *s = [sTempMutable copy];

        NSNumber *result = [[[Solution alloc] init] formingMagicSquare:s];

        [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

