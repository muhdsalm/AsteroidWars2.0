#pragma once

#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <iostream>
#include <stdlib.h>

#include "Entity.hpp"

class Asteroid : public Entity{

    private:

        int x;

    public:

        Asteroid()
        {
            int Loc = rand() % 670;

            setSpriteLocation(sf::Vector2f(Loc, -50));
            SetTexture("res/Asteroids/asteroid.png");

        }

        void Update()
        {   

            moveSprite(sf::Vector2f(0, 10));

        }

};