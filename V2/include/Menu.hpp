#pragma once

#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>

#include "Entity.hpp"

class Menu : public Entity
{
    private:
        sf::Texture menu_tex;
        sf::Sprite menu;

    public:
        Menu(std::string path){
            
            menu_tex.loadFromFile(path);
            menu.setTexture(menu_tex);

        }
        
        sf::Sprite GetSprite(){
            return menu;
        }
        


};