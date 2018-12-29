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
- (NSNumber *) luckBalance:(NSNumber *)k contests:(NSArray *)contests;
@end

@implementation Solution
// Complete the luckBalance function below.
- (NSNumber *) luckBalance:(NSNumber *)loose contests:(NSArray *)contests {
    NSInteger result = 0;

    NSMutableArray *importantContests = [NSMutableArray new];
    for (id contest in contests) {
        if ([contest[1] isEqual:@1]) {
            [importantContests addObject:contest[0]];
        } else {
            result += [contest[0] integerValue];
        }
    }

    if (importantContests.count > [loose integerValue]) {
        NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
        [importantContests sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    }

    for (int i = 0; i < importantContests.count; i++) {
        if (i < [loose integerValue]) {
            result += [importantContests[i] integerValue];
        } else {
            result -= [importantContests[i] integerValue];
        }
    }

    return [NSNumber numberWithInteger:result];
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

        NSArray *nk = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSNumber *n = [nk[0] numberFromString:numberFormatter];

        NSNumber *k = [nk[1] numberFromString:numberFormatter];

        NSArray *contestsTemp = [[availableInputArray subarrayWithRange:NSMakeRange(currentInputLine, [n unsignedIntegerValue])] valueForKey:@"arrayFromString"];
        currentInputLine += [n unsignedIntegerValue];

        for (id contestsRow in contestsTemp) {
            if ([contestsRow count] != 2) {
                [NSException raise:@"Bad Input" format:@"%@", [contestsRow componentsJoinedByString:@", "]];
            }
        }

        NSMutableArray *contestsTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        for (id contestsTempRow in contestsTemp) {
            NSMutableArray *contestsTempRowMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

            [contestsTempRow enumerateObjectsUsingBlock:^(NSString *contestsItem, NSUInteger idx, BOOL *stop) {
                [contestsTempRowMutable addObject:[contestsItem numberFromString:numberFormatter]];
            }];

            [contestsTempMutable addObject:[contestsTempRowMutable copy]];
        }

        NSArray *contests = [contestsTempMutable copy];

        NSNumber *result = [[[Solution alloc] init] luckBalance:k contests:contests];

        [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

