//
//  DatabaseManager.h
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseManager : NSObject

@property (strong, nonatomic)NSManagedObjectContext *context;

+ (DatabaseManager *)shared;

- (NSManagedObjectContext *)getContext;

- (void)saveContext;

- (void)addObjectInDatabase:(NSString *)entityName dictionaryProperty:(NSDictionary *)dictionaryProperty;

- (NSArray*)getObjectsFromDatabase:(NSString *)entityName;

@end
