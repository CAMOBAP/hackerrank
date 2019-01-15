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
- (NSNumber *) getMinimumCost:(NSNumber *)k c:(NSArray *)c;
@end

@implementation Solution
// Complete the getMinimumCost function below.
- (NSNumber *) getMinimumCost:(NSNumber *)buyers c:(NSArray *)prices {
    if (buyers.integerValue >= prices.count) {
        return [prices valueForKeyPath: @"@sum.self"];
    }

    NSArray<NSNumber *> *sortedPrices = [prices sortedArrayUsingComparator:^NSComparisonResult(NSNumber* n1, NSNumber* n2) {
           return [n2 compare:n1];
    }];
    
    NSInteger result = 0;
    for (int i = 0; i < sortedPrices.count; i++) {
        result += (1 + i / buyers.integerValue) * sortedPrices[i].integerValue;
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

        NSArray *cTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *cTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        [cTemp enumerateObjectsUsingBlock:^(NSString *cItem, NSUInteger idx, BOOL *stop) {
            [cTempMutable addObject:[cItem numberFromString:numberFormatter]];
        }];

        NSArray *c = [cTempMutable copy];

        NSNumber *minimumCost = [[[Solution alloc] init] getMinimumCost:k c:c];

        [fileHandle writeData:[[minimumCost stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

