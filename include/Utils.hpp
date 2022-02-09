#pragma once

#include<iostream>

namespace Utils{
    const char* CombineStrings(std::string string1, std::string string2){

        float string1Len = string1.length();
        float combinedLen = string1.length() + string2.length();
        char combine[string2.length() + string1.length()];

        for(int i = 0; i < string1Len; ++i){
            combine[i] = string1[i];
            std::cout << combine[i];
        }
        for(int i = string1Len; i < combinedLen; ++i){
            combine[i] = string2[i - string1Len];
            std::cout << combine[i];
        }
        std::cout << std::endl;
        const char* combined = string1.c_str();
        return combined;
    }
}