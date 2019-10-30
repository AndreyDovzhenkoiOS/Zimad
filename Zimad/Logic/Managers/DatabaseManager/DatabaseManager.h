//
//  DatabaseManager.h
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RepositoryList.h"
#import "Repository.h"
#import "Author.h"

@interface DatabaseManager : NSObject

@property (strong, nonatomic)NSManagedObjectContext *context;

+ (DatabaseManager *)shared;

- (NSManagedObjectContext *)getContext;

- (void)saveContext;

- (void)addObjectInDatabase:(NSString *)entityName dictionaryProperty:(NSDictionary *)dictionaryProperty;

- (NSArray*)getObjectsFromDatabase:(NSString *)entityName;

- (NSManagedObject *)getObjectFromDatabase:(NSString *)entityName key:(NSString *)key value:(NSInteger)value;

- (Author *)getAuthorFromDatabase:(NSInteger)Id;

- (RepositoryList *)getRepositoryListFromDatabase;

- (void)addToDatabaseForRepositoryList:(RepositoryList *)repositoryList;

- (void)addToDatabaseForAuthor:(Author *)author;
@end
