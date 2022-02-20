using System;
using SFML.Audio;
using SFML.Graphics;
using SFML.System;
using SFML.Window;

using AsteroidWars;

class Menu : Entity
{
    private Texture menu_tex;
    private Sprite menu;

    public Menu(string path) : base(path)
    {    
        menu_tex = new Texture(path);
        menu = new Sprite(menu_tex);
    }

    new public Sprite GetSprite(){
        return menu;
    }
}