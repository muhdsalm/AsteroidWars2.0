using System;
using SFML.Audio;
using SFML.Graphics;
using SFML.System;
using SFML.Window;

using AsteroidWars;

class Asteroid : Entity{
    int x;
    Random random = new Random();

    public float speed = 10.0f;

    public Asteroid(float p_speed) : base("res/Asteroids/asteroid.png")
    {
        speed = p_speed;

        int Loc = random.Next(0, 670);

        SetTexture("res/Asteroids/asteroid.png");
        setSpriteLocation(new Vector2f(Loc, -50));
    }

    new public void Update()
    {   

        moveSprite(new Vector2f(0, speed));

    }

};