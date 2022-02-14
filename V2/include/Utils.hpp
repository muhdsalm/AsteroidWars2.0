#pragma once

#include <iostream>
#include <SFML/Graphics.hpp>

#include "Entity.hpp"
#include "Utils.hpp"

namespace Utils{

    void print(std::string string){
        std::cout << string << std::endl;
    }

    bool IsColliding(Entity& enity1, Entity& entity2)
    {
        if (enity1.GetSprite().getGlobalBounds().intersects(entity2.GetSprite().getGlobalBounds()))
        {
            return true;
        }
        
        return false;
        
    }

}