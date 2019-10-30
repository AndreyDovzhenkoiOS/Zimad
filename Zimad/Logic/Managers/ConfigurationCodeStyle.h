//
//  ConfigurationCodeStyle.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#define let __auto_type const
#define var __auto_type

#define foreach(object_, collection_) \
    for (typeof((collection_).jm_enumeratedType) object_ in (collection_))

@interface NSArray<__covariant ObjectType> (ForeachSupport)

@property (nonatomic, strong, readonly) ObjectType jm_enumeratedType;

@end

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (ForeachSupport)

@property (nonatomic, strong, readonly) KeyType jm_enumeratedType;

@end
