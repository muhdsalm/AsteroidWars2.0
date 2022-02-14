#include<iostream>
#include<SFML/Graphics.hpp>
#include<SFML/Audio.hpp>
#include<stdlib.h>

#include "Entity.hpp"
#include "Player.hpp"
#include "Bullet.hpp"
#include "Menu.hpp"
#include "Asteroid.hpp"
#include "Utils.hpp"

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

	sf::SoundBuffer fire_sound_buffer;
	fire_sound_buffer.loadFromFile("res/sound/sound effects/in-game.sound.laser.shoot.wav");
	sf::Sound fire_sound;
	fire_sound.setBuffer(fire_sound_buffer);
	fire_sound.setVolume(10);
	

    sf::Texture backgrounds_tex[9][9] = {};
    sf::Sprite backgrounds[9][9] = {};
    
    int windoww = 721;
    int windowh = 700;
    sf::RenderWindow window(sf::VideoMode(windoww, windowh), "Asteroid Wars Alpha 1.2", sf::Style::Close);
    window.setPosition(sf::Vector2i(0, 0));
	window.setFramerateLimit(60);
    
    Menu main_page("res/UI/main_page_small.png");

	Menu help_page_controls("res/UI/Help UI/controls_page_small.png");

    Menu help_page_settings("res/UI/Help UI/settings_page_small.png");

    Menu help_page_about("res/UI/Help UI/info_page_small.png");

	Menu my_staion("res/UI/my station UI/my_station_UI_small.png");

	std::vector<Bullet> bullets = {};
	int bullet_iterator = 0;
	bool ChangeBulletTexture = false;
	bool canFire = true;
	
	int spamLimit = 15;
	int spam = spamLimit;
	sf::Clock spamTimer;
	sf::RectangleShape SpamCounter;
	SpamCounter.setSize(sf::Vector2f(10, 50));
	SpamCounter.setPosition(0, 0);

	std::vector<Asteroid> asteroids = {};
	int asteroid_iterator = 0;
	bool changeAsteroidTexture = false;
	int asteroidSpawnTime = rand() % 1000 + 1;
	sf::Clock asteroidTimer;

	Player default_rocket;
	default_rocket.SetTexture("res/Rockets/default rocket/default_rocket_small.png");
	default_rocket.GetSprite().setPosition(360, 350);


    gamestate gamestate = main_menu;

	sf::Clock clock;

	menu_music.play();
    while (window.isOpen())
    {
		clock.restart();

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
							bullets = {};
							bullet_iterator = 0;
							ChangeBulletTexture = false;
							canFire = true;
							
							spamLimit = 15;
							spam = spamLimit;

							asteroids = {};
							asteroid_iterator = 0;
							changeAsteroidTexture = false;
							asteroidSpawnTime = rand() % 1000 + 1;

							default_rocket.setSpriteLocation(sf::Vector2f(260, 350));

							gamestate = play;
							menu_music.stop();
							asteroidTimer.restart();
							spamTimer.restart();
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
			else if(gamestate == my_station){
				if(event.type == sf::Event::MouseButtonPressed && event.mouseButton.button == sf::Mouse::Left){
					if(sf::Mouse::getPosition(window).x > 620 && sf::Mouse::getPosition(window).x < 720){
						if(sf::Mouse::getPosition(window).y > 657 && sf::Mouse::getPosition(window).y < 700){
							click_sound.play();
							gamestate = main_menu;
						}
					}
				}
			}
			else if(gamestate == help_menu_controls || gamestate == help_menu_settings || gamestate == help_menu_about)
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
			else if (gamestate == play)
			{
				
				default_rocket.keypress(event);
				if (event.key.code == sf::Keyboard::Space && event.type == sf::Event::KeyPressed)
				{
					if (canFire)
					{
						fire_sound.play();
						bullets.push_back(Bullet());
						bullets.at(bullets.size() - 1).Spawn(default_rocket);
						ChangeBulletTexture = true;
						spam--;
						canFire = false;
					}
					
					
					
				}
				else if (!(sf::Keyboard::isKeyPressed(sf::Keyboard::Key::Space)))
				{
					canFire = true;
				}
				
				
				
				

			}
			            
        }
        
        window.clear(sf::Color::Black);

        if (gamestate == main_menu)
        {
            window.draw(main_page.GetSprite());
        }
        if (gamestate == help_menu_controls)
        {
            window.draw(help_page_controls.GetSprite());
        }
        if (gamestate == help_menu_settings)
        {
            window.draw(help_page_settings.GetSprite());
        }
        if (gamestate == help_menu_about)
        {
            window.draw(help_page_about.GetSprite());
        }
		if (gamestate == my_station)
        {
            window.draw(my_staion.GetSprite());
        }
        if(gamestate == play)
		{
			for(int i = 0; i < 9; i++){
				for(int j = 0; j < 9; j++){
					window.draw(backgrounds[i][j]);
					//return 1;
				}
			}

			default_rocket.Update();

			bullet_iterator = 0;
			for ( Bullet& bullet : bullets )
			{
			
				bullet.Update();


				if (bullet.GetSprite().getPosition().y < 0 )
				{
					auto bulletIterator = bullets.begin() + bullet_iterator;
					bullets.erase(bulletIterator);
					ChangeBulletTexture = true;
					/*for (Bullet& bullet : bullets)
					{
						bullet.SetTexture("res/icons/rocket_laser.png");
					}*/
					
				}
				bullet_iterator += 1;
				if (ChangeBulletTexture)
				{
					bullet.SetTexture("res/icons/rocket_laser.png");
				}
				window.draw(bullet.GetSprite());
			}
			bullet_iterator = 0;
			if (asteroidTimer.getElapsedTime().asMilliseconds() > asteroidSpawnTime)
				{
					asteroids.push_back(Asteroid());
					changeAsteroidTexture = true;
					asteroidTimer.restart();
					asteroidSpawnTime = rand() % 1000 + 1;

				}
			for ( Asteroid& asteroid : asteroids )
			{
		
				asteroid.Update();

				if (Utils::IsColliding(asteroid, default_rocket))
				{
					gamestate = main_menu;
					in_game_music_before_jupiter_dies.stop();
					menu_music.play();
				}
				

				

				for (Bullet& bullet : bullets)
				{
					if (Utils::IsColliding(bullet, asteroid))
					{
						auto asteroidIterator = asteroids.begin() + asteroid_iterator;
						auto bulletIterator = bullets.begin() + bullet_iterator;
						asteroids.erase(asteroidIterator);
						bullets.erase(bulletIterator);
						changeAsteroidTexture = true;
					}
				}
				

				if (asteroid.GetSprite().getPosition().y > 700 )
				{
					auto asteroidIterator = asteroids.begin() + asteroid_iterator;
					asteroids.erase(asteroidIterator);
					changeAsteroidTexture = true;
					
					/*for (Bullet& bullet : bullets)
					{
						bullet.SetTexture("res/icons/rocket_laser.png");
					}*/
					
				}
				asteroid_iterator += 1;
				if (changeAsteroidTexture)
				{
					asteroid.SetTexture("res/Asteroids/asteroid.png");
				}
				window.draw(asteroid.GetSprite());
			}
			asteroid_iterator = 0;


			window.draw(default_rocket.GetSprite());
			changeAsteroidTexture = false;

			if (spamTimer.getElapsedTime().asSeconds() > 1)
			{
				++spam;

				if (spam > spamLimit)
				{
					spam = spamLimit;
				}
				

				spamTimer.restart();
			}
			SpamCounter.setScale(sf::Vector2f(spam, 1));

			if (spam > 10)
			{
				SpamCounter.setFillColor(sf::Color::Green);
			}
			else if (spam > 5)
			{
				SpamCounter.setFillColor(sf::Color::Yellow);
			}else
			{
				SpamCounter.setFillColor(sf::Color::Red);
			}
			if (spam <= 0)
			{
				gamestate = main_menu;
				in_game_music_before_jupiter_dies.stop();
				menu_music.play();
			}
			
			window.draw(SpamCounter);
			
		}


        window.display();

		Utils::print(std::to_string(spam));

		
		

        sf::sleep(sf::milliseconds(17) - clock.getElapsedTime());
    }
    

    return 0;
}