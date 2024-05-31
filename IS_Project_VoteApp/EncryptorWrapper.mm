//
//  EncryptorWrapper.mm
//  IS_Project_VoteApp
//
//  Created by 변상우 on 5/31/24.
//

#import "EncryptorWrapper.h"
#import "Encryptor.h"

@implementation EncryptorWrapper {
    Encryptor *_encryptor;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _encryptor = new Encryptor();
    }
    return self;
}

- (NSString *)encrypt:(NSString *)plainText {
    std::string plainTextStd = [plainText UTF8String];
    std::string encryptedTextStd = _encryptor->encrypt(plainTextStd);
    return [NSString stringWithUTF8String:encryptedTextStd.c_str()];
}

- (NSString *)decrypt:(NSString *)cipherText {
    std::string cipherTextStd = [cipherText UTF8String];
    std::string decryptedTextStd = _encryptor->decrypt(cipherTextStd);
    return [NSString stringWithUTF8String:decryptedTextStd.c_str()];
}

- (void)dealloc {
    delete _encryptor;
}

@end

