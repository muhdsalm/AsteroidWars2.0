using System;
using SFML.Audio;
using SFML.Graphics;
using SFML.System;
using SFML.Window;

using AsteroidWars;

class Player : Entity{

    private float x;
    private float y;

    public Player() : base("res/Rockets/default rocket/default_rocket_small.png")
    {}

        
    public void Keypress(KeyEventArgs p_event)
    {

        if (p_event.Code == Keyboard.Key.Left || p_event.Code == Keyboard.Key.A)
        {
            x = -10;
        }
        if (p_event.Code == Keyboard.Key.Right || p_event.Code == Keyboard.Key.D)
        {
            x = 10;
        }
        if (p_event.Code == Keyboard.Key.Up || p_event.Code == Keyboard.Key.W)
        {
            y = -10;
        }
        if (p_event.Code == Keyboard.Key.Down || p_event.Code == Keyboard.Key.S)
        {
            y = 10;
        }
        
        
        

    }

    new public void Update(){


        moveSprite(new Vector2f(x, y));
            if (!(Keyboard.IsKeyPressed(Keyboard.Key.Left) || Keyboard.IsKeyPressed(Keyboard.Key.A)))
        {
            if (x < 0)
            {
                x = 0;
            }
        }
        if (!(Keyboard.IsKeyPressed(Keyboard.Key.Right) || Keyboard.IsKeyPressed(Keyboard.Key.D)))
        {
            if (x > 0)
            {
                x = 0;
            }
            
        }
        if (!(Keyboard.IsKeyPressed(Keyboard.Key.Up) || Keyboard.IsKeyPressed(Keyboard.Key.W)))
        {
            if (y < 0)
            {
                y = 0;
            }
            
        }
        if (!(Keyboard.IsKeyPressed(Keyboard.Key.Down) || Keyboard.IsKeyPressed(Keyboard.Key.S)))
        {
            if (y > 0)
            {
                y = 0;
            }
            
        }

        if (GetSprite().GetGlobalBounds().Left < 0)
        {
            SetDefiniteX(0);
        }
        else if (GetSprite().GetGlobalBounds().Top < 0)
        {
            SetDefiniteY(0);
        }
        else if (GetSprite().GetGlobalBounds().Left > 684)
        {
            SetDefiniteX(684);
        }
        else if (GetSprite().GetGlobalBounds().Top > 613)
        {
            SetDefiniteY(613);
        }
        

    }

}