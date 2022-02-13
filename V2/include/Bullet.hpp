#pragma once

#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <iostream>

#include "Entity.hpp"
#include "Player.hpp"


class Bullet : public Entity
{

    private:

        float x, y;

    public:

        void Spawn(Player player)
        {

            setSpriteLocation(player.GetSprite().getPosition());

        }

        void Update()
        {

            moveSprite(sf::Vector2f(0, -10));

        }


};