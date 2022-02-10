#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <iostream>
#include <vector>
#include <stdlib.h>
#include <time.h>
#include <chrono>
#include <cstdint>

#include "RenderWindow.hpp"
#include "Entity.hpp"
#include "Utils.hpp"


enum GameState
{
	main_menu, help_menu_controls, help_menu_settings, help_menu_info, my_station, play
};

int main(int argc, char* args[])
{
	srand(time(NULL));
	std::string imageprefix = "_small.png";
	Vector2f windowsize(721, 700 	);
	int backgrounds[9][9] = {};
	Entity backtex;
	/*{
		SDL_DisplayMode DM;
		SDL_GetCurrentDisplayMode(-1, &DM);
		auto height = DM.h;
		std::cout << height << std::endl;
		if(height >= 1080){
			imageprefix = ".png";
			windowsize = Vector2f(977, 947);
		}
	}*/

	if (SDL_Init(SDL_INIT_VIDEO) > 0)
		std::cout << "HEY.. SDL_Init HAS FAILED. SDL_ERROR: " << SDL_GetError() << std::endl;

	if (!(IMG_Init(IMG_INIT_PNG)))
		std::cout << "IMG_init has failed. Error: " << SDL_GetError() << std::endl;

	RenderWindow window("Asteroid Wars Alpha 1.0", windowsize.x, windowsize.y);

	Entity main_page(Vector2f(0, 0), window.loadTexture( ("res/UI/main_page" + imageprefix).c_str() ), Vector2f(windowsize.x, windowsize.y));
	Entity help_page_controls(Vector2f(0, 0), window.loadTexture( ("res/UI/Help UI/controls_page" + imageprefix).c_str() ), Vector2f(windowsize.x, windowsize.y));
	Entity help_page_settings(Vector2f(0, 0), window.loadTexture( ("res/UI/Help UI/settings_page" + imageprefix).c_str() ), Vector2f(windowsize.x, windowsize.y));
	Entity help_page_info(Vector2f(0, 0), window.loadTexture( ("res/UI/Help UI/info_page" + imageprefix).c_str() ), Vector2f(windowsize.x, windowsize.y));
	Entity my_station_page(Vector2f(0, 0), window.loadTexture( ("res/UI/my station UI/my_station_UI" + imageprefix).c_str() ), Vector2f(windowsize.x, windowsize.y));

	Entity space(Vector2f(0, 0), window.loadTexture("res/in game background/space.png"), Vector2f(80, 80));


	bool gameRunning = true;

	SDL_Event event;

	GameState gameState = main_menu;

	while (gameRunning)
	{
		int then = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();

		// Get our controls and events
		while (SDL_PollEvent(&event))
		{
			if (event.type == SDL_QUIT)
				gameRunning = false;

			if (event.type == SDL_MOUSEMOTION)
			{
				std::cout << "Mouse = (" << event.motion.x << "," << event.motion.y << ")" << std::endl;
			}
			if(gameState == main_menu){
				if (event.button.button == SDL_BUTTON_LEFT)
				{
					//Vector2f startbuttonwidth(325, 415);
					//Vector2f startbutton_height(305, 352);

					//helpbuttonheight = 370, 415
					std::cout << "You clicked!" << std::endl;
					if(event.motion.x > 325 && event.motion.x < 415){
						if(event.motion.y > 277 && event.motion.y < 323){

							for(int i = 0; i < 9; i++){
								for(int j = 0; j < 9; j++){
									backgrounds[i][j] = rand() % 4 + 1;
								}
							}
							gameState = play;
						}
						if(event.motion.y > 370 && event.motion.y < 415){
							gameState = help_menu_controls;
						}
						if(event.motion.y > 460 && event.motion.y < 508){
							gameRunning = false;
							std::cout << "Program Burst :(";
						}
					}
					if(event.motion.x > 546 && event.motion.x < 703){
						if(event.motion.y > 643 && event.motion.y < 690){
							gameState = my_station;
							std::cout << "It worked!";
						}
					}
				}
			}
			if(gameState == help_menu_controls || gameState == help_menu_settings || gameState == help_menu_info)
			{
				if (event.button.button == SDL_BUTTON_LEFT)
				{
					//buttonwidth = 0, 127
					//controlsbuttonheight = 0, 42
					//settingsbuttonheight = 42, 95
					//infobuttonheight = 95, 150

					if(event.motion.x > 0 && event.motion.x < 127){
						if(event.motion.y > 0 && event.motion.y < 42){
							gameState = help_menu_controls;
						}
						if(event.motion.y > 42 && event.motion.y < 95){
							gameState = help_menu_settings;
						}
						if(event.motion.y > 95 && event.motion.y < 150){
							gameState = help_menu_info;
						}
					}
					if(event.motion.x > 620 && event.motion.x < 720){
						if(event.motion.y > 657 && event.motion.y < 700){
							gameState = main_menu;
						}
					}
				}
				if (event.type == SDL_KEYDOWN && event.key.keysym.scancode == SDL_SCANCODE_ESCAPE)
				{
					std::cout << event.key.keysym.scancode << std::endl;
					gameState = main_menu;
				}
				
			}
			if(gameState == my_station){
				if(event.button.button == SDL_BUTTON_LEFT){
					if(event.motion.x > 620 && event.motion.x < 720){
						if(event.motion.y > 657 && event.motion.y < 700){
							gameState = main_menu;
						}
					}
				}
			}
		}

		window.clear();
		

		/*for (Entity& e : entitiees)
		{ 
			window.render(e);
		}*/

		if(gameState == main_menu){
			window.render(main_page);
		}
		if(gameState == help_menu_controls){
			window.render(help_page_controls);
		}
		if(gameState == help_menu_settings){
			window.render(help_page_settings);
		}
		if(gameState == help_menu_info){
			window.render(help_page_info);
		}
		if(gameState == my_station){
			window.render(my_station_page);
		}
		//std::cout << gameState << std::endl;
		if(gameState == play){
			space = NULL;
			for(int i = 0; i < 9; i++){
				for(int j = 0; j < 9; j++){
					space = Entity(Vector2f(i * 80, j * 80), window.loadTexture(("res/in game background/space" + std::to_string(backgrounds[i][j]) + ".png").c_str()), Vector2f(80, 80));
					window.render(space);
					//return 1;
				}
			}
		}

		
		window.display();

		int now = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
		SDL_Delay(17);
		

	}

	window.cleanUp();
	SDL_Quit();
	return 0;
}