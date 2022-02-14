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
            sf::Vector2f pos(player.GetSprite().getPosition().x + 25.5, player.GetSprite().getPosition().y);

            setSpriteLocation(pos);

        }

        void Update()
        {

            moveSprite(sf::Vector2f(0, -10));

        }


};