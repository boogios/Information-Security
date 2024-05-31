//
//  EncryptorWrapper.h
//  IS_Project_VoteApp
//
//  Created by 변상우 on 5/31/24.
//

#import <Foundation/Foundation.h>

@interface EncryptorWrapper : NSObject

- (instancetype)init;
- (NSString *)encrypt:(NSString *)plainText;
- (NSString *)decrypt:(NSString *)cipherText;

@end
