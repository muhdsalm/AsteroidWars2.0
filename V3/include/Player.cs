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

        if (p_event.Code == Keyboard.Key.Left)
        {
            x = -10;
        }
        if (p_event.Code == Keyboard.Key.Right)
        {
            x = 10;
        }
        if (p_event.Code == Keyboard.Key.Up)
        {
            y = -10;
        }
        if (p_event.Code == Keyboard.Key.Down)
        {
            y = 10;
        }
        
        
        

    }

    new public void Update(){


        moveSprite(new Vector2f(x, y));
            if (!(Keyboard.IsKeyPressed(Keyboard.Key.Left)))
        {
            if (x < 0)
            {
                x = 0;
            }
        }
        if (!(Keyboard.IsKeyPressed(Keyboard.Key.Right)))
        {
            if (x > 0)
            {
                x = 0;
            }
            
        }
        if (!(Keyboard.IsKeyPressed(Keyboard.Key.Up)))
        {
            if (y < 0)
            {
                y = 0;
            }
            
        }
        if (!(Keyboard.IsKeyPressed(Keyboard.Key.Down)))
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