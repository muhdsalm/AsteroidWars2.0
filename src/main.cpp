#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <iostream>
#include <vector>

#include "RenderWindow.hpp"
#include "Entity.hpp"


enum GameState
{
	main_menu
};

int main(int argc, char* args[])
{
	if (SDL_Init(SDL_INIT_VIDEO) > 0)
		std::cout << "HEY.. SDL_Init HAS FAILED. SDL_ERROR: " << SDL_GetError() << std::endl;

	if (!(IMG_Init(IMG_INIT_PNG)))
		std::cout << "IMG_init has failed. Error: " << SDL_GetError() << std::endl;

	RenderWindow window("Asteroid Wars Alpha 1.0", 500, 475);

	SDL_Texture* grassTexture = window.loadTexture("res/gfx/ground_grass_1.png");

    // Entity entities[4] = {Entity(0, 0, grassTexture),
    //                       Entity(30, 0, grassTexture),
    //                       Entity(30, 30, grassTexture),
    //                       Entity(30, 60, grassTexture)};

    std::vector<Entity> entitiees = {Entity(Vector2f(0, 0), grassTexture, Vector2f(32, 32)),
                         			 Entity(Vector2f(30, 0), grassTexture, Vector2f(32, 32)),
                          			 Entity(Vector2f(30, 30), grassTexture, Vector2f(32, 32)),
                          			 Entity(Vector2f(30, 60), grassTexture, Vector2f(32, 32))};
    {
	    Entity wilson(Vector2f(100, 50), grassTexture, Vector2f(32, 32));

	    entitiees.push_back(wilson);
	
	}

	Entity main_page(Vector2f(0, 0), window.loadTexture("res/UI/main_page.png"), Vector2f(500, 475));


	bool gameRunning = true;

	SDL_Event event;

	GameState gameState = main_menu;

	while (gameRunning)
	{
		// Get our controls and events
		while (SDL_PollEvent(&event))
		{
			if (event.type == SDL_QUIT)
				gameRunning = false;
		}

		window.clear();
		

		/*for (Entity& e : entitiees)
		{ 
			window.render(e);
		}*/

		if(gameState == main_menu){
			window.render(main_page);
		}


		window.display();

	}

	window.cleanUp();
	SDL_Quit();

	return 0;
}