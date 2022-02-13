#pragma once
#include<SFML/Graphics.hpp>
#include<SFML/Audio.hpp>
#include<iostream>

class Entity{
    

    sf::Texture Entity_Tex;
    sf::Sprite Entity_Sprite;
    float x;
    float y;

    public:

        void SetTexture(std::string texturepath)
        {
            if (!(Entity_Tex.loadFromFile(texturepath)))
            {
                return;
            }
            
            Entity_Sprite.setTexture(Entity_Tex);

        }

        void Update()
        {

            Entity_Sprite.move(sf::Vector2f(x, y));
        }

        void SetX(int p_x)
        {
            x = p_x;
        }
        
        void SetY(int p_y)
        {
            y = p_y;
        }

        sf::Texture GetTex()
        {
            return Entity_Tex;
        }

        sf::Sprite GetSprite()
        {
            return Entity_Sprite;
        }

        float GetX(){
            return x;
        }

        float GetY(){
            return y;
        }

        void moveSprite(sf::Vector2f vector)
        {
            Entity_Sprite.move(vector);
        }

        void setSpriteLocation(sf::Vector2f vectot)
        {
            Entity_Sprite.setPosition(vectot);
        }

};

