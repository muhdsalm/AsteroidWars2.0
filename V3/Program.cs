//using System;
using SFML.Graphics;
using SFML.Audio;
using SFML.System;
using SFML.Window;

using Utilities;

namespace AsteroidWars
{
    class Program
    {

        enum gamestate
        {
            main_menu, help_menu_controls, help_menu_settings, help_menu_about, my_station, play, pause, gameover
        }

        static void Main(string[] args)
        {


        Random random = new Random();

        SFML.Audio.Music menu_music = new Music("res/sound/menu music/game.menu.music.2.ogg");
        menu_music.Loop = true;

        SFML.Audio.Music in_game_music_before_jupiter_dies = new Music("res/sound/in-game.music.before-jupiter-boss-fight.ogg");
        in_game_music_before_jupiter_dies.Loop = true;

        SFML.Audio.SoundBuffer click_sound_buffer = new SoundBuffer("res/sound/sound effects/game.sound.click.wav");
        SFML.Audio.Sound click_sound = new Sound(click_sound_buffer);

        SFML.Audio.SoundBuffer fire_sound_buffer = new SoundBuffer("res/sound/sound effects/in-game.sound.laser.shoot.wav");
        SFML.Audio.Sound fire_sound = new Sound(fire_sound_buffer);
        fire_sound.Volume = 10;
        

        Texture[,] backgrounds_tex = new Texture[9,9];
        Sprite[,] backgrounds = new Sprite[9,9];
        
        uint windoww = 721;
        uint windowh = 700;
        RenderWindow window = new RenderWindow(new VideoMode(windoww, windowh), "Asteroid Wars Alpha 4.2", Styles.Close);
        window.Position = new Vector2i(0, 0);
        window.SetFramerateLimit(60);
        window.Closed += (sender, e) => { window.Close(); };
        
        Menu main_page = new Menu("res/UI/main_page_small.png");

        Menu help_page_controls = new Menu("res/UI/Help UI/controls_page_small.png");

        Menu help_page_settings = new Menu("res/UI/Help UI/settings_page_small.png");

        Menu help_page_about = new Menu("res/UI/Help UI/info_page_small.png");

        Menu my_staion = new Menu("res/UI/my station UI/my_station_UI_small.png");

        Menu pause_page = new Menu("res/UI/pause_menu_page_small.png");

        Menu game_over_page = new Menu("res/UI/game_over_page_small.png");

        List<Bullet> bullets = new List<Bullet>{};
        bool ChangeBulletTexture = false;
        bool canFire = true;
        
        int spamLimit = 15;
        int spam = spamLimit;
        Clock spamTimer = new Clock();
        RectangleShape SpamCounter = new RectangleShape(new Vector2f(10, 50));
        SpamCounter.Position = new Vector2f(0, 0);

        int points = 0;
        int currentAsteroidPointCounter = 1;

        List<Asteroid> asteroids = new List<Asteroid>{};
        bool changeAsteroidTexture = false;
        int maxAsteroidDelay = 1000;
        int asteroidSpawnTime = random.Next() % maxAsteroidDelay + 1;
        Clock asteroidTimer = new Clock();
        float asteroidspeed = 10.0f;

        Player default_rocket = new Player();
        default_rocket.SetTexture("res/Rockets/default rocket/default_rocket_small.png");
        default_rocket.GetSprite().Position = new Vector2f(360, 350);

        Font font = new Font("res/fonts/fixedsys.ttf");
        Text pointText = new Text();


        gamestate gamestate = gamestate.main_menu;

        Clock clock = new Clock();

        window.MouseButtonPressed += (sender, e) => {
                if (gamestate == gamestate.main_menu){
                    if (e.Button == Mouse.Button.Left)
                    {
                        if(Mouse.GetPosition(window).X > 325 && Mouse.GetPosition(window).X < 415){
                        if(Mouse.GetPosition().Y > 277 && Mouse.GetPosition(window).Y < 323)
                        {

                            click_sound.Play();

                            for(int i = 0; i < 9; i++){
                                for(int j = 0; j < 9; j++){
                                    backgrounds_tex[i,j] = new Texture("res/in game background/space" + random.Next(1, 5) + ".png");
                                    backgrounds[i,j] = new Sprite(backgrounds_tex[i,j]);
                                    backgrounds[i,j].Position = new Vector2f(i * 80, j * 80);

                                }
                            }
                            bullets.Clear();
                            ChangeBulletTexture = false;
                            canFire = true;
                            
                            spamLimit = 15;
                            spam = spamLimit;

                            asteroids.Clear();
                            changeAsteroidTexture = false;
                            asteroidSpawnTime = random.Next() % maxAsteroidDelay + 1;

                            points = 0;
                            currentAsteroidPointCounter = 1;

                            default_rocket.setSpriteLocation(new Vector2f(260, 350));

                            gamestate = gamestate.play;
                            menu_music.Stop();
                            asteroidTimer.Restart();
                            spamTimer.Restart();
                            in_game_music_before_jupiter_dies.Play();
                        }
                        if(Mouse.GetPosition(window).Y > 370 && Mouse.GetPosition(window).Y < 415){
                            click_sound.Play();
                            gamestate = gamestate.help_menu_controls;
                        }
                        if(Mouse.GetPosition(window).Y > 460 && Mouse.GetPosition(window).Y < 508){
                            click_sound.Play();
                            window.Close();
                        }
                    }
                    if(Mouse.GetPosition(window).X > 546 && Mouse.GetPosition(window).Y < 703){
                        if(Mouse.GetPosition(window).Y > 643 && Mouse.GetPosition(window).Y < 690){
                            click_sound.Play();
                            gamestate = gamestate.my_station;
                        }
                    }
                    }
                }
                else if(gamestate == gamestate.my_station)
                {
                    if(e.Button == Mouse.Button.Left){
                        if(Mouse.GetPosition(window).X > 620 && Mouse.GetPosition(window).X < 720){
                            if(Mouse.GetPosition(window).Y > 657 && Mouse.GetPosition(window).Y < 700){
                                click_sound.Play();
                                gamestate = gamestate.main_menu;
                            }
                        }
                    }
                }
                else if(gamestate == gamestate.help_menu_controls || gamestate == gamestate.help_menu_settings || gamestate == gamestate.help_menu_about)
                {
                    if (e.Button == Mouse.Button.Left)
                    {
                        //buttonwidth = 0, 127
                        //controlsbuttonheight = 0, 42
                        //settingsbuttonheight = 42, 95
                        //infobuttonheight = 95, 150

                        if(Mouse.GetPosition(window).X > 0 && Mouse.GetPosition(window).X < 127){
                            if(Mouse.GetPosition(window).Y > 0 && Mouse.GetPosition(window).Y < 42){
                                click_sound.Play();
                                gamestate = gamestate.help_menu_controls;
                            }
                            if(Mouse.GetPosition(window).Y > 42 && Mouse.GetPosition(window).Y < 95){
                                click_sound.Play();
                                gamestate = gamestate.help_menu_settings;
                            }
                            if(Mouse.GetPosition(window).Y > 95 && Mouse.GetPosition(window).Y < 150){
                                click_sound.Play();
                                gamestate = gamestate.help_menu_about;
                            }
                        }
                        if(Mouse.GetPosition(window).X > 620 && Mouse.GetPosition(window).X < 720){
                            if(Mouse.GetPosition(window).Y > 657 && Mouse.GetPosition(window).Y < 700){
                                click_sound.Play();
                                gamestate = gamestate.main_menu;
                            }
                        }
                    }
                    
                }
                

                };

                window.KeyPressed += (sender, e) => {
                    if (gamestate == gamestate.play)
                    {
                        
                        default_rocket.Keypress(e);
                        if (e.Code == Keyboard.Key.Space)
                        {
                            if (canFire)
                            {
                                fire_sound.Play();
                                bullets.Add(new Bullet());
                                bullets[bullets.Count() - 1].Spawn(default_rocket);
                                ChangeBulletTexture = true;
                                spam--;
                                canFire = false;
                            }
                            
                            
                            
                        }
                            
                            
                            
                            

                    }
                    else if(gamestate == gamestate.help_menu_controls || gamestate == gamestate.help_menu_settings || gamestate == gamestate.help_menu_about)
                    {
                        if (e.Code == Keyboard.Key.Escape)
                        {
                            click_sound.Play();
                            gamestate = gamestate.main_menu;
                        }
                    }
                };

                window.KeyReleased += (sender, e) => {

                    if (e.Code == Keyboard.Key.Space)
                    {
                        canFire = true;
                    }

                };

        menu_music.Play();
        while (window.IsOpen)
        {
            clock.Restart();

            window.DispatchEvents();
                            
            
            window.Clear(Color.Black);

            if (gamestate == gamestate.main_menu)
            {
                window.Draw(main_page.GetSprite());
            }
            if (gamestate == gamestate.help_menu_controls)
            {
                window.Draw(help_page_controls.GetSprite());
            }
            if (gamestate == gamestate.help_menu_settings)
            {
                window.Draw(help_page_settings.GetSprite());
            }
            if (gamestate == gamestate.help_menu_about)
            {
                window.Draw(help_page_about.GetSprite());
            }
            if (gamestate == gamestate.my_station)
            {
                window.Draw(my_staion.GetSprite());
            }
            if(gamestate == gamestate.play)
            {
                for(int i = 0; i < 9; i++){
                    for(int j = 0; j < 9; j++){
                        window.Draw(backgrounds[i,j]);
                        //return 1;
                    }
                }

                default_rocket.Update();

                for (int i = 0; i < bullets.Count(); i++)
                {
                    Bullet bullet = bullets[i];
                
                    bullet.Update();


                    if (bullet.GetSprite().Position.Y < 0 )
                    {
                        bullets.Remove(bullet);
                        ChangeBulletTexture = true;
                        /*for (Bullet& bullet : bullets)
                        {
                            bullet.SetTexture("res/icons/rocket_laser.png");
                        }*/
                        
                    }

                    if (ChangeBulletTexture)
                    {
                        bullet.SetTexture("res/icons/rocket_laser.png");
                    }
                    window.Draw(bullet.GetSprite());
                }
                if (asteroidTimer.ElapsedTime.AsMilliseconds() > asteroidSpawnTime)
                    {
                        asteroids.Add(new Asteroid(asteroidspeed));
                        changeAsteroidTexture = true;
                        asteroidTimer.Restart();
                        asteroidSpawnTime = random.Next() % maxAsteroidDelay + 1;

                    }
                for (int i = 0; i < asteroids.Count(); i++)
                {
                    Asteroid asteroid = asteroids[i];
            
                    asteroid.Update();

                    if (Utils.IsColliding(asteroid, default_rocket))
                    {
                        gamestate = gamestate.gameover;
                    }
                    

                    

                    for (int j = 0; j < bullets.Count(); j++)
                    {
                        if (Utils.IsColliding(bullets[j], asteroid))
                        {
                            asteroids.Remove(asteroid);
                            changeAsteroidTexture = true;

                            points += 5;
                        }
                    }
                    

                    if (asteroid.GetSprite().Position.Y > 700 )
                    {
                        asteroids.Remove(asteroid);
                        changeAsteroidTexture = true;
                        
                        /*for (Bullet& bullet : bullets)
                        {
                            bullet.SetTexture("res/icons/rocket_laser.png");
                        }*/
                        
                    }
                    if (changeAsteroidTexture)
                    {
                        asteroid.SetTexture("res/Asteroids/asteroid.png");
                    }
                    window.Draw(asteroid.GetSprite());
                }

                if (points / currentAsteroidPointCounter >= 100)
                {
                    asteroidspeed += 1;
                    currentAsteroidPointCounter += 1;
                    
                }
                


                window.Draw(default_rocket.GetSprite());
                changeAsteroidTexture = false;

                if (spamTimer.ElapsedTime.AsMilliseconds() > 500)
                {
                    points += 1;
                    ++spam;

                    if (spam > spamLimit)
                    {
                        spam = spamLimit;
                    }
                    

                    spamTimer.Restart();
                }
                SpamCounter.Scale = new Vector2f(spam, 1);

                if (spam > 10)
                {
                    SpamCounter.FillColor = Color.Green;
                }
                else if (spam > 5)
                {
                    SpamCounter.FillColor = Color.Yellow;
                }else
                {
                    SpamCounter.FillColor = Color.Red;
                }
                if (spam <= 0)
                {

                    gamestate = gamestate.gameover;
                }
                
                window.Draw(SpamCounter);

                pointText = new Text(points.ToString(), font);
                pointText.Position = new Vector2f(650, 0);
                pointText.FillColor = Color.Yellow;


                window.Draw(pointText);

                
            }

            if (gamestate==gamestate.gameover)
            {
                in_game_music_before_jupiter_dies.Stop();
                window.Draw(game_over_page.GetSprite());
            }


            window.Display();

            Thread.Sleep(17);
        }
        }
    }
}