#pragma once
#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>

#include "Entity.hpp"

class Player : public Entity{
    
    private:
        float x;
        float y;

    public:

        
        void keypress(sf::Event event){

            if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Left)
            {
                x = -10;
            }
            if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Right)
            {
                x = 10;
            }
            if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Up)
            {
                y = -10;
            }
            if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Down)
            {
                y = 10;
            }
           
            
            

        }

        void Update(){


            moveSprite(sf::Vector2f(x, y));
             if (!(sf::Keyboard::isKeyPressed(sf::Keyboard::Left)))
            {
                if (x < 0)
                {
                    x += 1;
                }
            }
            if (!(sf::Keyboard::isKeyPressed(sf::Keyboard::Right)))
            {
                if (x > 0)
                {
                    x -= 1;
                }
                
            }
            if (!(sf::Keyboard::isKeyPressed(sf::Keyboard::Up)))
            {
                if (y < 0)
                {
                    y += 1;
                }
                
            }
            if (!(sf::Keyboard::isKeyPressed(sf::Keyboard::Down)))
            {
                if (y > 0)
                {
                    y -= 1;
                }
                
            }
            

        }

};