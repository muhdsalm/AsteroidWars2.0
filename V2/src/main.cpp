#include<iostream>
#include<SFML/Graphics.hpp>
#include<SFML/Audio.hpp>
#include<stdlib.h>

#include "RenderWindow.hpp"

enum gamestate{
    main_menu, help_menu_controls, help_menu_settings, help_menu_about, my_station, play
};

int main(){

	srand(time(NULL));

	sf::Music menu_music;
	
	menu_music.openFromFile("res/sound/menu music/game.menu.music.2.ogg");
	menu_music.setLoop(true);


	sf::Music in_game_music_before_jupiter_dies;
	in_game_music_before_jupiter_dies.openFromFile("res/sound/in-game.music.before-jupiter-boss-fight.ogg");

	sf::SoundBuffer click_sound_buffer;
	click_sound_buffer.loadFromFile("res/sound/sound effects/game.sound.click.wav");
	sf::Sound click_sound;
	click_sound.setBuffer(click_sound_buffer);
	

    sf::Texture backgrounds_tex[9][9] = {};
    sf::Sprite backgrounds[9][9] = {};
    
    int windoww = 721;
    int windowh = 700;
    sf::RenderWindow window(sf::VideoMode(windoww, windowh), "Asteroid Wars Alpha 1.2", sf::Style::Close);
    window.setPosition(sf::Vector2i(0, 0));
    
    sf::Texture main_page_tex;
    sf::Sprite main_page;
    main_page_tex.loadFromFile("res/UI/main_page_small.png");
    main_page.setTexture(main_page_tex);

    sf::Texture help_page_controls_tex;
    sf::Sprite help_page_controls;
    help_page_controls_tex.loadFromFile("res/UI/Help UI/controls_page_small.png");
    help_page_controls.setTexture(help_page_controls_tex);

    sf::Texture help_page_settings_tex;
    sf::Sprite help_page_settings;
    help_page_settings_tex.loadFromFile("res/UI/Help UI/settings_page_small.png");
    help_page_settings.setTexture(help_page_settings_tex);

    sf::Texture help_page_about_tex;
    sf::Sprite help_page_about;
    help_page_about_tex.loadFromFile("res/UI/Help UI/info_page_small.png");
    help_page_about.setTexture(help_page_about_tex);

	sf::Texture my_station_tex;
    sf::Sprite my_staion;
    my_station_tex.loadFromFile("res/UI/my station UI/my_station_UI_small.png");
    my_staion.setTexture(my_station_tex);


    gamestate gamestate = main_menu;

	menu_music.play();
    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                window.close();
            }
            if (event.type == sf::Event::MouseMoved)
			{
				std::cout << "Mouse = (" << sf::Mouse::getPosition(window).x << "," << sf::Mouse::getPosition(window).y << ")" << std::endl;
			}
			if(gamestate == main_menu){
				if (event.mouseButton.button == sf::Mouse::Left && event.type == sf::Event::MouseButtonPressed)
				{
					//Vector2f startbuttonwidth(325, 415);
					//Vector2f startbutton_height(305, 352);

					//helpbuttonheight = 370, 415
					std::cout << "You clicked!" << std::endl;
                    std::cout << sf::Mouse::getPosition(window).x << ", " << sf::Mouse::getPosition(window).y << std::endl;
					if(sf::Mouse::getPosition(window).x > 325 && sf::Mouse::getPosition(window).x < 415){
						if(sf::Mouse::getPosition(window).y > 277 && sf::Mouse::getPosition(window).y < 323){

							click_sound.play();

							for(int i = 0; i < 9; i++){
								for(int j = 0; j < 9; j++){
									backgrounds_tex[i][j].loadFromFile(("res/in game background/space" + std::to_string(rand() % 4 + 1) + ".png").c_str());
                                    backgrounds[i][j].setTexture(backgrounds_tex[i][j]);
                                    backgrounds[i][j].setPosition(sf::Vector2f(i * 80, j * 80));

								}
							}
							gamestate = play;
							menu_music.stop();
							in_game_music_before_jupiter_dies.play();
						}
						if(sf::Mouse::getPosition(window).y > 370 && sf::Mouse::getPosition(window).y < 415){
							click_sound.play();
							gamestate = help_menu_controls;
                            std::cout << "SUPER CLICK!";
						}
						if(sf::Mouse::getPosition(window).y > 460 && sf::Mouse::getPosition(window).y < 508){
							click_sound.play();
							window.close();
						}
					}
					if(sf::Mouse::getPosition(window).x > 546 && sf::Mouse::getPosition(window).x < 703){
						if(sf::Mouse::getPosition(window).y > 643 && sf::Mouse::getPosition(window).y < 690){
							click_sound.play();
							gamestate = my_station;
							std::cout << "It worked!";
						}
					}
				}
			}
			if(gamestate == help_menu_controls || gamestate == help_menu_settings || gamestate == help_menu_about)
			{
				if (event.mouseButton.button == sf::Mouse::Button::Left)
				{
					//buttonwidth = 0, 127
					//controlsbuttonheight = 0, 42
					//settingsbuttonheight = 42, 95
					//infobuttonheight = 95, 150

					if(sf::Mouse::getPosition(window).x > 0 && sf::Mouse::getPosition(window).x < 127){
						if(sf::Mouse::getPosition(window).y > 0 && sf::Mouse::getPosition(window).y < 42){
							click_sound.play();
							gamestate = help_menu_controls;
						}
						if(sf::Mouse::getPosition(window).y > 42 && sf::Mouse::getPosition(window).y < 95){
							click_sound.play();
							gamestate = help_menu_settings;
						}
						if(sf::Mouse::getPosition(window).y > 95 && sf::Mouse::getPosition(window).y < 150){
							click_sound.play();
							gamestate = help_menu_about;
						}
					}
					if(sf::Mouse::getPosition(window).x > 620 && sf::Mouse::getPosition(window).x < 720){
						if(sf::Mouse::getPosition(window).y > 657 && sf::Mouse::getPosition(window).y < 700){
							click_sound.play();
							gamestate = main_menu;
						}
					}
				}
				if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Escape)
				{
					click_sound.play();
					gamestate = main_menu;
				}
				
			}
			if(gamestate == my_station){
				if(event.type == sf::Event::MouseButtonPressed && event.mouseButton.button == sf::Mouse::Left){
					if(sf::Mouse::getPosition(window).x > 620 && sf::Mouse::getPosition(window).x < 720){
						if(sf::Mouse::getPosition(window).y > 657 && sf::Mouse::getPosition(window).y < 700){
							click_sound.play();
							gamestate = main_menu;
						}
					}
				}
			}            
        }
        
        window.clear(sf::Color::Black);

        if (gamestate == main_menu)
        {
            window.draw(main_page);
        }
        if (gamestate == help_menu_controls)
        {
            window.draw(help_page_controls);
        }
        if (gamestate == help_menu_settings)
        {
            window.draw(help_page_settings);
        }
        if (gamestate == help_menu_about)
        {
            window.draw(help_page_about);
        }
		if (gamestate == my_station)
        {
            window.draw(my_staion);
        }
        if(gamestate == play){
			for(int i = 0; i < 9; i++){
				for(int j = 0; j < 9; j++){
					window.draw(backgrounds[i][j]);
					//return 1;
				}
			}
		}

        window.display();

        sf::sleep(sf::milliseconds(17));
    }
    

    return 0;
}