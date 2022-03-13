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


        Texture[] intro_tex = new Texture[180];
        Sprite[] intro = new Sprite[180];

        for (int i = 1; i < 180; i++)
        {
            intro_tex[i] = new Texture("res/intro/new_folder/" + i + ".png");
            intro[i] = new Sprite(intro_tex[i]);
            intro[i].Position = new Vector2f(0, 157.5f);
        }

        uint windoww = 721;
        uint windowh = 700;
        RenderWindow window = new RenderWindow(new VideoMode(windoww, windowh), "Asteroid Wars Alpha 4.2", Styles.Close);
        window.Position = new Vector2i(0, 0);
        window.SetFramerateLimit(60);
        window.Closed += (sender, e) => { window.Close(); };

        window.Clear(Color.Black);

        /*Music introMusic = new Music("res/sound/Asteroid_wars_intro.wav");
        //introMusic.PlayingOffset = Time.FromMilliseconds(7000);

        introMusic.Play();


        for (int i = 1; i < 180; i++)
        {
            window.Draw(intro[i]);
            window.Display();
            window.DispatchEvents();
            //Thread.Sleep(34);
            Thread.Sleep(100);

            if (!(window.IsOpen))
            {
                return;
            }
        }*/

        //GC.TryStartNoGCRegion(1);

        Random random = new Random();

        bool musicIsOn = true;
        bool soundIsOn = true;

        SFML.Audio.Music menu_music = new Music("res/sound/menu music/game.menu.music.2.ogg");
        menu_music.Loop = true;

        SFML.Audio.Music in_game_music_before_jupiter_dies = new Music("res/sound/in-game.music.before-jupiter-boss-fight.ogg");
        in_game_music_before_jupiter_dies.Loop = true;

        SFML.Audio.SoundBuffer click_sound_buffer = new SoundBuffer("res/sound/sound effects/game.sound.click.wav");
        SFML.Audio.Sound click_sound = new Sound(click_sound_buffer);

        SFML.Audio.SoundBuffer fire_sound_buffer = new SoundBuffer("res/sound/sound effects/in-game.sound.laser.shoot.wav");
        SFML.Audio.Sound fire_sound = new Sound(fire_sound_buffer);
        fire_sound.Volume = 10;
        
        

        Texture[,] backgrounds_tex = new Texture[9,10];
        Sprite[,] backgrounds = new Sprite[9,10];
        
        CircleShape[] stars = new CircleShape[20];
        for (int i = 0; i < 20; i++)
        {
            stars[i] = new CircleShape(2);
            stars[i].FillColor = Color.White;
        }
        
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

        
        RectangleShape soundSetRect = new RectangleShape(new Vector2f(120, 30));
        Text soundSetText = new Text(soundIsOn.ToString(), font);
        Text soundLabel = new Text("Sound: ", font);

        soundLabel.Position = new Vector2f(260, 106);

        if(soundIsOn){
            soundSetText = new Text("ON".ToString(), font);
            soundSetRect.Position = new Vector2f(360, 111);
            soundSetRect.OutlineColor = Color.Green;
            soundSetRect.OutlineThickness = 1;
            soundSetRect.FillColor = Color.Transparent;

            soundSetText.Position = new Vector2f(360, 106);
            soundSetText.FillColor = Color.Green;
        }else{
            soundSetText = new Text("OFF".ToString(), font);
            soundSetRect.Position = new Vector2f(360, 111);
            soundSetRect.OutlineColor = Color.Red;
            soundSetRect.OutlineThickness = 1;
            soundSetRect.FillColor = Color.Transparent;

            soundSetText.Position = new Vector2f(360, 106);
            soundSetText.FillColor = Color.Red;
        }


        RectangleShape musicSetRect = new RectangleShape(new Vector2f(120, 30));
        Text musicSetText = new Text(musicIsOn.ToString(), font);
        Text musicLabel = new Text("Music: ", font);

        musicLabel.Position = new Vector2f(265, 166);

        if(musicIsOn){
            musicSetText = new Text("ON".ToString(), font);
            musicSetRect.Position = new Vector2f(360, 171);
            musicSetRect.OutlineColor = Color.Green;
            musicSetRect.OutlineThickness = 1;
            musicSetRect.FillColor = Color.Transparent;

            musicSetText.Position = new Vector2f(360, 166);
            musicSetText.FillColor = Color.Green;
        }else{
            musicSetText = new Text("OFF".ToString(), font);
            musicSetRect.Position = new Vector2f(360, 171);
            musicSetRect.OutlineColor = Color.Red;
            musicSetRect.OutlineThickness = 1;
            musicSetRect.FillColor = Color.Transparent;

            musicSetText.Position = new Vector2f(360, 166);
            musicSetText.FillColor = Color.Red;
        }


        gamestate gamestate = gamestate.main_menu;

        Clock clock = new Clock();

        window.MouseMoved += (sender, e) => {

            Console.WriteLine("Mouse : (" + Mouse.GetPosition(window).X + ", " + Mouse.GetPosition(window).Y + ")");

        };

        window.MouseButtonPressed += (sender, e) => {
                if (gamestate == gamestate.main_menu){
                    if (e.Button == Mouse.Button.Left)
                    {
                        if(Mouse.GetPosition(window).X > 325 && Mouse.GetPosition(window).X < 415){
                        if(Mouse.GetPosition().Y > 277 && Mouse.GetPosition(window).Y < 323)
                        {

                            if (soundIsOn){
                                click_sound.Play();
                            }

                            for(int i = 0; i < 9; i++){
                                for(int j = 0; j < 10; j++){
                                    backgrounds_tex[i,j] = new Texture("res/in game background/space" + random.Next(1, 5) + ".png");
                                    backgrounds[i,j] = new Sprite(backgrounds_tex[i,j]);
                                    backgrounds[i,j].Position = new Vector2f(i * 80, j * 80);

                                }
                            }

                            in_game_music_before_jupiter_dies.PlayingOffset = Time.Zero;

                            bullets.Clear();
                            ChangeBulletTexture = false;
                            canFire = true;
                            
                            spamLimit = 15;
                            spam = spamLimit;

                            asteroids.Clear();
                            changeAsteroidTexture = false;
                            asteroidSpawnTime = random.Next() % maxAsteroidDelay + 1;
                            asteroidspeed = 10;

                            points = 0;
                            currentAsteroidPointCounter = 1;

                            default_rocket.setSpriteLocation(new Vector2f(360, 350));

                            gamestate = gamestate.play;
                            menu_music.Stop();
                            asteroidTimer.Restart();
                            spamTimer.Restart();
                            if (musicIsOn){
                                in_game_music_before_jupiter_dies.Play();
                            }
                        }
                        if(Mouse.GetPosition(window).Y > 370 && Mouse.GetPosition(window).Y < 415){
                            if (soundIsOn){
                                click_sound.Play();
                            }

                            gamestate = gamestate.help_menu_controls;

                            

                        }
                        if(Mouse.GetPosition(window).Y > 460 && Mouse.GetPosition(window).Y < 508){
                            if (soundIsOn){
                                click_sound.Play();
                            }
                            window.Close();
                        }
                    }
                    if(Mouse.GetPosition(window).X > 546 && Mouse.GetPosition(window).Y < 703){
                        if(Mouse.GetPosition(window).Y > 643 && Mouse.GetPosition(window).Y < 690){
                            if (soundIsOn){
                                click_sound.Play();
                            }
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
                                if (soundIsOn){
                                click_sound.Play();
                                }
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
                                if (soundIsOn){
                                click_sound.Play();
                                }
                                gamestate = gamestate.help_menu_controls;
                            }
                            if(Mouse.GetPosition(window).Y > 42 && Mouse.GetPosition(window).Y < 95){
                                if (soundIsOn){
                                click_sound.Play();
                                }
                                gamestate = gamestate.help_menu_settings;
                                for (int i = 0; i < 20; i++)
                                {
                                    stars[i].Position = new Vector2f(random.Next(127, 720), random.Next(0, 700));
                                    Console.WriteLine("Stars[" + i + "]: " + stars[i].Position.X + ", " + stars[i].Position.Y);
                                }
                            }
                            if(Mouse.GetPosition(window).Y > 95 && Mouse.GetPosition(window).Y < 150){
                                if (soundIsOn){
                                click_sound.Play();
                                }
                                gamestate = gamestate.help_menu_about;
                            }
                        }
                        if(Mouse.GetPosition(window).X > 620 && Mouse.GetPosition(window).X < 720){
                            if(Mouse.GetPosition(window).Y > 657 && Mouse.GetPosition(window).Y < 700){
                                if (soundIsOn){
                                click_sound.Play();
                                }
                                gamestate = gamestate.main_menu;
                            }
                        }
                    }
                    
                }

                if (gamestate == gamestate.help_menu_settings)
                {
                    if (Mouse.GetPosition(window).X > 360 && Mouse.GetPosition(window).X < 357)
                    {
                        if (Mouse.GetPosition(window).Y > 171 && Mouse.GetPosition(window).Y < 201)
                        {
                            
                            if (soundIsOn)
                            {
                                click_sound.Play();
                            }

                            musicIsOn = !musicIsOn;

                            if (!musicIsOn)
                            {
                                menu_music.Stop();
                                in_game_music_before_jupiter_dies.Stop();
                            }else{
                                menu_music.Play();
                            }


                            if(musicIsOn){
                                musicSetText = new Text("ON".ToString(), font);
                                musicSetRect.Position = new Vector2f(360, 171);
                                musicSetRect.OutlineColor = Color.Green;
                                musicSetRect.OutlineThickness = 1;
                                musicSetRect.FillColor = Color.Transparent;

                                musicSetText.Position = new Vector2f(265, 166);
                                musicSetText.FillColor = Color.Green;
                            }else{
                                musicSetText = new Text("OFF".ToString(), font);
                                musicSetRect.Position = new Vector2f(360, 171);
                                musicSetRect.OutlineColor = Color.Red;
                                musicSetRect.OutlineThickness = 1;
                                musicSetRect.FillColor = Color.Transparent;

                                musicSetText.Position = new Vector2f(360, 166);
                                musicSetText.FillColor = Color.Red;
                            }
                        }

                        if (Mouse.GetPosition(window).Y > 111 && Mouse.GetPosition(window).Y < 141)
                        {

                            if (soundIsOn)
                            {
                                click_sound.Play();
                            }

                            soundIsOn = !soundIsOn;
                            if(soundIsOn){
                                soundSetText = new Text("ON".ToString(), font);
                                soundSetRect.Position = new Vector2f(360, 111);
                                soundSetRect.OutlineColor = Color.Green;
                                soundSetRect.OutlineThickness = 1;
                                soundSetRect.FillColor = Color.Transparent;

                                soundSetText.Position = new Vector2f(265, 106);
                                soundSetText.FillColor = Color.Green;
                            }else{
                                soundSetText = new Text("OFF".ToString(), font);
                                soundSetRect.Position = new Vector2f(360, 111);
                                soundSetRect.OutlineColor = Color.Red;
                                soundSetRect.OutlineThickness = 1;
                                soundSetRect.FillColor = Color.Transparent;

                                soundSetText.Position = new Vector2f(360, 106);
                                soundSetText.FillColor = Color.Red;
                            }
                        }
                    }


                }

                else if (gamestate == gamestate.gameover)
                {
                    if (Mouse.GetPosition(window).X > 121 && Mouse.GetPosition(window).X < 398)
                    {
                        Console.WriteLine("XD");
                        if (Mouse.GetPosition(window).Y > 574 && Mouse.GetPosition(window).Y < 637)
                        {
                            Console.WriteLine("YD");

                            if (soundIsOn){

                            click_sound.Play();
                            }

                            for(int i = 0; i < 9; i++){
                                for(int j = 0; j < 10; j++){
                                    backgrounds_tex[i,j] = new Texture("res/in game background/space" + random.Next(1, 5) + ".png");
                                    backgrounds[i,j] = new Sprite(backgrounds_tex[i,j]);
                                    backgrounds[i,j].Position = new Vector2f(i * 80, j * 80);

                                }
                            }


                            asteroidspeed = 10;

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

                            default_rocket.setSpriteLocation(new Vector2f(360, 350));

                            gamestate = gamestate.play;
                            menu_music.Stop();
                            asteroidTimer.Restart();
                            spamTimer.Restart();

                            if (musicIsOn){
                            in_game_music_before_jupiter_dies.Play();
                            }
                        }
                    }
                }

                else if (gamestate==gamestate.pause)
                {
                    if (Mouse.GetPosition(window).X > 228 && Mouse.GetPosition(window).X < 460)
                    {
                        if (Mouse.GetPosition(window).Y > 238 && Mouse.GetPosition(window).Y < 301)
                        {
                            if (soundIsOn){
                            click_sound.Play();
                            }
                            gamestate=gamestate.play;

                            if (musicIsOn){
                            in_game_music_before_jupiter_dies.Play();
                            }
                        }
                    }

                    if (Mouse.GetPosition(window).X > 195 && Mouse.GetPosition(window).X < 500)
                    {
                        if (Mouse.GetPosition(window).Y > 388 && Mouse.GetPosition(window).Y < 463)
                        {
                            if (soundIsOn){
                            click_sound.Play();
                            }
                            if(musicIsOn){
                            menu_music.Play();
                            }
                            gamestate=gamestate.help_menu_settings;
                        }
                    }

                    if (Mouse.GetPosition(window).X > 153 && Mouse.GetPosition(window).X < 540)
                    {
                        if (Mouse.GetPosition(window).Y > 558 && Mouse.GetPosition(window).Y < 643)
                        {
                            if (soundIsOn){
                            click_sound.Play();
                            }

                            if (musicIsOn){
                            menu_music.Play();
                            }
                            gamestate=gamestate.main_menu;
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
                                if (soundIsOn){
                                fire_sound.Play();
                                }
                                bullets.Add(new Bullet());
                                bullets[bullets.Count() - 1].Spawn(default_rocket);
                                ChangeBulletTexture = true;
                                spam--;
                                canFire = false;
                            }
                            
                            
                            
                        }

                        else if (e.Code == Keyboard.Key.P)
                        {
                            gamestate = gamestate.pause;
                            in_game_music_before_jupiter_dies.Pause();
                        }
                            
                            
                            
                            

                    }
                    else if(gamestate == gamestate.help_menu_controls || gamestate == gamestate.help_menu_settings || gamestate == gamestate.help_menu_about)
                    {
                        if (e.Code == Keyboard.Key.Escape)
                        {
                            if (soundIsOn){
                            click_sound.Play();
                            }
                            gamestate = gamestate.main_menu;
                        }
                    }

                    else if (gamestate == gamestate.gameover)
                    {
                        if (e.Code == Keyboard.Key.R)
                        {
                            for(int i = 0; i < 9; i++){
                                for(int j = 0; j < 10; j++){
                                    backgrounds_tex[i,j] = new Texture("res/in game background/space" + random.Next(1, 5) + ".png");
                                    backgrounds[i,j] = new Sprite(backgrounds_tex[i,j]);
                                    backgrounds[i,j].Position = new Vector2f(i * 80, j * 80);

                                }
                            }

                            asteroidspeed = 10;

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

                            default_rocket.setSpriteLocation(new Vector2f(360, 350));

                            gamestate = gamestate.play;
                            menu_music.Stop();
                            asteroidTimer.Restart();
                            spamTimer.Restart();

                            if (musicIsOn){
                            in_game_music_before_jupiter_dies.Play();
                            }
                        }
                    }

                    else if (gamestate==gamestate.pause)
                    {
                        if (e.Code == Keyboard.Key.P)
                        {
                            gamestate=gamestate.play;

                            if (musicIsOn){
                            in_game_music_before_jupiter_dies.Play();
                            }
                        }
                    }

                };

                window.KeyReleased += (sender, e) => {

                    if (e.Code == Keyboard.Key.Space)
                    {
                        canFire = true;
                    }

                };

        //introMusic.Stop();

        if (musicIsOn){
        menu_music.Play();
        }
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
                for (int i = 0; i < 20; i++)
                {
                    window.Draw(stars[i]);
                }

                window.Draw(soundLabel);
                window.Draw(soundSetRect);
                window.Draw(soundSetText);

                window.Draw(musicLabel);
                window.Draw(musicSetRect);
                window.Draw(musicSetText);
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
                    for(int j = 0; j < 10; j++){

                        backgrounds[i,j].Position += new Vector2f(0, 1);

                        if (backgrounds[i, j].Position.Y > windowh)
                        {
                            backgrounds[i, j].Position = new Vector2f(backgrounds[i, j].Position.X, -80);
                        }

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
                    asteroidspeed += ((float)(asteroidspeed * 0.02));
                    currentAsteroidPointCounter += 1;
                    maxAsteroidDelay -= ((int)(maxAsteroidDelay * 0.01));
                    
                }
                


                window.Draw(default_rocket.GetSprite());
                changeAsteroidTexture = false;

                if (spamTimer.ElapsedTime.AsMilliseconds() > 750)
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
                pointText.Position = new Vector2f(625, 0);
                pointText.FillColor = Color.Yellow;
                pointText.CharacterSize = 40;


                window.Draw(pointText);

                
            }

            if (gamestate==gamestate.gameover)
            {
                in_game_music_before_jupiter_dies.Stop();
                window.Draw(game_over_page.GetSprite());

                pointText.Position = new Vector2f(300, 135);
                pointText.CharacterSize = 40;

                window.Draw(pointText);

            }

            if (gamestate==gamestate.pause)
            {
                window.Draw(pause_page.GetSprite());
            }


            window.Display();
            try
            {
                Thread.Sleep(17 - clock.ElapsedTime.AsMilliseconds());
            }catch{
                Console.WriteLine("EXTREME OVERRIDE!!!!");
                Thread.Sleep(17);
            }
        }
        }
    }
}