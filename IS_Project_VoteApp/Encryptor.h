//
//  Encryptor.h
//  IS_Project_VoteApp
//
//  Created by 변상우 on 5/31/24.
//

#ifndef Encryptor_h
#define Encryptor_h

#include "HEAAN.h"

class Encryptor {
public:
    Encryptor();
    ~Encryptor();
    std::string encrypt(const std::string& plainText);
    std::string decrypt(const std::string& cipherText);
private:
    HEAAN::Scheme scheme;
    HEAAN::SecretKey secretKey;
};

#endif /* Encryptor_h */
