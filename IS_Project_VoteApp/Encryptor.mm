//
//  Encryptor.mm
//  IS_Project_VoteApp
//
//  Created by 변상우 on 5/31/24.
//

#import <Foundation/Foundation.h>

// Encryptor.cpp
#include "Encryptor.h"

Encryptor::Encryptor() {
    // HEAAN 초기화 코드
    HEAAN::Ring ring;
    secretKey = HEAAN::SecretKey(ring);
    scheme = HEAAN::Scheme(secretKey, ring);
}

Encryptor::~Encryptor() {
    // 소멸자
}

std::string Encryptor::encrypt(const std::string& plainText) {
    // 암호화 코드
    HEAAN::Plaintext plain(plainText);
    HEAAN::Ciphertext cipher;
    scheme.encrypt(cipher, plain);
    return cipher.toString();
}

std::string Encryptor::decrypt(const std::string& cipherText) {
    // 복호화 코드
    HEAAN::Ciphertext cipher(cipherText);
    HEAAN::Plaintext plain;
    scheme.decrypt(plain, cipher);
    return plain.toString();
}
