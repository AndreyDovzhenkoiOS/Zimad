//
//  DatabaseManager.m
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "DatabaseManager.h"
#import "AppDelegate.h"

@implementation DatabaseManager
- (instancetype)init {
    self = [super init];
    if (self) {
        _context = [self getContext];
    }
    return self;
}

+ (DatabaseManager *)shared {
    static DatabaseManager *databseManager = nil;
    static dispatch_once_t token;

    dispatch_once(&token, ^{
        databseManager = [DatabaseManager new];
    });

    return databseManager;
}

- (NSManagedObjectContext *)getContext {
    AppDelegate *appdelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    return [[appdelegate persistentContainer] viewContext];
}

- (void)saveContext {
    NSError *error = nil;
    if (error) {
        NSLog(@"%@", error);
    } else {
        [_context save: &error];
    }
}

- (void)addObjectInDatabase:(NSString *)entityName dictionaryProperty:(NSDictionary *)dictionaryProperty {
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName: entityName inManagedObjectContext: _context];
    [self setPropertyForObject: object dictionaryProperty: dictionaryProperty];
}

- (NSArray *)getObjectsFromDatabase:(NSString *)entityName {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: entityName];
    NSError * error = nil;
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }else {
        return [_context executeFetchRequest:request error:&error];
    }
    return [NSArray new];
}

- (void)setPropertyForObject:(NSManagedObject *)object dictionaryProperty:(NSDictionary *)dictionaryProperty {

    for (NSString *key in dictionaryProperty.allKeys) {
        if ([object respondsToSelector:NSSelectorFromString(key)]) {
            [object setValue: [dictionaryProperty objectForKey: key] forKey: key];
        }
    }

    [self saveContext];
}

@end
