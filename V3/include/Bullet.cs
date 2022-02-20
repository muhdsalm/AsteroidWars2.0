using System;
using SFML.Audio;
using SFML.Graphics;
using SFML.System;
using SFML.Window;

using AsteroidWars;

class Bullet : Entity
{

    public Bullet() : base("res/icons/rocket_laser.png")
    {}

    private float x, y;

    public void Spawn(Player player)
    {
        Vector2f pos = new Vector2f(player.GetSprite().Position.X + 12f, player.GetSprite().Position.Y);

        setSpriteLocation(pos);

    }

    new public void Update()
    {

        moveSprite(new Vector2f(0, -10));

    }


}