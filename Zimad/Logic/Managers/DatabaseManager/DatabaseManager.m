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

- (NSManagedObject *)getObjectFromDatabase:(NSString *)entityName key:(NSString *)key value:(NSInteger)value{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: entityName];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K=%ld",key, value]];
    NSError* error;
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }else{
        return [_context executeFetchRequest:request error:&error].firstObject;
    }
    return nil;
}

- (void)setPropertyForObject:(NSManagedObject *)object dictionaryProperty:(NSDictionary *)dictionaryProperty {

    for (NSString *key in dictionaryProperty.allKeys) {
        if ([object respondsToSelector:NSSelectorFromString(key)]) {
            [object setValue: [dictionaryProperty objectForKey: key] forKey: key];
        }
    }

    [self saveContext];
}


- (RepositoryList *)getRepositoryListFromDatabase {
    NSMutableArray *items = [NSMutableArray new];
    [items addObjectsFromArray:[self getObjectsFromDatabase:@"RepositoryModel"]];
    RepositoryList *repositoryList = [RepositoryList new];
    repositoryList.repositories = items;
    return repositoryList;
}

- (void)addToDatabaseForRepositoryList:(RepositoryList *)repositoryList {
    for (Repository *repository in repositoryList.repositories) {
        NSDictionary *dictionary = @{
            @"repositoryId": repository.repositoryId,
            @"fullName": repository.fullName,
            @"title": repository.title,
            @"url": repository.url,
            @"avatarUrl": repository.avatarUrl,
            @"descriptions": repository.descriptions,
            @"branch": repository.branch
        };
        if (![self getObjectFromDatabase: @"RepositoryModel" key:@"repositoryId" value: repository.repositoryId.integerValue]) {
            [self addObjectInDatabase:@"RepositoryModel" dictionaryProperty:dictionary];
        }
    }
}

- (Author *)getAuthorFromDatabase:(NSInteger)Id {
    Author *author = (Author*) [self getObjectFromDatabase:@"AuthorModel" key:@"id" value:Id];
    return author;
}

- (void)addToDatabaseForAuthor:(Author *)author {
    NSDictionary *dictionary = @{
        @"id": @(author.Id),
        @"avatarUrl": author.avatarUrl,
        @"name": author.name,
        @"nameCommit": author.nameCommit,
        @"hashComit": author.hashCommit,
    };
    if (![self getObjectFromDatabase: @"AuthorModel" key:@"id" value: author.Id]) {
        [self addObjectInDatabase:@"AuthorModel" dictionaryProperty:dictionary];
    }
}

@end
